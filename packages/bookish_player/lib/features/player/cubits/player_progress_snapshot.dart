part of 'player_runtime_state.dart';

@freezed
abstract class PlayerProgressSnapshot with _$PlayerProgressSnapshot {
  const factory PlayerProgressSnapshot({
    required Audiobook book,
    required Duration position,
  }) = _PlayerProgressSnapshot;
}
