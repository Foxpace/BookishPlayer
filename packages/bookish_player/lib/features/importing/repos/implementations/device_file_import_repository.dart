import 'dart:io';
import 'dart:isolate';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/foundation/result.dart';
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
  Future<Result<List<SelectedAudioFile>>> pickAudioFiles() async {
    try {
      final result = await _picker.pickAudioFiles(_extensions);
      if (result == null) {
        return const Result.success([]);
      }

      final inaccessible = result.files.any((file) => file.path == null);
      if (inaccessible) {
        return const Result.failure(
          AppFailure.operationFailed('import.fileAccess'),
        );
      }

      return Result.success([
        for (final file in result.files)
          if (file.path case final path?)
            SelectedAudioFile(
              sourcePath: path,
              displayName: file.name,
              sizeBytes: file.size,
            ),
      ]);
    } catch (error) {
      return Result.failure(
        AppFailure.operationFailed('import.fileAccess', error: error),
      );
    }
  }

  @override
  Future<void> clearTemporaryFiles() async {
    if (!Platform.isAndroid) {
      return;
    }
    await _picker.clearTemporaryFiles();
  }

  @override
  Future<Result<List<SelectedAudioFile>>> findTransferredAudioFiles() async {
    try {
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

      return Result.success(
        await Future.wait(files.map(_selectedTransferredFile)),
      );
    } catch (error) {
      return Result.failure(
        AppFailure.operationFailed('import.fileAccess', error: error),
      );
    }
  }

  Future<SelectedAudioFile> _selectedTransferredFile(File file) async =>
      SelectedAudioFile(
        sourcePath: file.path,
        displayName: p.basename(file.path),
        sizeBytes: await file.length(),
      );

  @override
  Future<Result<ImportedAudioFile>> importFile(
    SelectedAudioFile selected, {
    ImportCancellationSignal? cancellation,
    FileCopyProgress? onProgress,
  }) async {
    try {
      final support = await getApplicationSupportDirectory();
      final library = Directory(p.join(support.path, 'audiobooks'));
      await library.create(recursive: true);

      final extension = p.extension(selected.displayName).toLowerCase();
      final destination = p.join(library.path, '${_ids.generate()}$extension');

      final copy = await copyFileInBackground(
        selected.sourcePath,
        destination,
        cancellation: cancellation,
        onProgress: onProgress,
      );
      if (copy case ResultFailure(:final failure)) {
        await deleteImportedFile(destination);
        return Result.failure(failure);
      }
      return Result.success(
        ImportedAudioFile(path: destination, displayName: selected.displayName),
      );
    } catch (error) {
      return Result.failure(
        AppFailure.operationFailed('import.fileAccess', error: error),
      );
    }
  }

  @override
  Future<Result<bool>> removeTransferredAudioFiles(
    List<SelectedAudioFile> files,
  ) async {
    try {
      for (final selected in files) {
        final file = File(selected.sourcePath);
        if (file.existsSync()) {
          await file.delete();
        }
      }
      return const Result.success(true);
    } catch (error) {
      return Result.failure(
        AppFailure.operationFailed('import.sourceRemoval', error: error),
      );
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

Future<Result<bool>> copyFileInBackground(
  String sourcePath,
  String destinationPath, {
  ImportCancellationSignal? cancellation,
  FileCopyProgress? onProgress,
}) => _BackgroundFileCopy(
  sourcePath: sourcePath,
  destinationPath: destinationPath,
  cancellation: cancellation,
  onProgress: onProgress,
).run();

class _BackgroundFileCopy {
  _BackgroundFileCopy({
    required this.sourcePath,
    required this.destinationPath,
    required this.cancellation,
    required this.onProgress,
  });

  final String sourcePath;
  final String destinationPath;
  final ImportCancellationSignal? cancellation;
  final FileCopyProgress? onProgress;
  final messages = ReceivePort();

  String get partialPath => '$destinationPath.part';

  Future<Result<bool>> run() async {
    Isolate? isolate;
    try {
      isolate = await _spawn();
      return await _waitForResult();
    } catch (error) {
      return Result.failure(
        AppFailure.operationFailed('import.fileAccess', error: error),
      );
    } finally {
      _finish(isolate);
    }
  }

  Future<Isolate> _spawn() => Isolate.spawn(
    copyFileWorker,
    _copyRequest(sourcePath, destinationPath, partialPath, messages.sendPort),
    debugName: 'bookish-file-copy',
    onError: messages.sendPort,
    onExit: messages.sendPort,
  );

  Future<Result<bool>> _waitForResult() => Future.any([
    _receiveCopyMessages(messages, onProgress),
    if (cancellation case final signal?)
      signal.whenCancelled.then<Result<bool>>(
        (_) => const Result.failure(AppFailure.cancelled('import.cancelled')),
      ),
  ]);

  void _finish(Isolate? isolate) {
    messages.close();
    isolate?.kill(priority: Isolate.immediate);
    _deletePartialCopy(partialPath);
    if (cancellation?.isCancelled ?? false) {
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

Future<Result<bool>> _receiveCopyMessages(
  ReceivePort messages,
  FileCopyProgress? onProgress,
) async {
  await for (final message in messages) {
    final result = _handleCopyMessage(message, onProgress);
    if (result != null) {
      return result;
    }
  }
  return const Result.failure(AppFailure.operationFailed('import.fileAccess'));
}

Result<bool>? _handleCopyMessage(
  Object? message,
  FileCopyProgress? onProgress,
) {
  if (message case (
    copiedBytes: final int copiedBytes,
    totalBytes: final int totalBytes,
  )) {
    onProgress?.call(copiedBytes, totalBytes);
    return null;
  }
  return message == FileCopySignal.complete
      ? const Result.success(true)
      : const Result.failure(AppFailure.operationFailed('import.fileAccess'));
}
