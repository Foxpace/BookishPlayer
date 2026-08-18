import '../models/book_note.dart';

abstract interface class BookNoteRepository {
  Future<List<BookNote>> getNotes(String bookId);
  Future<void> saveNote(BookNote note);
  Future<void> deleteNote(String id);
  Future<List<BookNote>> getAllNotes();
}
