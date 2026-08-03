import 'package:freezed_annotation/freezed_annotation.dart';

part 'file_import_repository.freezed.dart';

@freezed
abstract class ImportedAudioFile with _$ImportedAudioFile {
  const factory ImportedAudioFile({
    required String path,
    required String displayName,
  }) = _ImportedAudioFile;
}

@freezed
abstract class SelectedAudioFile with _$SelectedAudioFile {
  const factory SelectedAudioFile({
    required String sourcePath,
    required String displayName,
    int? sizeBytes,
  }) = _SelectedAudioFile;
}

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
