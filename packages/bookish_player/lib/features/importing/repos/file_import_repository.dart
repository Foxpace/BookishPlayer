import 'package:freezed_annotation/freezed_annotation.dart';

import 'selected_audio_file.dart';
part 'file_import_repository.freezed.dart';
part 'imported_audio_file.dart';

typedef FileCopyProgress = void Function(int copiedBytes, int totalBytes);

abstract interface class FileImportRepository {
  Future<List<SelectedAudioFile>> pickAudioFiles();
  Future<List<SelectedAudioFile>> findTransferredAudioFiles();
  Future<ImportedAudioFile> importFile(
    SelectedAudioFile selected, {
    FileCopyProgress? onProgress,
  });
  Future<void> clearTemporaryFiles();
  Future<void> removeTransferredAudioFiles(List<SelectedAudioFile> files);
  Future<String?> pickAndImportCover(String bookId);
  Future<void> deleteImportedFile(String path);
}
