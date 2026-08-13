import 'package:bookish_player/features/importing/repos/import_repositories.dart';

class FakeLibraryFiles implements FileImportRepository {
  String? pickedCover;
  final deletedPaths = <String>[];

  @override
  Future<void> clearTemporaryFiles() async {}

  @override
  Future<void> deleteImportedFile(String path) async {
    deletedPaths.add(path);
  }

  @override
  Future<List<SelectedAudioFile>> findTransferredAudioFiles() async => const [];

  @override
  Future<ImportedAudioFile> importFile(
    SelectedAudioFile selected, {
    FileCopyProgress? onProgress,
  }) async => ImportedAudioFile(
    path: selected.sourcePath,
    displayName: selected.displayName,
  );

  @override
  Future<String?> pickAndImportCover(String bookId) async => pickedCover;

  @override
  Future<List<SelectedAudioFile>> pickAudioFiles() async => const [];

  @override
  Future<void> removeTransferredAudioFiles(
    List<SelectedAudioFile> files,
  ) async {}
}
