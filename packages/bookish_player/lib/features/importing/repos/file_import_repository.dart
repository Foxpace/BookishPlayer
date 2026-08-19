import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/foundation/result.dart';
import '../models/import_cancellation.dart';
import 'selected_audio_file.dart';
part 'file_import_repository.freezed.dart';
part 'imported_audio_file.dart';

typedef FileCopyProgress = void Function(int copiedBytes, int totalBytes);

abstract interface class FileImportRepository {
  Future<Result<List<SelectedAudioFile>>> pickAudioFiles();
  Future<Result<List<SelectedAudioFile>>> findTransferredAudioFiles();
  Future<Result<ImportedAudioFile>> importFile(
    SelectedAudioFile selected, {
    ImportCancellationSignal? cancellation,
    FileCopyProgress? onProgress,
  });
  Future<void> clearTemporaryFiles();
  Future<Result<bool>> removeTransferredAudioFiles(
    List<SelectedAudioFile> files,
  );
  Future<String?> pickAndImportCover(String bookId);
  Future<void> deleteImportedFile(String path);
}
