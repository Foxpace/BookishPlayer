import 'package:bookish_player/core/foundation/result.dart';
import 'package:bookish_player/features/portability/models/bookish_backup.dart';
import 'package:bookish_player/features/portability/use_cases/bookish_backup_validator.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_support/support/fixtures.dart';

void main() {
  const sut = BookishBackupValidator();

  group('Supported and internally consistent backup', () {
    test(
      'Given a supported and internally consistent backup, When the payload is validated, Then validation completes without a failure',
      () {
        // THEN
        expect(sut.validate(backupFixture()), isA<ResultSuccess>());
      },
    );
  });

  group('Backup with duplicate identifiers', () {
    test(
      'Given a backup with duplicate identifiers, When the payload is validated, Then a typed duplicate failure is reported',
      () {
        // WHEN
        final backup = backupFixture(
          content: (
            books: [audiobookFixture(), audiobookFixture()],
            metadata: null,
            notes: null,
            sessions: null,
          ),
        );

        // THEN
        expect(
          sut.validate(backup),
          const Result<BookishBackup>.failure(
            AppFailure.invalidData('backup.book.duplicate:book-1'),
          ),
        );
      },
    );
  });

  group('Note that references missing book metadata', () {
    test(
      'Given a note that references missing book metadata, When the payload is validated, Then restoration is rejected before persistence is changed',
      () {
        // WHEN
        final backup = backupFixture(
          content: (
            books: null,
            metadata: null,
            notes: [bookNoteFixture(metadataId: 'missing')],
            sessions: null,
          ),
        );

        // THEN
        expect(
          sut.validate(backup),
          const Result<BookishBackup>.failure(
            AppFailure.invalidData('backup.reference.missing:note-1'),
          ),
        );
      },
    );
  });

  group('Backup from a newer incompatible schema', () {
    test(
      'Given a backup from a newer incompatible schema, When the payload is validated, Then an unsupported-version failure is reported',
      () {
        // THEN
        expect(
          sut.validate(backupFixture(schemaVersion: 4)),
          const Result<BookishBackup>.failure(
            AppFailure.invalidData('backup.version.unsupported'),
          ),
        );
      },
    );
  });
}
