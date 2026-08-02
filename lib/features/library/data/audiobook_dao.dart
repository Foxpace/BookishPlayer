import 'package:sembast/sembast.dart';
import 'package:injectable/injectable.dart';

import '../../../core/database/bookish_database.dart';
import '../../player/domain/book_note.dart';
import '../domain/audiobook.dart';

@lazySingleton
class AudiobookDao {
  AudiobookDao(BookishDatabase database) : _database = database.database;

  final Database _database;
  final _books = stringMapStoreFactory.store('books');
  final _notes = stringMapStoreFactory.store('notes');

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
