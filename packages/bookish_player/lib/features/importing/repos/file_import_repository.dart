import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/foundation/result.dart';
import '../models/import_cancellation.dart';
import 'file_import_failure.dart';
import 'selected_audio_file.dart';
part 'file_import_repository.freezed.dart';
part 'imported_audio_file.dart';

typedef FileCopyProgress = void Function(int copiedBytes, int totalBytes);

abstract interface class FileImportRepository {
  Future<Result<List<SelectedAudioFile>, FileImportFailure>> pickAudioFiles();
  Future<Result<List<SelectedAudioFile>, FileImportFailure>>
  findTransferredAudioFiles();
  Future<Result<ImportedAudioFile, FileImportFailure>> importFile(
    SelectedAudioFile selected, {
    ImportCancellationSignal? cancellation,
    FileCopyProgress? onProgress,
  });
  Future<void> clearTemporaryFiles();
  Future<Result<bool, FileImportFailure>> removeTransferredAudioFiles(
    List<SelectedAudioFile> files,
  );
  Future<String?> pickAndImportCover(String bookId);
  Future<void> deleteImportedFile(String path);
}
