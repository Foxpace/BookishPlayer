import 'package:injectable/injectable.dart';
import 'package:sembast/sembast.dart';

import '../../../../core/database/bookish_database.dart';
import '../../../notes/models/note_models.dart';
import '../../models/library_models.dart';
import '../../models/audiobook_removal_mode.dart';
import 'book_storage_codec.dart';

@lazySingleton
class AudiobookDao {
  AudiobookDao(BookishDatabase database) : _database = database.database;
  final Database _database;
  final _books = stringMapStoreFactory.store('books');
  final _notes = stringMapStoreFactory.store('notes');
  final _metadata = stringMapStoreFactory.store('book_metadata');
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
    return Future.wait([
      for (final record in records)
        _hydrate(Map<String, dynamic>.from(record.value)),
    ]);
  }

  Stream<List<Audiobook>> watchBooks() async* {
    yield* _books
        .query(
          finder: Finder(
            sortOrders: [
              SortOrder('lastPlayedAt', false),
              SortOrder('addedAt', false),
            ],
          ),
        )
        .onSnapshots(_database)
        .asyncMap(
          (records) => Future.wait([
            for (final record in records)
              _hydrate(Map<String, dynamic>.from(record.value)),
          ]),
        );
  }

  Future<Audiobook?> getBook(String id) async {
    final value = await _books.record(id).get(_database);
    return value == null ? null : _hydrate(Map<String, dynamic>.from(value));
  }

  Future<void> putBook(Audiobook book) async {
    await _database.transaction((transaction) async {
      final fingerprint = bookMetadataFingerprint(
        title: book.title,
        author: book.author,
        durationMs: book.durationMs,
      );
      final previous = await _findMetadata(
        transaction,
        metadataId: book.metadataId,
        bookId: book.id,
        fingerprint: fingerprint,
      );

      final metadata = book
          .toBookMetadata(
            metadataId: previous?.id,
            createdAt: previous?.createdAt,
          )
          .preserveArchivedValues(previous);

      await _metadata.record(metadata.id).put(transaction, metadata.toJson());
      await _books
          .record(book.id)
          .put(transaction, bookStorageJson(book, metadata.id));
    });
  }

  Future<void> updateProgress(String id, Duration position) async {
    await _books.record(id).update(_database, {
      'positionMs': position.inMilliseconds,
      'lastPlayedAt': DateTime.now().toIso8601String(),
    });
  }

  Future<void> updatePlaybackSpeed(String id, double speed) async {
    await _books.record(id).update(_database, {'playbackSpeed': speed});
  }

  Future<void> deleteBook(
    String id, {
    AudiobookRemovalMode mode = AudiobookRemovalMode.keepUserData,
  }) async {
    await _database.transaction((transaction) async {
      final stored = await _books.record(id).get(transaction);
      final metadataId = stored?['metadataId'] as String?;

      if (metadataId != null) {
        if (mode == AudiobookRemovalMode.deleteAllData) {
          await _deleteMetadataAndUserData(transaction, metadataId);
        } else {
          await _metadata.record(metadataId).update(transaction, {
            'activeBookId': null,
          });
        }
      }

      await _books.record(id).delete(transaction);
    });
  }

  Future<void> _deleteMetadataAndUserData(
    Transaction transaction,
    String metadataId,
  ) async {
    final matchingMetadata = Filter.equals('metadataId', metadataId);
    final finder = Finder(filter: matchingMetadata);

    await _notes.delete(transaction, finder: finder);
    await _sessions.delete(transaction, finder: finder);
    await _metadata.record(metadataId).delete(transaction);
  }

  Future<List<BookNote>> getNotes(String bookId) async {
    final book = await _books.record(bookId).get(_database);
    final metadataId = book?['metadataId'] as String?;
    final records = await _notes.find(
      _database,
      finder: Finder(
        filter: Filter.equals('metadataId', metadataId),
        sortOrders: [SortOrder('positionMs')],
      ),
    );
    return [
      for (final record in records)
        parseStoredNote(record.key, Map<String, dynamic>.from(record.value)),
    ];
  }

  Future<void> putNote(BookNote note) async {
    final metadataId = note.metadataId;
    if (metadataId.isEmpty) {
      throw StateError('Book notes require a metadata identity.');
    }
    await _notes
        .record(note.id)
        .put(_database, noteStorageJson(note, metadataId));
  }

  Future<void> deleteNote(String id) => _notes.record(id).delete(_database);

  Future<List<BookNote>> getAllNotes() async {
    final records = await _notes.find(_database);
    return [
      for (final record in records)
        parseStoredNote(record.key, Map<String, dynamic>.from(record.value)),
    ];
  }

  Future<List<BookMetadata>> getBookMetadata() async {
    final records = await _metadata.find(
      _database,
      finder: Finder(sortOrders: [SortOrder('createdAt', false)]),
    );
    return [
      for (final record in records)
        parseStoredMetadata(
          record.key,
          Map<String, dynamic>.from(record.value),
        ),
    ];
  }

  Future<BookMetadata?> findBookMetadata(String fingerprint) async {
    final record = await _metadata.findFirst(
      _database,
      finder: Finder(filter: Filter.equals('fingerprint', fingerprint)),
    );
    return record == null
        ? null
        : parseStoredMetadata(
            record.key,
            Map<String, dynamic>.from(record.value),
          );
  }

  Future<void> replaceLibrary(
    List<Audiobook> books,
    List<BookNote> notes,
  ) async {
    await _database.transaction((transaction) async {
      await _books.delete(transaction);
      await _notes.delete(transaction);

      final metadataIds = await _replaceBooks(transaction, books);
      await _replaceNotes(transaction, notes, metadataIds);
    });
  }

  Future<Set<String>> _replaceBooks(
    Transaction transaction,
    List<Audiobook> books,
  ) async {
    final metadataIds = <String>{};

    for (final book in books) {
      final metadata = book.toBookMetadata();
      metadataIds.add(metadata.id);

      await _metadata.record(metadata.id).put(transaction, metadata.toJson());
      await _books
          .record(book.id)
          .put(transaction, bookStorageJson(book, metadata.id));
    }

    return metadataIds;
  }

  Future<void> _replaceNotes(
    Transaction transaction,
    List<BookNote> notes,
    Set<String> metadataIds,
  ) async {
    for (final note in notes) {
      if (note.metadataId.isEmpty ||
          metadataIds.contains(note.metadataId) == false) {
        throw StateError('Book notes require a metadata identity.');
      }

      await _notes
          .record(note.id)
          .put(transaction, noteStorageJson(note, note.metadataId));
    }
  }

  Future<Audiobook> _hydrate(Map<String, dynamic> stored) async {
    final recordId = stored['id'] ?? '<unknown>';
    try {
      return await _hydrateStoredBook(stored);
    } catch (error) {
      throw FormatException(
        'Could not parse audiobook record "$recordId": $error',
      );
    }
  }

  Future<Audiobook> _hydrateStoredBook(Map<String, dynamic> stored) async {
    final metadataId = stored['metadataId'] as String;
    final value = await _metadata.record(metadataId).get(_database);
    if (value == null) {
      throw StateError('missing metadata record "$metadataId"');
    }
    return hydrateBook(
      stored,
      parseStoredMetadata(metadataId, Map<String, dynamic>.from(value)),
    );
  }

  Future<BookMetadata?> _findMetadata(
    DatabaseClient client, {
    required String metadataId,
    required String bookId,
    required String fingerprint,
  }) async {
    if (metadataId.isNotEmpty) {
      final value = await _metadata.record(metadataId).get(client);
      if (value != null) {
        return BookMetadata.fromJson(Map<String, dynamic>.from(value));
      }
    }

    final record = await _metadata.findFirst(
      client,
      finder: Finder(
        filter: Filter.or([
          Filter.equals('activeBookId', bookId),
          Filter.equals('fingerprint', fingerprint),
        ]),
      ),
    );

    return record == null
        ? null
        : parseStoredMetadata(
            record.key,
            Map<String, dynamic>.from(record.value),
          );
  }
}
