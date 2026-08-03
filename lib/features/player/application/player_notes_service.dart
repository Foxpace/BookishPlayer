import 'package:uuid/uuid.dart';

import '../../library/domain/audiobook.dart';
import '../../library/domain/audiobook_repository.dart';
import '../../portability/domain/local_export_repository.dart';
import '../domain/book_note.dart';

class PlayerNotesService {
  PlayerNotesService(this._books, this._exports);

  final AudiobookRepository _books;
  final LocalExportRepository _exports;
  final _uuid = const Uuid();

  Future<List<BookNote>> load(String bookId) => _books.getNotes(bookId);

  Future<List<BookNote>> add({
    required Audiobook book,
    required List<BookNote> notes,
    required String text,
    required Duration position,
    required Duration? endPosition,
    required String? chapterTitle,
  }) async {
    final note = BookNote(
      id: _uuid.v4(),
      bookId: book.id,
      positionMs: position.inMilliseconds,
      text: text,
      createdAt: DateTime.now(),
      chapterTitle: chapterTitle,
      endPositionMs: endPosition?.inMilliseconds,
    );
    await _books.saveNote(note);
    return [...notes, note]
      ..sort((left, right) => left.positionMs.compareTo(right.positionMs));
  }

  Future<List<BookNote>> delete(List<BookNote> notes, BookNote note) async {
    await _books.deleteNote(note.id);
    return notes.where((item) => item.id != note.id).toList();
  }

  Future<bool> export(Audiobook book, List<BookNote> notes) =>
      _exports.exportNotes(book, notes);
}
