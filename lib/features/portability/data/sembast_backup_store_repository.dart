import 'package:injectable/injectable.dart';
import 'package:sembast/sembast.dart';

import '../../../core/database/bookish_database.dart';
import '../../library/domain/audiobook.dart';
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
  final _sessions = stringMapStoreFactory.store('listening_sessions');
  final _settings = stringMapStoreFactory.store('settings');

  @override
  Future<BookishBackup> snapshot() async {
    final books = await _books.find(_database);
    final notes = await _notes.find(_database);
    final sessions = await _sessions.find(_database);
    final appearance = await _settings.record('appearance').get(_database);
    final playback = await _settings.record('playback').get(_database);
    return BookishBackup(
      exportedAt: DateTime.now(),
      books: [
        for (final record in books)
          Audiobook.fromJson(Map<String, dynamic>.from(record.value)),
      ],
      notes: [
        for (final record in notes)
          BookNote.fromJson(Map<String, dynamic>.from(record.value)),
      ],
      sessions: [
        for (final record in sessions)
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
      await _sessions.delete(transaction);
      for (final book in backup.books) {
        await _books.record(book.id).put(transaction, book.toJson());
      }
      for (final note in backup.notes) {
        await _notes.record(note.id).put(transaction, note.toJson());
      }
      for (final session in backup.sessions) {
        await _sessions.record(session.id).put(transaction, session.toJson());
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
