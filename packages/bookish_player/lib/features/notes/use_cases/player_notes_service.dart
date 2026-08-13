import 'package:injectable/injectable.dart';

import '../../../core/foundation/clock.dart';
import '../../../core/foundation/id_generator.dart';
import '../../library/models/library_models.dart';
import '../../player/repos/player_repositories.dart';
import '../../portability/repos/local_export_repository.dart';
import '../models/note_models.dart';
import '../repos/book_note_repository.dart';

typedef PlayerNoteInput = ({
  String text,
  Duration position,
  Duration? endPosition,
  String? chapterTitle,
  BookNoteKind kind,
});

@injectable
class PlayerNotesService {
  PlayerNotesService(
    this._books,
    this._exports,
    this._sharing,
    this._clock,
    this._ids,
  );

  final BookNoteRepository _books;
  final LocalExportRepository _exports;
  final QuoteShareRepository _sharing;
  final Clock _clock;
  final IdGenerator _ids;

  Future<List<BookNote>> load(String bookId) => _books.getNotes(bookId);

  Future<List<BookNote>> add({
    required Audiobook book,
    required List<BookNote> notes,
    required PlayerNoteInput input,
  }) async {
    final note = _newNote(book, input);

    await _books.saveNote(note);
    return [...notes, note]
      ..sort((left, right) => left.positionMs.compareTo(right.positionMs));
  }

  BookNote _newNote(Audiobook book, PlayerNoteInput input) => BookNote(
    id: _ids.generate(),
    metadataId: book.metadataId,
    positionMs: input.position.inMilliseconds,
    text: input.text,
    createdAt: _clock.now(),
    chapterTitle: input.chapterTitle,
    endPositionMs: input.endPosition?.inMilliseconds,
    kind: input.kind,
  );

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
