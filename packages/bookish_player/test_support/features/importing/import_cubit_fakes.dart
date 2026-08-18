import 'package:bookish_player/features/importing/repos/file_import_repository.dart';
import 'package:bookish_player/features/importing/repos/selected_audio_file.dart';

class FakeImportFiles implements FileImportRepository {
  FakeImportFiles(this.selected, {this.events});
  final List<SelectedAudioFile> selected;
  final List<String>? events;
  var pickCount = 0;

  @override
  Future<List<SelectedAudioFile>> pickAudioFiles() async {
    pickCount++;
    return selected;
  }

  @override
  Future<ImportedAudioFile> importFile(
    SelectedAudioFile selected, {
    FileCopyProgress? onProgress,
  }) async {
    events?.add('copy');
    onProgress?.call(100, 100);
    return const ImportedAudioFile(
      path: '/bookish/book.m4b',
      displayName: 'book.m4b',
    );
  }

  @override
  Future<void> removeTransferredAudioFiles(
    List<SelectedAudioFile> files,
  ) async {
    events?.add('remove');
  }

  @override
  Future<void> clearTemporaryFiles() async => events?.add('clear-cache');
  @override
  Future<void> deleteImportedFile(String path) async {}
  @override
  Future<List<SelectedAudioFile>> findTransferredAudioFiles() async => selected;
  @override
  Future<String?> pickAndImportCover(String bookId) async => null;
}
