part of 'player_cubit.dart';

extension PlayerCubitNotesAndSleep on PlayerCubit {
  Future<void> addNote(String text) => _addMoment(text, BookNoteKind.note);
  Future<void> addBookmark() => _addMoment('Bookmark', BookNoteKind.bookmark);
  Future<void> addVoiceNote(String text) =>
      _addMoment(text, BookNoteKind.voice);

  Future<void> _addMoment(String text, BookNoteKind kind) => _applyNotes(
    _useCases.notes.add(
      book: state.book,
      notes: state.notes,
      input: (
        text: text,
        position: state.position,
        endPosition: null,
        chapterTitle: state.currentChapter?.title,
        kind: kind,
      ),
    ),
  );

  Future<void> addNoteAt(
    String text,
    Duration position, {
    String? chapterTitle,
    Duration? endPosition,
  }) => _applyNotes(
    _useCases.notes.add(
      book: state.book,
      notes: state.notes,
      input: (
        text: text,
        position: position.clampedTo(state.duration),
        endPosition: endPosition?.clampedTo(state.duration),
        chapterTitle: chapterTitle,
        kind: BookNoteKind.note,
      ),
    ),
  );

  Future<void> deleteNote(BookNote note) =>
      _applyNotes(_useCases.notes.delete(state.notes, note));

  Future<void> updateNote(
    BookNote note, {
    required String? title,
    required String text,
  }) => _applyNotes(
    _useCases.notes.update(
      notes: state.notes,
      note: note,
      title: title,
      text: text,
    ),
  );

  Future<void> shareNote(BookNote note, {ShareOrigin? origin}) =>
      _useCases.notes.share(state.book, note, origin: origin);
  Future<bool> exportNotes() => _useCases.notes.export(state.book, state.notes);

  Future<void> _applyNotes(Future<List<BookNote>> operation) async {
    final notes = await operation;
    if (!identical(notes, state.notes)) {
      _emit(state.copyWith(notes: notes));
    }
  }

  void setSleepTimer(Duration duration) {
    _cancelSleepTimer();
    _sleepTimer = _useCases.sleep.scheduleFixed(
      duration: duration,
      fadeSeconds: state.playback.sleepFadeSeconds,
      onFinished: _finishSleep,
    );
    _emit(
      state.copyWith(
        sleepTimerType: SleepTimerType.fixed,
        sleepRemainingMinutes: (duration.inSeconds + 59) ~/ 60,
        sleepChapterEndMs: null,
      ),
    );
  }

  Future<void> _finishSleep() async {
    await saveProgress();
    cancelSleepTimer();
  }

  void sleepAtEndOfChapter() {
    final book = state.book;
    if (book == null) {
      return;
    }

    _cancelSleepTimer();
    final scheduled = _useCases.sleep.scheduleChapterEnd(
      book: book,
      position: state.position,
      fallbackMinutes: state.playback.chapterFallbackMinutes,
      fadeSeconds: state.playback.sleepFadeSeconds,
      onFinished: _finishSleep,
    );

    _sleepTimer = scheduled.fallbackTimer;
    _emit(
      state.copyWith(
        sleepTimerType: SleepTimerType.endOfChapter,
        sleepRemainingMinutes: null,
        sleepChapterEndMs: scheduled.chapterEnd,
      ),
    );
  }

  void cancelSleepTimer() {
    _cancelSleepTimer();
    _emit(_states.clearSleep(state));
  }

  void _cancelSleepTimer() {
    _sleepTimer?.cancel();
    _sleepTimer = null;
  }

  Future<void> _sleepAtChapterBoundary() async {
    if (state.sleepChapterEndMs == null) {
      return;
    }
    await _useCases.sleep.pause();
    await saveProgress();
    cancelSleepTimer();
  }
}
