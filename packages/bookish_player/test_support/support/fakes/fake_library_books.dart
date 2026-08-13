import 'package:bookish_player/features/library/models/library_models.dart';
import 'package:bookish_player/features/library/models/audiobook_removal_mode.dart';
import 'package:bookish_player/features/library/repos/audiobook_repository.dart';
import 'package:bookish_player/features/library/repos/listening_history_repository.dart';
import 'package:bookish_player/features/library/models/listening_session.dart';
import 'package:bookish_player/features/notes/models/note_models.dart';

class FakeLibraryBooks
    implements AudiobookRepository, ListeningHistoryRepository {
  FakeLibraryBooks([this.books = const []]);

  List<Audiobook> books;
  Exception? getBookFailure;
  Exception? saveBookFailure;

  @override
  Future<List<Audiobook>> getBooks() async => books;

  @override
  Future<List<ListeningSession>> getListeningSessions() async => const [];

  @override
  Future<void> saveListeningSession(ListeningSession session) async {}

  @override
  Future<void> saveBook(Audiobook updated) async {
    if (saveBookFailure case final failure?) {
      throw failure;
    }
    books = [
      for (final book in books)
        if (book.id == updated.id) updated else book,
    ];
  }

  @override
  Future<Audiobook?> getBook(String id) async {
    if (getBookFailure case final failure?) {
      throw failure;
    }
    return books.where((book) => book.id == id).firstOrNull;
  }

  @override
  Future<void> updateProgress(String id, Duration position) async {}

  @override
  Future<void> updatePlaybackSpeed(String id, double speed) async {}

  @override
  Future<void> deleteBook(
    String id, {
    AudiobookRemovalMode mode = AudiobookRemovalMode.keepUserData,
  }) async {
    books = books.where((book) => book.id != id).toList();
  }

  @override
  Future<List<BookNote>> getNotes(String bookId) async => const [];

  @override
  Future<List<BookNote>> getAllNotes() async => const [];

  @override
  Future<void> saveNote(BookNote note) async {}

  @override
  Future<void> deleteNote(String id) async {}

  @override
  Future<List<BookMetadata>> getBookMetadata() async => const [];

  @override
  Future<BookMetadata?> findBookMetadata(String fingerprint) async => null;

  @override
  Future<void> replaceLibrary(
    List<Audiobook> books,
    List<BookNote> notes,
  ) async {
    this.books = books;
  }
}
