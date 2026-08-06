import 'package:uuid/uuid.dart';

import '../../library/domain/audiobook.dart';
import '../../library/domain/book_note_repository.dart';
import '../../portability/domain/local_export_repository.dart';
import '../domain/book_note.dart';
import '../domain/quote_share_repository.dart';

class PlayerNotesService {
  PlayerNotesService(this._books, this._exports, this._sharing);

  final BookNoteRepository _books;
  final LocalExportRepository _exports;
  final QuoteShareRepository _sharing;
  final _uuid = const Uuid();

  Future<List<BookNote>> load(String bookId) => _books.getNotes(bookId);

  Future<List<BookNote>> add({
    required Audiobook book,
    required List<BookNote> notes,
    required String text,
    required Duration position,
    required Duration? endPosition,
    required String? chapterTitle,
    BookNoteKind kind = BookNoteKind.note,
  }) async {
    final note = BookNote(
      id: _uuid.v4(),
      metadataId: book.metadataId,
      positionMs: position.inMilliseconds,
      text: text,
      createdAt: DateTime.now(),
      chapterTitle: chapterTitle,
      endPositionMs: endPosition?.inMilliseconds,
      kind: kind,
    );
    await _books.saveNote(note);
    return [...notes, note]
      ..sort((left, right) => left.positionMs.compareTo(right.positionMs));
  }

  Future<List<BookNote>> delete(List<BookNote> notes, BookNote note) async {
    await _books.deleteNote(note.id);
    return notes.where((item) => item.id != note.id).toList();
  }

  Future<List<BookNote>> update({
    required List<BookNote> notes,
    required BookNote note,
    required String? title,
    required String text,
  }) async {
    final updated = note.copyWith(title: title, text: text);
    await _books.saveNote(updated);
    return [
      for (final item in notes)
        if (item.id == note.id) updated else item,
    ];
  }

  Future<void> share(Audiobook book, BookNote note, {ShareOrigin? origin}) =>
      _sharing.share(
        text: [?note.title, note.text].join('\n\n'),
        subject: 'Note from ${book.title}',
        origin: origin,
      );

  Future<bool> export(Audiobook book, List<BookNote> notes) =>
      _exports.exportNotes(book, notes);
}
