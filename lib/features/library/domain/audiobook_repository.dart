import '../../player/domain/book_note.dart';
import 'audiobook.dart';

abstract interface class AudiobookRepository {
  Future<List<Audiobook>> getBooks();
  Future<Audiobook?> getBook(String id);
  Future<void> saveBook(Audiobook book);
  Future<void> updateProgress(String id, Duration position);
  Future<void> updatePlaybackSpeed(String id, double speed);
  Future<void> deleteBook(String id);
  Future<List<BookNote>> getNotes(String bookId);
  Future<void> saveNote(BookNote note);
  Future<void> deleteNote(String id);
  Future<List<BookNote>> getAllNotes();
  Future<void> replaceLibrary(List<Audiobook> books, List<BookNote> notes);
}
