class ImportedAudioFile {
  const ImportedAudioFile({required this.path, required this.displayName});

  final String path;
  final String displayName;
}

class SelectedAudioFile {
  const SelectedAudioFile({
    required this.sourcePath,
    required this.displayName,
  });

  final String sourcePath;
  final String displayName;
}

abstract interface class FileImportRepository {
  Future<List<SelectedAudioFile>> pickAudioFiles();
  Future<List<SelectedAudioFile>> findTransferredAudioFiles();
  Future<ImportedAudioFile> importFile(SelectedAudioFile selected);
  Future<void> removeTransferredAudioFiles(List<SelectedAudioFile> files);
  Future<String?> pickAndImportCover(String bookId);
  Future<void> deleteImportedFile(String path);
}
