import 'package:injectable/injectable.dart';

import '../../../core/foundation/result.dart';
import '../../library/models/library_models.dart';
import '../../library/models/listening_session.dart';
import '../../notes/models/book_note.dart';
import '../models/bookish_backup.dart';

import 'backup_validation_error.dart';
import 'backup_validation_failure.dart';

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

  Result<BookishBackup, BackupValidationError> validate(BookishBackup backup) {
    final error =
        _validateBackupVersion(backup) ??
        _validateUniqueIds(backup) ??
        _validateRecords(backup);
    return error == null ? Result.success(backup) : Result.failure(error);
  }

  BackupValidationError? _validateBackupVersion(BookishBackup backup) {
    if (backup.schemaVersion < oldestSupportedVersion ||
        backup.schemaVersion > currentVersion) {
      return const BackupValidationError(
        BackupValidationFailure.unsupportedVersion,
      );
    }
    if (_themes.contains(backup.settings.theme) == false) {
      return const BackupValidationError(BackupValidationFailure.invalidTheme);
    }
    return null;
  }

  BackupValidationError? _validateUniqueIds(BookishBackup backup) =>
      _requireUnique(
        backup.books.map((book) => book.id),
        BackupValidationFailure.duplicateBook,
      ) ??
      _requireUnique(
        backup.bookMetadata.map((metadata) => metadata.id),
        BackupValidationFailure.duplicateMetadata,
      ) ??
      _requireUnique(
        backup.notes.map((note) => note.id),
        BackupValidationFailure.duplicateNote,
      ) ??
      _requireUnique(
        backup.sessions.map((session) => session.id),
        BackupValidationFailure.duplicateSession,
      );

  BackupValidationError? _validateRecords(BookishBackup backup) {
    final bookIds = backup.books.map((book) => book.id).toSet();
    final metadataIds = backup.bookMetadata
        .map((metadata) => metadata.id)
        .toSet();
    metadataIds.addAll(
      backup.books.map(
        (book) => book.metadataId.isEmpty ? book.id : book.metadataId,
      ),
    );
    return _validateBooks(backup.books) ??
        _validateMetadata(backup.bookMetadata, bookIds) ??
        _validateNotes(backup.notes, metadataIds) ??
        _validateSessions(backup.sessions, metadataIds);
  }

  BackupValidationError? _validateBooks(Iterable<Audiobook> books) {
    for (final book in books) {
      if (book.hasValidBackupValues == false) {
        return BackupValidationError(
          BackupValidationFailure.invalidBook,
          recordId: book.id,
        );
      }
    }
    return null;
  }

  BackupValidationError? _validateMetadata(
    Iterable<BookMetadata> metadataRecords,
    Set<String> bookIds,
  ) {
    for (final metadata in metadataRecords) {
      if (metadata.hasValidBackupValues(bookIds) == false) {
        return BackupValidationError(
          BackupValidationFailure.missingReference,
          recordId: metadata.id,
        );
      }
    }
    return null;
  }

  BackupValidationError? _validateNotes(
    Iterable<BookNote> notes,
    Set<String> metadataIds,
  ) {
    for (final note in notes) {
      if (_validateNote(note, metadataIds) case final error?) {
        return error;
      }
    }
    return null;
  }

  BackupValidationError? _validateNote(
    BookNote note,
    Set<String> metadataIds,
  ) => note.hasValidBackupValues
      ? _requireReference(metadataIds, note.metadataId, note.id)
      : BackupValidationError(
          BackupValidationFailure.invalidNote,
          recordId: note.id,
        );

  BackupValidationError? _validateSessions(
    Iterable<ListeningSession> sessions,
    Set<String> metadataIds,
  ) {
    for (final session in sessions) {
      if (_validateSession(session, metadataIds) case final error?) {
        return error;
      }
    }
    return null;
  }

  BackupValidationError? _validateSession(
    ListeningSession session,
    Set<String> metadataIds,
  ) => session.hasValidBackupValues
      ? _requireReference(metadataIds, session.metadataId, session.id)
      : BackupValidationError(
          BackupValidationFailure.invalidSession,
          recordId: session.id,
        );

  BackupValidationError? _requireUnique(
    Iterable<String> values,
    BackupValidationFailure failure,
  ) {
    final seen = <String>{};
    for (final value in values) {
      if (seen.add(value) == false) {
        return BackupValidationError(failure, recordId: value);
      }
    }
    return null;
  }

  BackupValidationError? _requireReference(
    Set<String> ids,
    String target,
    String recordId,
  ) {
    if (target.isEmpty || ids.contains(target) == false) {
      return BackupValidationError(
        BackupValidationFailure.missingReference,
        recordId: recordId,
      );
    }
    return null;
  }
}
