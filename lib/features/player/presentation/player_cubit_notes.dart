part of 'player_cubit.dart';

extension PlayerCubitNotes on PlayerCubit {
  Future<void> addNote(String text) => addNoteAt(
    text,
    state.position,
    chapterTitle: state.currentChapter?.title,
  );

  Future<void> addBookmark() => _addMoment('Bookmark', BookNoteKind.bookmark);

  Future<void> addVoiceNote(String text) =>
      _addMoment(text.trim(), BookNoteKind.voice);

  Future<void> _addMoment(String text, BookNoteKind kind) async {
    final book = state.book;
    if (book == null || text.isEmpty) {
      return;
    }
    final notes = await _notes.add(
      book: book,
      notes: state.notes,
      text: text,
      position: state.position,
      endPosition: null,
      chapterTitle: state.currentChapter?.title,
      kind: kind,
    );
    _emit(state.copyWith(notes: notes));
  }

  Future<void> addNoteAt(
    String text,
    Duration position, {
    String? chapterTitle,
    Duration? endPosition,
  }) async {
    final book = state.book;
    final clean = text.trim();
    if (book == null || clean.isEmpty) {
      return;
    }
    final notes = await _notes.add(
      book: book,
      notes: state.notes,
      text: clean,
      position: _timeline.bounded(position, state.duration),
      endPosition: endPosition == null
          ? null
          : _timeline.bounded(endPosition, state.duration),
      chapterTitle: chapterTitle,
    );
    _emit(state.copyWith(notes: notes));
  }

  Future<void> deleteNote(BookNote note) async {
    _emit(state.copyWith(notes: await _notes.delete(state.notes, note)));
  }

  Future<void> updateNote(
    BookNote note, {
    required String? title,
    required String text,
  }) async {
    final cleanText = text.trim();
    if (cleanText.isEmpty) {
      return;
    }
    final cleanTitle = title?.trim();
    _emit(
      state.copyWith(
        notes: await _notes.update(
          notes: state.notes,
          note: note,
          title: cleanTitle == null || cleanTitle.isEmpty ? null : cleanTitle,
          text: cleanText,
        ),
      ),
    );
  }

  Future<void> shareNote(BookNote note, {ShareOrigin? origin}) async {
    final book = state.book;
    if (book != null) {
      await _notes.share(book, note, origin: origin);
    }
  }

  Future<bool> exportNotes() async {
    final book = state.book;
    return book == null ? false : _notes.export(book, state.notes);
  }
}
