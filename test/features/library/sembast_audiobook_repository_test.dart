import 'package:bookish_player/core/database/bookish_database.dart';
import 'package:bookish_player/features/library/repos/implementations/audiobook_dao.dart';
import 'package:bookish_player/features/library/repos/implementations/sembast_audiobook_repository.dart';
import 'package:bookish_player/features/library/models/audiobook_removal_mode.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sembast/sembast_memory.dart';

import '../../support/fixtures.dart';

void main() {
  group('Sembast audiobook adapter', () {
    late SembastAudiobookRepository sut;

    setUp(() async {
      final database = await databaseFactoryMemory.openDatabase('adapter.db');
      addTearDown(database.close);
      sut = SembastAudiobookRepository(
        AudiobookDao(BookishDatabase.forTesting(database)),
      );
    });

    test(
      'Given the Sembast audiobook adapter, When catalog, progress, notes, and replacement intents are sent, Then every domain port delegates to durable normalized storage',
      () async {
        // GIVEN
        final book = audiobookFixture();
        final note = bookNoteFixture();
        await sut.saveBook(book);
        await sut.updateProgress(book.id, const Duration(minutes: 2));
        await sut.updatePlaybackSpeed(book.id, 1.5);
        // WHEN
        await sut.saveNote(note);

        // THEN
        expect(await sut.getBooks(), hasLength(1));
        expect((await sut.watchBooks().first).single.id, book.id);
        final storedBook = await sut.getBook(book.id);
        expect(storedBook?.positionMs, 120000);
        expect(storedBook?.playbackSpeed, 1.5);
        expect((await sut.getNotes(book.id)).single.id, note.id);
        expect(await sut.getAllNotes(), hasLength(1));
        expect(await sut.getBookMetadata(), hasLength(1));
        expect(
          await sut.findBookMetadata('a test audiobook||3600000'),
          isNotNull,
        );

        await sut.deleteNote(note.id);
        await sut.deleteBook(book.id, mode: AudiobookRemovalMode.deleteAllData);
        expect(await sut.getBook(book.id), isNull);

        await sut.replaceLibrary([book], [note]);
        expect(await sut.getBooks(), hasLength(1));
        expect(await sut.getAllNotes(), hasLength(1));
      },
    );
  });
}
