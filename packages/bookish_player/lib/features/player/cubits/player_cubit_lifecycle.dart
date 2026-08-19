part of 'player_cubit.dart';

extension PlayerCubitLifecycle on PlayerCubit {
  Future<void> _handlePlaying({required bool playing}) async {
    if (_application.shouldSuppressPlaybackEvents()) {
      _emit(state.copyWith(isPlaying: false));
      return;
    }

    final result = await _application.updatePlaying(
      playing: playing,
      context: _playbackContext,
    );
    _emit(_playingState(result));
  }

  PlayerState _playingState(PlayerPlayingResult result) {
    final nextState = state.copyWith(isPlaying: result.playing);
    final position = result.position;
    return position == null
        ? nextState
        : nextState.copyWith(position: position).projectTimeline();
  }

  Future<void> finishListeningSession() =>
      _application.finishListeningSession(_playbackContext);
}
