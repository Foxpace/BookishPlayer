import 'package:injectable/injectable.dart';

import '../../../core/foundation/result.dart';
import '../../library/models/library_models.dart';
import '../../library/models/listening_session.dart';
import '../../notes/models/book_note.dart';
import '../models/bookish_backup.dart';

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

  Result<BookishBackup> validate(BookishBackup backup) {
    final error =
        _validateBackupVersion(backup) ??
        _validateUniqueIds(backup) ??
        _validateRecords(backup);
    return error == null ? Result.success(backup) : Result.failure(error);
  }

  AppFailure? _validateBackupVersion(BookishBackup backup) {
    if (backup.schemaVersion < oldestSupportedVersion ||
        backup.schemaVersion > currentVersion) {
      return const AppFailure.invalidData('backup.version.unsupported');
    }
    if (_themes.contains(backup.settings.theme) == false) {
      return const AppFailure.invalidData('backup.theme.invalid');
    }
    return null;
  }

  AppFailure? _validateUniqueIds(BookishBackup backup) =>
      _requireUnique(
        backup.books.map((book) => book.id),
        'backup.book.duplicate',
      ) ??
      _requireUnique(
        backup.bookMetadata.map((metadata) => metadata.id),
        'backup.metadata.duplicate',
      ) ??
      _requireUnique(
        backup.notes.map((note) => note.id),
        'backup.note.duplicate',
      ) ??
      _requireUnique(
        backup.sessions.map((session) => session.id),
        'backup.session.duplicate',
      );

  AppFailure? _validateRecords(BookishBackup backup) {
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

  AppFailure? _validateBooks(Iterable<Audiobook> books) {
    for (final book in books) {
      if (book.hasValidBackupValues == false) {
        return AppFailure.invalidData('backup.book.invalid:${book.id}');
      }
    }
    return null;
  }

  AppFailure? _validateMetadata(
    Iterable<BookMetadata> metadataRecords,
    Set<String> bookIds,
  ) {
    for (final metadata in metadataRecords) {
      if (metadata.hasValidBackupValues(bookIds) == false) {
        return AppFailure.invalidData(
          'backup.reference.missing:${metadata.id}',
        );
      }
    }
    return null;
  }

  AppFailure? _validateNotes(
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

  AppFailure? _validateNote(BookNote note, Set<String> metadataIds) =>
      note.hasValidBackupValues
      ? _requireReference(metadataIds, note.metadataId, note.id)
      : AppFailure.invalidData('backup.note.invalid:${note.id}');

  AppFailure? _validateSessions(
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

  AppFailure? _validateSession(
    ListeningSession session,
    Set<String> metadataIds,
  ) => session.hasValidBackupValues
      ? _requireReference(metadataIds, session.metadataId, session.id)
      : AppFailure.invalidData('backup.session.invalid:${session.id}');

  AppFailure? _requireUnique(Iterable<String> values, String detail) {
    final seen = <String>{};
    for (final value in values) {
      if (seen.add(value) == false) {
        return AppFailure.invalidData('$detail:$value');
      }
    }
    return null;
  }

  AppFailure? _requireReference(
    Set<String> ids,
    String target,
    String recordId,
  ) {
    if (target.isEmpty || ids.contains(target) == false) {
      return AppFailure.invalidData('backup.reference.missing:$recordId');
    }
    return null;
  }
}
