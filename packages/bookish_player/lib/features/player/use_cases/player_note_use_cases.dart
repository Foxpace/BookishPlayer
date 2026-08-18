import 'package:injectable/injectable.dart';

import '../../library/models/library_models.dart';
import '../../notes/use_cases/player_notes_service.dart';
import '../../notes/models/book_note.dart';
import '../models/share_origin.dart';

@lazySingleton
class PlayerNoteUseCases {
  const PlayerNoteUseCases(this._notes);

  final PlayerNotesService _notes;

  Future<List<BookNote>> add({
    required Audiobook? book,
    required List<BookNote> notes,
    required PlayerNoteInput input,
  }) async {
    final clean = input.text.trim();
    if (book == null || clean.isEmpty) {
      return notes;
    }

    return _notes.add(
      book: book,
      notes: notes,
      input: (
        text: clean,
        position: input.position,
        endPosition: input.endPosition,
        chapterTitle: input.chapterTitle,
        kind: input.kind,
      ),
    );
  }

  Future<List<BookNote>> delete(List<BookNote> notes, BookNote note) =>
      _notes.delete(notes, note);

  Future<List<BookNote>> update({
    required List<BookNote> notes,
    required BookNote note,
    required String? title,
    required String text,
  }) {
    final cleanText = text.trim();
    if (cleanText.isEmpty) {
      return Future.value(notes);
    }
    final cleanTitle = title?.trim();
    return _notes.update(
      notes: notes,
      note: note,
      title: cleanTitle == null || cleanTitle.isEmpty ? null : cleanTitle,
      text: cleanText,
    );
  }

  Future<void> share(Audiobook? book, BookNote note, {ShareOrigin? origin}) =>
      book == null ? Future.value() : _notes.share(book, note, origin: origin);

  Future<bool> export(Audiobook? book, List<BookNote> notes) =>
      book == null ? Future.value(false) : _notes.export(book, notes);
}
