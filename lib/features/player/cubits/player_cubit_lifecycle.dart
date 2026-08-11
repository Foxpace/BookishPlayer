part of 'player_cubit.dart';

extension PlayerCubitLifecycle on PlayerCubit {
  Future<void> _handlePlaying({required bool playing}) async {
    if (_runtime.suppressingPlaybackEvents) {
      _emit(state.copyWith(isPlaying: false));
      return;
    }

    await _updateListeningSession(playing);
    final result = await _useCases.lifecycle.updatePlaying((
      playing: playing,
      book: state.book,
      position: state.position,
      duration: state.duration,
      chapterStart: state.chapterStart,
      wasPlaying: _runtime.wasPlaying,
      pausedAt: _runtime.pausedAt,
    ));
    _storePlayingRuntime(result);

    if (result.shouldSave) {
      await saveProgress();
    }
    _emit(_playingState(result));
  }

  Future<void> _updateListeningSession(bool playing) async {
    if (playing && _runtime.listeningStartedAt == null) {
      final session = _useCases.lifecycle.startListeningSession(state.position);
      _runtime = _runtime.copyWith(
        listeningStartedAt: session.startedAt,
        listeningStartPosition: session.startPosition,
      );
    } else if (playing == false) {
      await finishListeningSession();
    }
  }

  void _storePlayingRuntime(PlayerPlayingResult result) {
    _runtime = _runtime.copyWith(
      wasPlaying: result.wasPlaying,
      pausedAt: result.pausedAt,
    );
  }

  PlayerState _playingState(PlayerPlayingResult result) {
    final nextState = state.copyWith(isPlaying: result.playing);
    final position = result.position;
    return position == null
        ? nextState
        : nextState.copyWith(position: position).projectTimeline();
  }

  Future<void> finishListeningSession() {
    final startedAt = _runtime.listeningStartedAt;
    final startPosition = _runtime.listeningStartPosition;
    _runtime = _runtime.copyWith(
      listeningStartedAt: null,
      listeningStartPosition: null,
    );
    return _useCases.lifecycle.finishListeningSession(
      startedAt: startedAt,
      startPosition: startPosition,
      book: state.book,
      position: state.position,
      speed: state.speed,
    );
  }
}
