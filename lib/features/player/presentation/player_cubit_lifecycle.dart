part of 'player_cubit.dart';

extension PlayerCubitLifecycle on PlayerCubit {
  Future<void> removeBook(String bookId) async {
    if (state.book?.id != bookId) {
      return;
    }
    _sleep.cancel();
    await _commands.removeBook(bookId);
    _emit(const PlayerState());
  }

  Future<void> _handleCompleted() async {
    final current = state.book;
    if (current == null) {
      return;
    }
    final completedAt = DateTime.now();
    final duration = state.duration > Duration.zero
        ? state.duration
        : Duration(milliseconds: current.durationMs);
    final finished = current.copyWith(
      positionMs: duration.inMilliseconds,
      lastPlayedAt: completedAt,
      statusOverride: null,
      completedAt: completedAt,
    );
    await _books.saveBook(finished);
    _commands.markCompleted(finished);
    _emit(
      _timeline.project(state.copyWith(book: finished, position: duration)),
    );
    if (!state.playback.continueSeries || finished.series.trim().isEmpty) {
      return;
    }
    final next = _series.next(finished, await _books.getBooks());
    if (next == null) {
      return;
    }
    await open(next);
    await _audio.play();
  }

  void _handlePlaying(bool playing) {
    if (playing) {
      _sessions.start(state.position);
    } else {
      unawaited(_finishListeningSession());
    }
    _emit(state.copyWith(isPlaying: playing));
    final action = _resumePolicy.update(playing: playing);
    if (action.shouldSave) {
      unawaited(saveProgress());
    }
    if (action.rewind > Duration.zero) {
      unawaited(seek(state.position - action.rewind));
    }
  }

  Future<void> _finishListeningSession() async {
    await _sessions.finish(
      book: state.book,
      position: state.position,
      speed: state.speed,
    );
  }
}
