import 'package:injectable/injectable.dart';
import 'package:sembast/sembast.dart';

import '../../../../core/database/bookish_database.dart';
import '../../../../core/foundation/result.dart';
import '../../../../core/theme/bookish_theme_seed.dart';
import '../../../library/repos/implementations/book_storage_codec.dart';
import '../../../library/models/library_models.dart';
import '../../../library/models/listening_session.dart';
import '../../../notes/models/book_note.dart';
import '../../../settings/models/playback_preferences.dart';
import '../backup_store_repository.dart';
import '../../models/bookish_backup.dart';

part 'sembast_backup_store_records.dart';

@LazySingleton(as: BackupStoreRepository)
class SembastBackupStoreRepository implements BackupStoreRepository {
  SembastBackupStoreRepository(BookishDatabase database)
    : _database = database.database;

  final Database _database;
  final _books = stringMapStoreFactory.store('books');
  final _notes = stringMapStoreFactory.store('notes');
  final _metadata = stringMapStoreFactory.store('book_metadata');
  final _sessions = stringMapStoreFactory.store('listening_sessions');
  final _settings = stringMapStoreFactory.store('settings');

  @override
  Future<Result<BookishBackup>> snapshot() async {
    try {
      return await _createSnapshot();
    } catch (error) {
      return Result.failure(
        AppFailure.operationFailed('backup.snapshot', error: error),
      );
    }
  }

  Future<Result<BookishBackup>> _createSnapshot() async =>
      _snapshotResult(await _readSnapshotRecords());

  Future<_SnapshotRecords> _readSnapshotRecords() async {
    final (books, notes, metadata, sessions, appearance, playback) = await (
      _books.find(_database),
      _notes.find(_database),
      _metadata.find(_database),
      _sessions.find(_database),
      _settings.record('appearance').get(_database),
      _settings.record('playback').get(_database),
    ).wait;
    return (
      books: books,
      notes: notes,
      metadata: metadata,
      sessions: sessions,
      appearance: appearance,
      playback: playback,
    );
  }

  Result<BookishBackup> _snapshotResult(_SnapshotRecords records) {
    final metadataById = _metadataById(records.metadata);
    final books = _hydrateStoredBooks(records.books, metadataById);
    return books == null
        ? const Result.failure(
            AppFailure.invalidData('backup.storage.corrupted'),
          )
        : Result.success(_buildBackup(records, metadataById, books));
  }

  List<Audiobook>? _hydrateStoredBooks(
    _StoredRecords records,
    Map<String, BookMetadata> metadataById,
  ) {
    final books = <Audiobook>[];
    for (final record in records) {
      final book = _hydrateStoredBook(record.value, metadataById);
      if (book == null) {
        return null;
      }
      books.add(book);
    }
    return books;
  }

  BookishBackup _buildBackup(
    _SnapshotRecords records,
    Map<String, BookMetadata> metadataById,
    List<Audiobook> books,
  ) => BookishBackup(
    exportedAt: DateTime.now(),
    books: books,
    notes: [for (final record in records.notes) _noteFrom(record.value)],
    bookMetadata: metadataById.values.toList(),
    sessions: [
      for (final record in records.sessions) _sessionFrom(record.value),
    ],
    settings: _backupSettings(records.appearance, records.playback),
  );

  BookNote _noteFrom(Map<String, Object?> value) =>
      BookNote.fromJson(Map<String, dynamic>.from(value));

  ListeningSession _sessionFrom(Map<String, Object?> value) =>
      ListeningSession.fromJson(Map<String, dynamic>.from(value));

  Map<String, BookMetadata> _metadataById(
    List<RecordSnapshot<String, Map<String, Object?>>> records,
  ) => {
    for (final record in records)
      record.key: BookMetadata.fromJson(
        Map<String, dynamic>.from(record.value),
      ),
  };

  Audiobook? _hydrateStoredBook(
    Map<String, Object?> value,
    Map<String, BookMetadata> metadataById,
  ) {
    final metadataId = value['metadataId'] as String?;
    final metadata = metadataId == null ? null : metadataById[metadataId];
    if (metadata == null) {
      return null;
    }

    return hydrateBook(Map<String, dynamic>.from(value), metadata);
  }

