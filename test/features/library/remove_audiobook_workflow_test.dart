import 'package:bookish_player/features/importing/repos/import_repositories.dart';
import 'package:bookish_player/features/library/use_cases/remove_audiobook_use_case.dart';
import 'package:bookish_player/features/library/models/library_models.dart';
import 'package:bookish_player/features/library/repos/audiobook_catalog_repository.dart';
import 'package:bookish_player/features/library/models/audiobook_removal_mode.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Remove audiobook workflow', () {
    final book = Audiobook(
      id: 'book',
      title: 'The Left Hand of Darkness',
      filePath: '/audio/book.m4b',
      artworkPath: '/covers/book.jpg',
      durationMs: 1000,
      addedAt: DateTime.utc(2026),
    );
    late _Books books;
    late _Files files;
    late RemoveAudiobookUseCase sut;

    setUp(() {
      books = _Books();
      files = _Files();
      sut = RemoveAudiobookUseCase(books, files);
    });

    test(
      'Given the remove audiobook workflow, When its behavior is exercised, Then audio-only removal retains imported artwork',
      () async {
        // WHEN
        await sut(book, AudiobookRemovalMode.keepUserData);

        // THEN
        expect(books.mode, AudiobookRemovalMode.keepUserData);
        expect(files.deletedPaths, ['/audio/book.m4b']);
      },
    );

    test(
      'Given the remove audiobook workflow, When its behavior is exercised, Then full removal also deletes imported artwork',
      () async {
        // WHEN
        await sut(book, AudiobookRemovalMode.deleteAllData);

        // THEN
        expect(books.mode, AudiobookRemovalMode.deleteAllData);
        expect(files.deletedPaths, ['/audio/book.m4b', '/covers/book.jpg']);
      },
    );
  });
}

class _Books implements AudiobookCatalogRepository {
  AudiobookRemovalMode? mode;

  @override
  Future<void> deleteBook(
    String id, {
    AudiobookRemovalMode mode = AudiobookRemovalMode.keepUserData,
  }) async {
    this.mode = mode;
  }

  @override
  Future<Audiobook?> getBook(String id) async => null;

  @override
  Future<List<Audiobook>> getBooks() async => const [];

  @override
  Future<void> saveBook(Audiobook book) async {}

  @override
  Future<void> updatePlaybackSpeed(String id, double speed) async {}

  @override
  Future<void> updateProgress(String id, Duration position) async {}
}

class _Files implements FileImportRepository {
  final deletedPaths = <String>[];

  @override
  Future<void> deleteImportedFile(String path) async {
    deletedPaths.add(path);
  }

  @override
  Future<void> clearTemporaryFiles() async {}

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
  Future<String?> pickAndImportCover(String bookId) async => null;

  @override
  Future<List<SelectedAudioFile>> pickAudioFiles() async => const [];

  @override
  Future<void> removeTransferredAudioFiles(
    List<SelectedAudioFile> files,
  ) async {}
}
