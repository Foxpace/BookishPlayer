import 'package:bookish_player/features/importing/domain/file_import_repository.dart';
import 'package:bookish_player/features/library/application/remove_audiobook_workflow.dart';
import 'package:bookish_player/features/library/domain/audiobook.dart';
import 'package:bookish_player/features/library/domain/audiobook_catalog_repository.dart';
import 'package:bookish_player/features/library/domain/audiobook_removal_mode.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final book = Audiobook(
    id: 'book',
    title: 'The Left Hand of Darkness',
    filePath: '/audio/book.m4b',
    artworkPath: '/covers/book.jpg',
    durationMs: 1000,
    addedAt: DateTime.utc(2026),
  );

  test('audio-only removal retains imported artwork', () async {
    final books = _Books();
    final files = _Files();

    await RemoveAudiobookWorkflow(
      books,
      files,
    ).run(book, AudiobookRemovalMode.keepUserData);

    expect(books.mode, AudiobookRemovalMode.keepUserData);
    expect(files.deletedPaths, ['/audio/book.m4b']);
  });

  test('full removal also deletes imported artwork', () async {
    final books = _Books();
    final files = _Files();

    await RemoveAudiobookWorkflow(
      books,
      files,
    ).run(book, AudiobookRemovalMode.deleteAllData);

    expect(books.mode, AudiobookRemovalMode.deleteAllData);
    expect(files.deletedPaths, ['/audio/book.m4b', '/covers/book.jpg']);
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
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Files implements FileImportRepository {
  final deletedPaths = <String>[];

  @override
  Future<void> deleteImportedFile(String path) async {
    deletedPaths.add(path);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
