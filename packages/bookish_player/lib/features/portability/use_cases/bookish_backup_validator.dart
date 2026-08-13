import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../library/models/library_models.dart';
import '../../library/models/listening_session.dart';
import '../../notes/models/note_models.dart';
import '../models/bookish_backup.dart';

import 'backup_validation_failure.dart';
part 'bookish_backup_validator.freezed.dart';
part 'backup_validation_exception.dart';

extension _BackupBookValidation on Audiobook {
  bool get hasValidBackupValues =>
      id.isNotEmpty &&
      durationMs >= 0 &&
      positionMs >= 0 &&
      positionMs <= durationMs &&
      playbackSpeed.isFinite &&
      playbackSpeed > 0;
}

extension _BackupMetadataValidation on BookMetadata {
  bool hasValidBackupValues(Set<String> bookIds) =>
      id.isNotEmpty &&
      durationMs >= 0 &&
      (activeBookId == null || bookIds.contains(activeBookId));
}

extension _BackupNoteValidation on BookNote {
  bool get hasValidBackupValues {
    final end = endPositionMs;
    return id.isNotEmpty &&
        positionMs >= 0 &&
        (end == null || end >= positionMs);
  }
}

extension _BackupSessionValidation on ListeningSession {
  bool get hasValidBackupValues =>
      id.isNotEmpty &&
      endedAt.isBefore(startedAt) == false &&
      listenedMs >= 0 &&
      startPositionMs >= 0 &&
      endPositionMs >= 0 &&
      speed.isFinite &&
      speed > 0;
}

@injectable
class BookishBackupValidator {
  const BookishBackupValidator();

  static const oldestSupportedVersion = 1;
  static const currentVersion = 3;
  static const _themes = {'system', 'light', 'dark'};

  void validate(BookishBackup backup) {
    _validateBackupVersion(backup);
    _validateUniqueIds(backup);
    _validateRecords(backup);
  }

  void _validateBackupVersion(BookishBackup backup) {
    if (backup.schemaVersion < oldestSupportedVersion ||
        backup.schemaVersion > currentVersion) {
      throw const BackupValidationException(
        BackupValidationFailure.unsupportedVersion,
      );
    }
    if (_themes.contains(backup.settings.theme) == false) {
      throw const BackupValidationException(
        BackupValidationFailure.invalidTheme,
      );
    }
  }

  void _validateUniqueIds(BookishBackup backup) {
    _requireUnique(
      backup.books.map((book) => book.id),
      BackupValidationFailure.duplicateBook,
    );
    _requireUnique(
      backup.bookMetadata.map((metadata) => metadata.id),
      BackupValidationFailure.duplicateMetadata,
    );
    _requireUnique(
      backup.notes.map((note) => note.id),
      BackupValidationFailure.duplicateNote,
    );
    _requireUnique(
      backup.sessions.map((session) => session.id),
      BackupValidationFailure.duplicateSession,
    );
  }

  void _validateRecords(BookishBackup backup) {
    final bookIds = backup.books.map((book) => book.id).toSet();
    final metadataIds = backup.bookMetadata
        .map((metadata) => metadata.id)
        .toSet();
    metadataIds.addAll(
      backup.books.map(
        (book) => book.metadataId.isEmpty ? book.id : book.metadataId,
      ),
    );
    _validateBooks(backup.books);
    _validateMetadata(backup.bookMetadata, bookIds);
    _validateNotes(backup.notes, metadataIds);
    _validateSessions(backup.sessions, metadataIds);
  }

  void _validateBooks(Iterable<Audiobook> books) {
    for (final book in books) {
      if (book.hasValidBackupValues == false) {
        throw BackupValidationException(
          BackupValidationFailure.invalidBook,
          recordId: book.id,
        );
      }
    }
  }

  void _validateMetadata(
    Iterable<BookMetadata> metadataRecords,
    Set<String> bookIds,
  ) {
    for (final metadata in metadataRecords) {
      if (metadata.hasValidBackupValues(bookIds) == false) {
        throw BackupValidationException(
          BackupValidationFailure.missingReference,
          recordId: metadata.id,
        );
      }
    }
  }

  void _validateNotes(Iterable<BookNote> notes, Set<String> metadataIds) {
    for (final note in notes) {
      if (note.hasValidBackupValues == false) {
        throw BackupValidationException(
          BackupValidationFailure.invalidNote,
          recordId: note.id,
        );
      }
      _requireReference(metadataIds, note.metadataId, note.id);
    }
  }

  void _validateSessions(
    Iterable<ListeningSession> sessions,
    Set<String> metadataIds,
  ) {
    for (final session in sessions) {
      if (session.hasValidBackupValues == false) {
        throw BackupValidationException(
          BackupValidationFailure.invalidSession,
          recordId: session.id,
        );
      }
      _requireReference(metadataIds, session.metadataId, session.id);
    }
  }

  void _requireUnique(
    Iterable<String> values,
    BackupValidationFailure failure,
  ) {
    final seen = <String>{};
    for (final value in values) {
      if (seen.add(value) == false) {
        throw BackupValidationException(failure, recordId: value);
      }
    }
  }

  void _requireReference(Set<String> ids, String target, String recordId) {
    if (target.isEmpty || ids.contains(target) == false) {
      throw BackupValidationException(
        BackupValidationFailure.missingReference,
        recordId: recordId,
      );
    }
  }
}