  @override
  Future<Result<bool>> restore(BookishBackup backup) async {
    try {
      return await _restore(backup);
    } catch (error) {
      return Result.failure(
        AppFailure.operationFailed('backup.storage.restore', error: error),
      );
    }
  }

  Future<Result<bool>> _restore(BookishBackup backup) async {
    final metadataById = _restoredMetadataById(backup);
    if (!_hasValidRestoreReferences(backup, metadataById)) {
      return const Result.failure(
        AppFailure.invalidData('backup.storage.corrupted'),
      );
    }

    await _database.transaction((transaction) async {
      await _clearBackupStores(transaction);

      await (
        _restoreBooks(transaction, backup.books, metadataById),
        _restoreMetadata(transaction, metadataById.values),
        _restoreNotes(transaction, backup.notes),
        _restoreSessions(transaction, backup.sessions),
        _restoreSettings(transaction, backup.settings),
      ).wait;
    });
    return const Result.success(true);
  }

  Map<String, BookMetadata> _restoredMetadataById(BookishBackup backup) {
    final metadataById = {
      for (final item in backup.bookMetadata) item.id: item,
    };

    for (final book in backup.books) {
      final metadata = _restoredMetadata(book, metadataById);
      metadataById[metadata.id] = metadata;
    }
    return metadataById;
  }

  bool _hasValidRestoreReferences(
    BookishBackup backup,
    Map<String, BookMetadata> metadataById,
  ) {
    for (final note in backup.notes) {
      if (!_hasMetadata(metadataById, note.metadataId)) {
        return false;
      }
    }
    for (final session in backup.sessions) {
      if (!_hasMetadata(metadataById, session.metadataId)) {
        return false;
      }
    }
    return true;
  }

  bool _hasMetadata(
    Map<String, BookMetadata> metadataById,
    String metadataId,
  ) => metadataId.isNotEmpty && metadataById.containsKey(metadataId);

  Future<void> _clearBackupStores(Transaction transaction) async {
    await [
      _books.delete(transaction),
      _notes.delete(transaction),
      _metadata.delete(transaction),
      _sessions.delete(transaction),
    ].wait;
  }

  Future<void> _restoreBooks(
    Transaction transaction,
    List<Audiobook> books,
    Map<String, BookMetadata> metadataById,
  ) async {
    await [
      for (final book in books)
        _books
            .record(book.id)
            .put(
              transaction,
              bookStorageJson(book, _restoredMetadata(book, metadataById).id),
            ),
    ].wait;
  }

  BookMetadata _restoredMetadata(
    Audiobook book,
    Map<String, BookMetadata> metadataById,
  ) {
    final fingerprint = bookMetadataFingerprint(
      title: book.title,
      author: book.author,
      durationMs: book.durationMs,
    );
    final previous = metadataById.values.cast<BookMetadata?>().firstWhere(
      (item) =>
          item?.id == book.metadataId ||
          item?.activeBookId == book.id ||
          item?.fingerprint == fingerprint,
      orElse: () => null,
    );

    return book
        .toBookMetadata(
          metadataId: previous?.id,
          createdAt: previous?.createdAt,
        )
        .preserveArchivedValues(previous);
  }

  Future<void> _restoreMetadata(
    Transaction transaction,
    Iterable<BookMetadata> metadata,
  ) async {
    await [
      for (final item in metadata)
        _metadata.record(item.id).put(transaction, item.toJson()),
    ].wait;
  }

  Future<void> _restoreNotes(
    Transaction transaction,
    List<BookNote> notes,
  ) async {
    await [
      for (final note in notes)
        _notes
            .record(note.id)
            .put(transaction, noteStorageJson(note, note.metadataId)),
    ].wait;
  }

  Future<void> _restoreSessions(
    Transaction transaction,
    List<ListeningSession> sessions,
  ) async {
    await [
      for (final session in sessions)
        _sessions
            .record(session.id)
            .put(
              transaction,
              listeningSessionStorageJson(session, session.metadataId),
            ),
    ].wait;
  }

  Future<void> _restoreSettings(
    Transaction transaction,
    BackupSettings settings,
  ) async {
    await (
      _settings.record('appearance').put(transaction, {
        'theme': settings.theme,
        'useSystemColors': settings.useSystemColors,
        'primaryColor': settings.primaryColor,
      }),
      _settings.record('playback').put(transaction, settings.playback.toJson()),
    ).wait;
  }
}
