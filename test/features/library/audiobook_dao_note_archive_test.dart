import 'package:bookish_player/core/database/bookish_database.dart';
import 'package:bookish_player/features/library/data/audiobook_dao.dart';
import 'package:bookish_player/features/library/data/listening_history_dao.dart';
import 'package:bookish_player/features/library/domain/audiobook.dart';
import 'package:bookish_player/features/library/domain/audiobook_removal_mode.dart';
import 'package:bookish_player/features/library/domain/listening_session.dart';
import 'package:bookish_player/features/player/domain/book_note.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sembast/sembast_memory.dart';

void main() {
  test(
    'book deletion preserves normalized notes and reconnects on import',
    () async {
      final database = await databaseFactoryMemory.openDatabase('notes.db');
      addTearDown(database.close);
      final dao = AudiobookDao(BookishDatabase.forTesting(database));
      final original = Audiobook(
        id: 'original-id',
        title: 'The Dispossessed',
        author: 'Ursula K. Le Guin',
        narrator: 'Don Leslie',
        series: 'Hainish Cycle',
        year: 1974,
        artworkPath: '/covers/dispossessed.jpg',
        filePath: '/audio/dispossessed.m4b',
        durationMs: 123456,
        addedAt: DateTime.utc(2026),
      );
      await dao.putBook(original);
      await dao.putNote(
        BookNote(
          id: 'note-id',
          metadataId: original.id,
          positionMs: 42000,
          text: 'True journey is return.',
          createdAt: DateTime.utc(2026, 1, 2),
        ),
      );

      final storedBook = await stringMapStoreFactory
          .store('books')
          .record(original.id)
          .get(database);
      final storedNote = await stringMapStoreFactory
          .store('notes')
          .record('note-id')
          .get(database);
      expect(storedBook, isNot(contains('title')));
      expect(storedBook, isNot(contains('artworkPath')));
      expect(storedBook, isNot(contains('chapters')));
      expect(storedNote, isNot(contains('artworkPath')));
      expect(storedNote, isNot(contains('author')));
      expect(storedNote, isNot(contains('bookId')));
      expect(storedNote?['metadataId'], original.id);

      expect(await dao.getBookMetadata(), hasLength(1));
      await dao.deleteBook(original.id);

      final preservedNotes = await dao.getAllNotes();
      final metadata = (await dao.getBookMetadata()).single;
      expect(preservedNotes, hasLength(1));
      expect(preservedNotes.single.metadataId, metadata.id);
      expect(metadata.activeBookId, isNull);
      expect(metadata.title, original.title);
      expect(metadata.author, original.author);
      expect(metadata.narrator, original.narrator);
      expect(metadata.series, original.series);
      expect(metadata.year, original.year);
      expect(metadata.artworkPath, original.artworkPath);

      final reimported = original.copyWith(
        id: 'new-id',
        filePath: '/audio/reimported.m4b',
        addedAt: DateTime.utc(2026, 2),
      );
      await dao.putBook(reimported);

      expect((await dao.getBookMetadata()).single.activeBookId, reimported.id);
      expect((await dao.getNotes(reimported.id)).single.id, 'note-id');
    },
  );

  test(
    'listening history survives deletion and accumulates after reimport',
    () async {
      final database = await databaseFactoryMemory.openDatabase('history.db');
      addTearDown(database.close);
      final wrapper = BookishDatabase.forTesting(database);
      final books = AudiobookDao(wrapper);
      final history = ListeningHistoryDao(wrapper);
      final original = Audiobook(
        id: 'history-book',
        title: 'Parable of the Sower',
        author: 'Octavia E. Butler',
        filePath: '/audio/parable.m4b',
        durationMs: 500000,
        addedAt: DateTime.utc(2025),
      );
      await books.putBook(original);
      final storedOriginal = (await books.getBook(original.id))!;
      await history.saveListeningSession(
        ListeningSession(
          id: 'session-one',
          metadataId: storedOriginal.metadataId,
          startedAt: DateTime.utc(2025, 1, 1),
          endedAt: DateTime.utc(2025, 1, 1, 0, 10),
          listenedMs: 600000,
          startPositionMs: 0,
          endPositionMs: 600000,
          speed: 1,
        ),
      );

      await books.deleteBook(original.id);
      expect(await history.getListeningSessions(), hasLength(1));
      expect((await books.getBookMetadata()).single.activeBookId, isNull);

      await books.putBook(
        original.copyWith(
          id: 'history-book-reimported',
          filePath: '/audio/parable-again.m4b',
        ),
      );
      final reimported = (await books.getBook('history-book-reimported'))!;
      await history.saveListeningSession(
        ListeningSession(
          id: 'session-two',
          metadataId: reimported.metadataId,
          startedAt: DateTime.utc(2025, 2, 1),
          endedAt: DateTime.utc(2025, 2, 1, 0, 5),
          listenedMs: 300000,
          startPositionMs: 0,
          endPositionMs: 300000,
          speed: 1.25,
        ),
      );

      final sessions = await history.getListeningSessions();
      expect(sessions, hasLength(2));
      expect(sessions.map((item) => item.metadataId).toSet(), {
        storedOriginal.metadataId,
      });
      final rawSession = await stringMapStoreFactory
          .store('listening_sessions')
          .record('session-two')
          .get(database);
      expect(rawSession, isNot(contains('bookId')));
    },
  );

  test('delete everything removes notes, metadata, and history', () async {
    final database = await databaseFactoryMemory.openDatabase('purge.db');
    addTearDown(database.close);
    final wrapper = BookishDatabase.forTesting(database);
    final books = AudiobookDao(wrapper);
    final history = ListeningHistoryDao(wrapper);
    final book = Audiobook(
      id: 'purged-book',
      title: 'Kindred',
      author: 'Octavia E. Butler',
      artworkPath: '/covers/kindred.jpg',
      filePath: '/audio/kindred.m4b',
      durationMs: 3600000,
      addedAt: DateTime.utc(2026),
    );
    await books.putBook(book);
    final stored = (await books.getBook(book.id))!;
    await books.putNote(
      BookNote(
        id: 'purged-note',
        metadataId: stored.metadataId,
        positionMs: 120000,
        text: 'Remember this.',
        createdAt: DateTime.utc(2026, 1, 2),
      ),
    );
    await history.saveListeningSession(
      ListeningSession(
        id: 'purged-session',
        metadataId: stored.metadataId,
        startedAt: DateTime.utc(2026, 1, 2),
        endedAt: DateTime.utc(2026, 1, 2, 0, 5),
        listenedMs: 300000,
        startPositionMs: 0,
        endPositionMs: 300000,
        speed: 1,
      ),
    );

    await books.deleteBook(book.id, mode: AudiobookRemovalMode.deleteAllData);

    expect(await books.getBooks(), isEmpty);
    expect(await books.getAllNotes(), isEmpty);
    expect(await books.getBookMetadata(), isEmpty);
    expect(await history.getListeningSessions(), isEmpty);
  });

  test(
    'metadata parse failures identify the stored audiobook record',
    () async {
      final database = await databaseFactoryMemory.openDatabase('invalid.db');
      addTearDown(database.close);
      await stringMapStoreFactory
          .store('book_metadata')
          .record('broken-book')
          .put(database, {'id': 'broken-book'});
      final dao = AudiobookDao(BookishDatabase.forTesting(database));

      await expectLater(
        dao.getBookMetadata(),
        throwsA(
          isA<FormatException>().having(
            (error) => error.message,
            'message',
            contains('audiobook metadata record "broken-book"'),
          ),
        ),
      );
    },
  );
}
