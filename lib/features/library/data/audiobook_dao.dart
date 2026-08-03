import 'package:sembast/sembast.dart';
import 'package:injectable/injectable.dart';

import '../../../core/database/bookish_database.dart';
import '../../player/domain/book_note.dart';
import '../domain/audiobook.dart';
import '../domain/listening_session.dart';

@lazySingleton
class AudiobookDao {
  AudiobookDao(BookishDatabase database) : _database = database.database;

  final Database _database;
  final _books = stringMapStoreFactory.store('books');
  final _notes = stringMapStoreFactory.store('notes');
  final _sessions = stringMapStoreFactory.store('listening_sessions');

  Future<List<Audiobook>> getBooks() async {
    final records = await _books.find(
      _database,
      finder: Finder(
        sortOrders: [
          SortOrder('lastPlayedAt', false),
          SortOrder('addedAt', false),
        ],
      ),
    );
    return records
        .map(
          (record) =>
              Audiobook.fromJson(Map<String, dynamic>.from(record.value)),
        )
        .toList();
  }

  Stream<List<Audiobook>> watchBooks() => _books
      .query(
        finder: Finder(
          sortOrders: [
            SortOrder('lastPlayedAt', false),
            SortOrder('addedAt', false),
          ],
        ),
      )
      .onSnapshots(_database)
      .map(
        (records) => [
          for (final record in records)
            Audiobook.fromJson(Map<String, dynamic>.from(record.value)),
        ],
      );

  Future<Audiobook?> getBook(String id) async {
    final value = await _books.record(id).get(_database);
    return value == null
        ? null
        : Audiobook.fromJson(Map<String, dynamic>.from(value));
  }

  Future<void> putBook(Audiobook book) =>
      _books.record(book.id).put(_database, book.toJson());

  Future<void> updateProgress(String id, Duration position) async {
    await _books.record(id).update(_database, {
      'positionMs': position.inMilliseconds,
      'lastPlayedAt': DateTime.now().toIso8601String(),
    });
  }

  Future<void> updatePlaybackSpeed(String id, double speed) async {
    await _books.record(id).update(_database, {'playbackSpeed': speed});
  }

  Future<void> deleteBook(String id) async {
    await _database.transaction((transaction) async {
      await _books.record(id).delete(transaction);
      await _notes.delete(
        transaction,
        finder: Finder(filter: Filter.equals('bookId', id)),
      );
      await _sessions.delete(
        transaction,
        finder: Finder(filter: Filter.equals('bookId', id)),
      );
    });
  }

  Future<List<BookNote>> getNotes(String bookId) async {
    final records = await _notes.find(
      _database,
      finder: Finder(
        filter: Filter.equals('bookId', bookId),
        sortOrders: [SortOrder('positionMs')],
      ),
    );
    return records
        .map(
          (record) =>
              BookNote.fromJson(Map<String, dynamic>.from(record.value)),
        )
        .toList();
  }

  Future<void> putNote(BookNote note) =>
      _notes.record(note.id).put(_database, note.toJson());

  Future<void> deleteNote(String id) => _notes.record(id).delete(_database);

  Future<List<BookNote>> getAllNotes() async {
    final records = await _notes.find(_database);
    return records
        .map(
          (record) =>
              BookNote.fromJson(Map<String, dynamic>.from(record.value)),
        )
        .toList();
  }

  Future<List<ListeningSession>> getListeningSessions() async {
    final records = await _sessions.find(
      _database,
      finder: Finder(sortOrders: [SortOrder('startedAt', false)]),
    );
    return records
        .map(
          (record) => ListeningSession.fromJson(
            Map<String, dynamic>.from(record.value),
          ),
        )
        .toList();
  }

  Future<void> putListeningSession(ListeningSession session) =>
      _sessions.record(session.id).put(_database, session.toJson());

  Future<void> replaceListeningSessions(List<ListeningSession> sessions) async {
    await _database.transaction((transaction) async {
      await _sessions.delete(transaction);
      for (final session in sessions) {
        await _sessions.record(session.id).put(transaction, session.toJson());
      }
    });
  }

  Future<void> replaceLibrary(
    List<Audiobook> books,
    List<BookNote> notes,
  ) async {
    await _database.transaction((transaction) async {
      await _books.delete(transaction);
      await _notes.delete(transaction);
      for (final book in books) {
        await _books.record(book.id).put(transaction, book.toJson());
      }
      for (final note in notes) {
        await _notes.record(note.id).put(transaction, note.toJson());
      }
    });
  }
}
