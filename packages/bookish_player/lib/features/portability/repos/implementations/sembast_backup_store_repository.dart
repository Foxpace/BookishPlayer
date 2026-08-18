import 'package:injectable/injectable.dart';
import 'package:sembast/sembast.dart';

import '../../../../core/database/bookish_database.dart';
import '../../../library/repos/implementations/book_storage_codec.dart';
import '../../../library/models/library_models.dart';
import '../../../library/models/listening_session.dart';
import '../../../notes/models/book_note.dart';
import '../../../settings/models/playback_preferences.dart';
import '../backup_store_repository.dart';
import '../../models/bookish_backup.dart';

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
  Future<BookishBackup> snapshot() async {
    final (
      bookRecords,
      noteRecords,
      metadataRecords,
      sessionRecords,
      appearance,
      playback,
    ) = await (
      _books.find(_database),
      _notes.find(_database),
      _metadata.find(_database),
      _sessions.find(_database),
      _settings.record('appearance').get(_database),
      _settings.record('playback').get(_database),
    ).wait;
    final metadataById = _metadataById(metadataRecords);

    return BookishBackup(
      exportedAt: DateTime.now(),
      books: [
        for (final record in bookRecords)
          _hydrateStoredBook(record.value, metadataById),
      ],
      notes: [
        for (final record in noteRecords)
          BookNote.fromJson(Map<String, dynamic>.from(record.value)),
      ],
      bookMetadata: metadataById.values.toList(),
      sessions: [
        for (final record in sessionRecords)
          ListeningSession.fromJson(Map<String, dynamic>.from(record.value)),
      ],
      settings: _backupSettings(appearance, playback),
    );
  }

  Map<String, BookMetadata> _metadataById(
    List<RecordSnapshot<String, Map<String, Object?>>> records,
  ) => {
    for (final record in records)
      record.key: BookMetadata.fromJson(
        Map<String, dynamic>.from(record.value),
      ),
  };

  BackupSettings _backupSettings(
    Map<String, Object?>? appearance,
    Map<String, Object?>? playback,
  ) => BackupSettings(
    theme: appearance?['theme'] as String? ?? 'system',
    playback: playback == null
        ? const PlaybackPreferences()
        : PlaybackPreferences.fromJson(Map<String, dynamic>.from(playback)),
  );

  Audiobook _hydrateStoredBook(
    Map<String, Object?> value,
    Map<String, BookMetadata> metadataById,
  ) {
    final metadataId = value['metadataId'] as String?;
    final metadata = metadataId == null ? null : metadataById[metadataId];
    if (metadata == null) {
      throw StateError('Stored audiobook has no matching metadata.');
    }

    return hydrateBook(Map<String, dynamic>.from(value), metadata);
  }

  @override
  Future<void> restore(BookishBackup backup) async {
    final metadataById = _restoredMetadataById(backup);
    _validateRestoreReferences(backup, metadataById);

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

  void _validateRestoreReferences(
    BookishBackup backup,
    Map<String, BookMetadata> metadataById,
  ) {
    for (final note in backup.notes) {
      _requireMetadata(metadataById, note.metadataId, 'note', note.id);
    }
    for (final session in backup.sessions) {
      _requireMetadata(metadataById, session.metadataId, 'session', session.id);
    }
  }

  void _requireMetadata(
    Map<String, BookMetadata> metadataById,
    String metadataId,
    String recordType,
    String recordId,
  ) {
    if (metadataId.isEmpty || metadataById.containsKey(metadataId) == false) {
      throw StateError('Backup $recordType $recordId has no book metadata.');
    }
  }

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
      }),
      _settings.record('playback').put(transaction, settings.playback.toJson()),
    ).wait;
  }
}
