import 'package:bookish_player/features/library/models/audiobook_removal_mode.dart';
import 'package:bookish_player/features/library/models/listening_session.dart';
import 'player_cubit_builder.dart';
import 'player_test_support.dart';

class FakeBooks implements PlayerTestBooks {
  FakeBooks(this.book) : _books = {book.id: book};

  FakeBooks.withBooks(List<Audiobook> books)
    : book = books.first,
      _books = {for (final book in books) book.id: book};

  Audiobook book;
  final Map<String, Audiobook> _books;
  Duration? progress;
  double? savedSpeed;
  BookNote? savedNote;

  @override
  Future<Audiobook?> getBook(String id) async => _books[id];
  @override
  Future<List<Audiobook>> getBooks() async => _books.values.toList();
  @override
  Future<void> saveBook(Audiobook book) async {
    this.book = book;
    _books[book.id] = book;
  }

  @override
  Future<void> updateProgress(String id, Duration position) async {
    progress = position;
    final stored = _books[id];
    if (stored != null) {
      final updated = stored.copyWith(positionMs: position.inMilliseconds);
      _books[id] = updated;
      if (book.id == id) {
        book = updated;
      }
    }
  }

  @override
  Future<void> updatePlaybackSpeed(String id, double speed) async =>
      savedSpeed = speed;
  @override
  Future<List<BookNote>> getNotes(String bookId) async => [];
  @override
  Future<List<BookNote>> getAllNotes() async => [];
  @override
  Future<List<BookMetadata>> getBookMetadata() async => [];
  @override
  Future<BookMetadata?> findBookMetadata(String fingerprint) async => null;
  @override
  Future<List<ListeningSession>> getListeningSessions() async => [];
  @override
  Future<void> saveListeningSession(ListeningSession session) async {}
  @override
  Future<void> saveNote(BookNote note) async => savedNote = note;
  @override
  Future<void> deleteNote(String id) async {}
  @override
  Future<void> deleteBook(
    String id, {
    AudiobookRemovalMode mode = AudiobookRemovalMode.keepUserData,
  }) async {}
  @override
  Future<void> replaceLibrary(
    List<Audiobook> books,
    List<BookNote> notes,
  ) async {}
}
