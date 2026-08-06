import 'package:injectable/injectable.dart';
import 'package:sembast/sembast.dart';

import '../../../core/database/bookish_database.dart';
import '../../library/data/book_storage_codec.dart';
import '../../library/domain/book_metadata.dart';
import '../../library/domain/listening_session.dart';
import '../../player/domain/book_note.dart';
import '../../settings/domain/playback_preferences.dart';
import '../domain/backup_store_repository.dart';
import '../domain/bookish_backup.dart';

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
    final bookRecords = await _books.find(_database);
    final noteRecords = await _notes.find(_database);
    final metadataRecords = await _metadata.find(_database);
    final sessionRecords = await _sessions.find(_database);
    final metadataById = {
      for (final record in metadataRecords)
        record.key: BookMetadata.fromJson(
          Map<String, dynamic>.from(record.value),
        ),
    };
    final appearance = await _settings.record('appearance').get(_database);
    final playback = await _settings.record('playback').get(_database);
    return BookishBackup(
      exportedAt: DateTime.now(),
      books: [
        for (final record in bookRecords)
          hydrateBook(
            Map<String, dynamic>.from(record.value),
            metadataById[record.value['metadataId']]!,
          ),
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
      settings: BackupSettings(
        theme: appearance?['theme'] as String? ?? 'system',
        playback: playback == null
            ? const PlaybackPreferences()
            : PlaybackPreferences.fromJson(Map<String, dynamic>.from(playback)),
      ),
    );
  }

  @override
  Future<void> restore(BookishBackup backup) async {
    await _database.transaction((transaction) async {
      await _books.delete(transaction);
      await _notes.delete(transaction);
      await _metadata.delete(transaction);
      await _sessions.delete(transaction);
      final metadataById = {
        for (final item in backup.bookMetadata) item.id: item,
      };
      for (final book in backup.books) {
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
        final metadata =
            metadataForBook(
              book,
              metadataId: previous?.id,
              createdAt: previous?.createdAt,
            ).copyWith(
              artworkPath: book.artworkPath ?? previous?.artworkPath,
              completedAt: book.completedAt ?? previous?.completedAt,
            );
        metadataById[metadata.id] = metadata;
        await _metadata.record(metadata.id).put(transaction, metadata.toJson());
        await _books
            .record(book.id)
            .put(transaction, bookStorageJson(book, metadata.id));
      }
      for (final metadata in metadataById.values) {
        await _metadata.record(metadata.id).put(transaction, metadata.toJson());
      }
      for (final note in backup.notes) {
        final metadataId = note.metadataId;
        if (metadataId.isEmpty || !metadataById.containsKey(metadataId)) {
          throw StateError('Backup note ${note.id} has no book metadata.');
        }
        await _notes
            .record(note.id)
            .put(transaction, noteStorageJson(note, metadataId));
      }
      for (final session in backup.sessions) {
        final metadataId = session.metadataId;
        if (metadataId.isEmpty || !metadataById.containsKey(metadataId)) {
          throw StateError(
            'Backup session ${session.id} has no book metadata.',
          );
        }
        await _sessions
            .record(session.id)
            .put(transaction, listeningSessionStorageJson(session, metadataId));
      }
      await _settings.record('appearance').put(transaction, {
        'theme': backup.settings.theme,
      });
      await _settings
          .record('playback')
          .put(transaction, backup.settings.playback.toJson());
    });
  }
}
