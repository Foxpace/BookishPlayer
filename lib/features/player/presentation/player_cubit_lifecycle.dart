part of 'player_cubit.dart';

extension _PlayerCubitLifecycle on PlayerCubit {
  Future<void> _handleCompleted() async {
    await saveProgress();
    final current = state.book;
    if (current == null ||
        !state.playback.continueSeries ||
        current.series.trim().isEmpty) {
      return;
    }
    final next = _series.next(current, await _books.getBooks());
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
