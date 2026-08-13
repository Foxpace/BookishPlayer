part of 'player_runtime_state.dart';

extension PlayerRuntimeStateBehavior on PlayerRuntimeState {
  DateTime get progressCheckpoint =>
      lastProgressSavedAt ?? DateTime.fromMillisecondsSinceEpoch(0);

  PlayerRuntimeState clearPlaybackLifecycle() => copyWith(
    pausedAt: null,
    listeningStartedAt: null,
    listeningStartPosition: null,
    wasPlaying: false,
    lastProgressSavedAt: null,
    progressWriteInFlight: false,
    pendingProgress: null,
  );
}
