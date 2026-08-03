import 'package:freezed_annotation/freezed_annotation.dart';

part 'playback_preferences.freezed.dart';
part 'playback_preferences.g.dart';

@freezed
abstract class PlaybackPreferences with _$PlaybackPreferences {
  const factory PlaybackPreferences({
    @Default(15) int rewindSeconds,
    @Default(15) int forwardSeconds,
    @Default(false) bool shortenSilence,
    @Default(false) bool voiceBoost,
    @Default(8) int sleepFadeSeconds,
    @Default(10) int largeSeekMinutes,
    @Default(true) bool continueSeries,
    @Default(0) int chapterFallbackMinutes,
  }) = _PlaybackPreferences;

  factory PlaybackPreferences.fromJson(Map<String, dynamic> json) =>
      _$PlaybackPreferencesFromJson(json);
}
