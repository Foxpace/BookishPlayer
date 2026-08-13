import 'package:bookish_player/core/database/bookish_database.dart';
import 'package:bookish_player/features/library/repos/implementations/audiobook_dao.dart';
import 'package:bookish_player/features/library/repos/implementations/listening_history_dao.dart';
import 'package:bookish_player/features/library/models/library_models.dart';
import 'package:bookish_player/features/library/models/audiobook_removal_mode.dart';
import 'package:bookish_player/features/library/models/listening_session.dart';
import 'package:bookish_player/features/notes/models/note_models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sembast/sembast_memory.dart';

void main() {
  group('Audiobook dao note archive', () {
    var databaseId = 0;
    late Database database;
    late AudiobookDao sut;
    late ListeningHistoryDao history;

    setUp(() async {
      database = await databaseFactoryMemory.openDatabase(
        'archive-${databaseId++}.db',
      );
      final wrapper = BookishDatabase.forTesting(database);
      sut = AudiobookDao(wrapper);
      history = ListeningHistoryDao(wrapper);
    });

    tearDown(() => database.close());

    test(
      'Given the audiobook dao note archive, When its behavior is exercised, Then book deletion preserves normalized notes and reconnects on import',
      () async {
        // GIVEN
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
        await sut.putBook(original);
        await sut.putNote(
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
        // WHEN
        final storedNote = await stringMapStoreFactory
            .store('notes')
            .record('note-id')
            .get(database);
        // THEN
        expect(storedBook, isNot(contains('title')));
        expect(storedBook, isNot(contains('artworkPath')));
        expect(storedBook, isNot(contains('chapters')));
        expect(storedNote, isNot(contains('artworkPath')));
        expect(storedNote, isNot(contains('author')));
        expect(storedNote, isNot(contains('bookId')));
        expect(storedNote?['metadataId'], original.id);

        expect(await sut.getBookMetadata(), hasLength(1));
        await sut.deleteBook(original.id);

        final preservedNotes = await sut.getAllNotes();
        final metadata = (await sut.getBookMetadata()).single;
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
        await sut.putBook(reimported);

        expect(
          (await sut.getBookMetadata()).single.activeBookId,
          reimported.id,
        );
        expect((await sut.getNotes(reimported.id)).single.id, 'note-id');
      },
    );

    test(
      'Given the audiobook dao note archive, When its behavior is exercised, Then listening history survives deletion and accumulates after reimport',
      () async {
        // GIVEN
        final original = Audiobook(
          id: 'history-book',
          title: 'Parable of the Sower',
          author: 'Octavia E. Butler',
          filePath: '/audio/parable.m4b',
          durationMs: 500000,
          addedAt: DateTime.utc(2025),
        );
        await sut.putBook(original);
        final storedOriginal = await sut.getBook(original.id);
        if (storedOriginal == null) {
          fail('The original book must be persisted.');
        }
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

        // WHEN
        await sut.deleteBook(original.id);
        // THEN
        expect(await history.getListeningSessions(), hasLength(1));
        expect((await sut.getBookMetadata()).single.activeBookId, isNull);

        await sut.putBook(
          original.copyWith(
            id: 'history-book-reimported',
            filePath: '/audio/parable-again.m4b',
          ),
        );
        final reimported = await sut.getBook('history-book-reimported');
        if (reimported == null) {
          fail('The reimported book must be persisted.');
        }
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

    test(
      'Given the audiobook dao note archive, When its behavior is exercised, Then delete everything removes notes, metadata, and history',
      () async {
        // GIVEN
        final book = Audiobook(
          id: 'purged-book',
          title: 'Kindred',
          author: 'Octavia E. Butler',
          artworkPath: '/covers/kindred.jpg',
          filePath: '/audio/kindred.m4b',
          durationMs: 3600000,
          addedAt: DateTime.utc(2026),
        );
        await sut.putBook(book);
        final stored = await sut.getBook(book.id);
        if (stored == null) {
          fail('The book must be persisted before related records.');
        }
        await sut.putNote(
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

        // WHEN
        await sut.deleteBook(book.id, mode: AudiobookRemovalMode.deleteAllData);

        // THEN
        expect(await sut.getBooks(), isEmpty);
        expect(await sut.getAllNotes(), isEmpty);
        expect(await sut.getBookMetadata(), isEmpty);
        expect(await history.getListeningSessions(), isEmpty);
      },
    );

    test(
      'Given the audiobook dao note archive, When its behavior is exercised, Then metadata parse failures identify the stored audiobook record',
      () async {
        // GIVEN
        await stringMapStoreFactory
            .store('book_metadata')
            .record('broken-book')
            .put(database, {'id': 'broken-book'});
        // THEN
        await expectLater(
          sut.getBookMetadata(),
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
  });
}
