class ImportedAudioFile {
  const ImportedAudioFile({required this.path, required this.displayName});

  final String path;
  final String displayName;
}

class SelectedAudioFile {
  const SelectedAudioFile({
    required this.sourcePath,
    required this.displayName,
    this.sizeBytes,
  });

  final String sourcePath;
  final String displayName;
  final int? sizeBytes;
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
