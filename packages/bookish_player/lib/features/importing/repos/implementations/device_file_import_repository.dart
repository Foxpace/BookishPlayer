import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/foundation/result.dart';
import '../../../../core/foundation/id_generator.dart';
import '../../../../core/platform/file_picker_gateway.dart';
import '../../models/import_cancellation.dart';
import '../file_import_repository.dart';
import '../selected_audio_file.dart';
import 'background_file_copy.dart';

export 'background_file_copy.dart' show copyFileInBackground;

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
      return await _pickAudioFiles();
    } catch (error) {
      return Result.failure(
        AppFailure.operationFailed('import.fileAccess', error: error),
      );
    }
  }

  Future<Result<List<SelectedAudioFile>>> _pickAudioFiles() async {
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
      return await _findTransferredAudioFiles();
    } catch (error) {
      return Result.failure(
        AppFailure.operationFailed('import.fileAccess', error: error),
      );
    }
  }

  Future<Result<List<SelectedAudioFile>>> _findTransferredAudioFiles() async {
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
      return await _importFile(selected, cancellation, onProgress);
    } catch (error) {
      return Result.failure(
        AppFailure.operationFailed('import.fileAccess', error: error),
      );
    }
  }

  Future<Result<ImportedAudioFile>> _importFile(
    SelectedAudioFile selected,
    ImportCancellationSignal? cancellation,
    FileCopyProgress? onProgress,
  ) async {
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
  }

  @override
  Future<Result<bool>> removeTransferredAudioFiles(
    List<SelectedAudioFile> files,
  ) async {
    try {
      return await _removeTransferredAudioFiles(files);
    } catch (error) {
      return Result.failure(
        AppFailure.operationFailed('import.sourceRemoval', error: error),
      );
    }
  }

  Future<Result<bool>> _removeTransferredAudioFiles(
    List<SelectedAudioFile> files,
  ) async {
    for (final selected in files) {
      final file = File(selected.sourcePath);
      if (file.existsSync()) {
        await file.delete();
      }
    }
    return const Result.success(true);
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
