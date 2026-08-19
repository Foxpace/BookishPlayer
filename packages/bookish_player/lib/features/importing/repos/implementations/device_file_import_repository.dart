import 'dart:io';
import 'dart:isolate';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/foundation/id_generator.dart';
import '../../../../core/platform/file_picker_gateway.dart';
import '../../models/import_cancellation.dart';
import '../file_import_repository.dart';
import '../selected_audio_file.dart';
import 'device_file_copy_worker.dart';

@LazySingleton(as: FileImportRepository)
class DeviceFileImportRepository implements FileImportRepository {
  DeviceFileImportRepository(this._ids, this._picker);

  static const _extensions = [
    'mp3',
    'm4a',
    'm4b',
    'aac',
    'wav',
    'flac',
    'ogg',
    'opus',
  ];

  final IdGenerator _ids;
  final FilePickerGateway _picker;

  @override
  Future<List<SelectedAudioFile>> pickAudioFiles() async {
    final result = await _picker.pickAudioFiles(_extensions);
    if (result == null) {
      return const [];
    }

    final inaccessible = result.files
        .where((file) => file.path == null)
        .map((file) => file.name)
        .toList();
    if (inaccessible.isNotEmpty) {
      throw FileSystemException(
        'The document provider did not expose a readable local copy for: '
        '${inaccessible.join(', ')}',
      );
    }

    return [
      for (final file in result.files)
        if (file.path case final path?)
          SelectedAudioFile(
            sourcePath: path,
            displayName: file.name,
            sizeBytes: file.size,
          ),
    ];
  }

  @override
  Future<void> clearTemporaryFiles() async {
    if (!Platform.isAndroid) {
      return;
    }
    await _picker.clearTemporaryFiles();
  }

  @override
  Future<List<SelectedAudioFile>> findTransferredAudioFiles() async {
    final documents = await getApplicationDocumentsDirectory();
    final files = await documents
        .list(recursive: true, followLinks: false)
        .where((entity) => entity is File)
        .cast<File>()
        .where(
          (file) => _extensions.contains(
            p.extension(file.path).substring(1).toLowerCase(),
          ),
        )
        .toList();
    files.sort((a, b) => a.path.compareTo(b.path));

    return Future.wait(files.map(_selectedTransferredFile));
  }

  Future<SelectedAudioFile> _selectedTransferredFile(File file) async =>
      SelectedAudioFile(
        sourcePath: file.path,
        displayName: p.basename(file.path),
        sizeBytes: await file.length(),
      );

  @override
  Future<ImportedAudioFile> importFile(
    SelectedAudioFile selected, {
    ImportCancellationSignal? cancellation,
    FileCopyProgress? onProgress,
  }) async {
    final support = await getApplicationSupportDirectory();
    final library = Directory(p.join(support.path, 'audiobooks'));
    await library.create(recursive: true);

    final extension = p.extension(selected.displayName).toLowerCase();
    final destination = p.join(library.path, '${_ids.generate()}$extension');

    try {
      await _copySelectedToDestination(
        selected,
        destination,
        cancellation,
        onProgress,
      );
    } on ImportCancelledException {
      await _removeCancelledDestination(destination);
    }

    return ImportedAudioFile(
      path: destination,
      displayName: selected.displayName,
    );
  }

  Future<void> _copySelectedToDestination(
    SelectedAudioFile selected,
    String destination,
    ImportCancellationSignal? cancellation,
    FileCopyProgress? onProgress,
  ) async {
    await copyFileInBackground(
      selected.sourcePath,
      destination,
      cancellation: cancellation,
      onProgress: onProgress,
    );
    cancellation?.throwIfCancelled();
  }

  Future<Never> _removeCancelledDestination(String destination) async {
    await deleteImportedFile(destination);
    throw const ImportCancelledException();
  }

  @override
  Future<void> removeTransferredAudioFiles(
    List<SelectedAudioFile> files,
  ) async {
    for (final selected in files) {
      final file = File(selected.sourcePath);
      if (file.existsSync()) {
        await file.delete();
      }
    }
  }

  @override
  Future<String?> pickAndImportCover(String bookId) async {
    final result = await _picker.pickImage();
    final sourcePath = result?.files.single.path;
    if (sourcePath == null) {
      return null;
    }
    final support = await getApplicationSupportDirectory();
    final directory = Directory(p.join(support.path, 'covers'));
    await directory.create(recursive: true);
    final extension = p.extension(sourcePath).toLowerCase();
    final destination = p.join(directory.path, '$bookId$extension');
    await File(sourcePath).copy(destination);
    return destination;
  }

  @override
  Future<void> deleteImportedFile(String path) async {
    final file = File(path);
    if (file.existsSync()) {
      await file.delete();
    }
  }
}

Future<void> copyFileInBackground(
  String sourcePath,
  String destinationPath, {
  ImportCancellationSignal? cancellation,
  FileCopyProgress? onProgress,
}) async {
  final partialPath = '$destinationPath.part';
  final messages = ReceivePort();
  final isolate = await Isolate.spawn(
    copyFileWorker,
    _copyRequest(sourcePath, destinationPath, partialPath, messages.sendPort),
    debugName: 'bookish-file-copy',
    onError: messages.sendPort,
    onExit: messages.sendPort,
  );

  try {
    await Future.any([
      _receiveCopyMessages(messages, sourcePath, onProgress),
      if (cancellation case final signal?)
        signal.whenCancelled.then<void>(
          (_) => throw const ImportCancelledException(),
        ),
    ]);
  } finally {
    messages.close();
    isolate.kill(priority: Isolate.immediate);
    _deletePartialCopy(partialPath);
    if (cancellation?.isCancelled == true) {
      _deleteCancelledCopy(destinationPath);
    }
  }
}

FileCopyRequest _copyRequest(
  String sourcePath,
  String destinationPath,
  String partialPath,
  SendPort sendPort,
) => (
  sourcePath: sourcePath,
  destinationPath: destinationPath,
  partialPath: partialPath,
  sendPort: sendPort,
);

void _deletePartialCopy(String partialPath) {
  final partial = File(partialPath);
  if (partial.existsSync()) {
    partial.deleteSync();
  }
}

void _deleteCancelledCopy(String destinationPath) {
  final destination = File(destinationPath);
  if (destination.existsSync()) {
    destination.deleteSync();
  }
}

Future<void> _receiveCopyMessages(
  ReceivePort messages,
  String sourcePath,
  FileCopyProgress? onProgress,
) async {
  await for (final message in messages) {
    final complete = _handleCopyMessage(message, sourcePath, onProgress);
    if (complete) {
      return;
    }
  }

  throw FileSystemException(
    'The background copy stopped unexpectedly.',
    sourcePath,
  );
}

bool _handleCopyMessage(
  Object? message,
  String sourcePath,
  FileCopyProgress? onProgress,
) {
  if (message case (
    copiedBytes: final int copiedBytes,
    totalBytes: final int totalBytes,
  )) {
    onProgress?.call(copiedBytes, totalBytes);
    return false;
  }

  if (message == FileCopySignal.complete) {
    return true;
  }
  if (message case final String errorMessage) {
    throw FileSystemException(errorMessage, sourcePath);
  }
  if (message is List && message.isNotEmpty) {
    throw FileSystemException(
      'The background copy isolate failed: ${message.first}',
      sourcePath,
    );
  }
  if (message == null) {
    throw FileSystemException(
      'The background copy stopped unexpectedly.',
      sourcePath,
    );
  }

  return false;
}
