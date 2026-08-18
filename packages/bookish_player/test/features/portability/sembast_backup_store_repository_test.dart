import 'package:bookish_player/core/database/bookish_database.dart';
import 'package:bookish_player/features/notes/models/book_note.dart';
import 'package:bookish_player/features/portability/repos/implementations/sembast_backup_store_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sembast/sembast_memory.dart';

import '../../../test_support/support/fixtures.dart';

void main() {
  group('Empty local Bookish database', () {
    late SembastBackupStoreRepository sut;

    setUp(() async {
      final database = await databaseFactoryMemory.openDatabase('backup.db');
      addTearDown(database.close);
      sut = SembastBackupStoreRepository(BookishDatabase.forTesting(database));
    });

    test(
      'Given an empty local Bookish database, When a compatible backup is restored and snapshotted, Then normalized books, notes, sessions, and settings round-trip',
      () async {
        // GIVEN
        await sut.restore(backupFixture(theme: 'dark'));

        // WHEN
        final snapshot = await sut.snapshot();

        // THEN
        expect(snapshot.books.single.id, 'book-1');
        expect(snapshot.bookMetadata.single.id, 'metadata-1');
        expect(snapshot.notes.single.id, 'note-1');
        expect(snapshot.sessions.single.id, 'session-1');
        expect(snapshot.settings.theme, 'dark');
        expect(snapshot.settings.playback, settingsFixture);
      },
    );

    test(
      'Given an empty local Bookish database, When restoration contains a broken note reference, Then the transaction rolls back to the previous library',
      () async {
        // GIVEN
        await sut.restore(backupFixture());
        // WHEN
        final invalid = backupFixture(
          content: (
            books: null,
            metadata: null,
            notes: [bookNoteFixture(metadataId: 'missing')],
            sessions: null,
          ),
        );

        // THEN
        await expectLater(sut.restore(invalid), throwsStateError);

        final snapshot = await sut.snapshot();
        expect(snapshot.books.single.id, 'book-1');
        expect(snapshot.notes.single.id, 'note-1');
      },
    );

    test(
      'Given an empty local Bookish database, When old backups omit normalized metadata identifiers, Then matching metadata is reconnected during restoration',
      () async {
        // GIVEN
        final legacyBook = audiobookFixture(metadataId: '');
        final metadata = bookMetadataFixture(activeBookId: legacyBook.id);
        final legacy = backupFixture(
          content: (
            books: [legacyBook],
            metadata: [metadata],
            notes: const <BookNote>[],
            sessions: const [],
          ),
        );

        await sut.restore(legacy);

        // WHEN
        final snapshot = await sut.snapshot();
        // THEN
        expect(snapshot.books.single.metadataId, metadata.id);
      },
    );
  });
}
