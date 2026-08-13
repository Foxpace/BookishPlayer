import 'package:freezed_annotation/freezed_annotation.dart';

import '../../library/models/library_models.dart';

part 'player_runtime_state.freezed.dart';
part 'player_progress_snapshot.dart';
part 'player_runtime_state_behavior.dart';

@freezed
abstract class PlayerRuntimeState with _$PlayerRuntimeState {
  const PlayerRuntimeState._();
  const factory PlayerRuntimeState({
    DateTime? pausedAt,
    DateTime? listeningStartedAt,
    Duration? listeningStartPosition,
    @Default(false) bool wasPlaying,
    DateTime? lastProgressSavedAt,
    @Default(false) bool progressWriteInFlight,
    PlayerProgressSnapshot? pendingProgress,
    @Default(false) bool suppressingPlaybackEvents,
  }) = _PlayerRuntimeState;
}
