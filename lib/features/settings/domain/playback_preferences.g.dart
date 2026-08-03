// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playback_preferences.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlaybackPreferences _$PlaybackPreferencesFromJson(Map<String, dynamic> json) =>
    _PlaybackPreferences(
      rewindSeconds: (json['rewindSeconds'] as num?)?.toInt() ?? 15,
      forwardSeconds: (json['forwardSeconds'] as num?)?.toInt() ?? 15,
      shortenSilence: json['shortenSilence'] as bool? ?? false,
      voiceBoost: json['voiceBoost'] as bool? ?? false,
      sleepFadeSeconds: (json['sleepFadeSeconds'] as num?)?.toInt() ?? 8,
      largeSeekMinutes: (json['largeSeekMinutes'] as num?)?.toInt() ?? 10,
      continueSeries: json['continueSeries'] as bool? ?? true,
      chapterFallbackMinutes:
          (json['chapterFallbackMinutes'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$PlaybackPreferencesToJson(
  _PlaybackPreferences instance,
) => <String, dynamic>{
  'rewindSeconds': instance.rewindSeconds,
  'forwardSeconds': instance.forwardSeconds,
  'shortenSilence': instance.shortenSilence,
  'voiceBoost': instance.voiceBoost,
  'sleepFadeSeconds': instance.sleepFadeSeconds,
  'largeSeekMinutes': instance.largeSeekMinutes,
  'continueSeries': instance.continueSeries,
  'chapterFallbackMinutes': instance.chapterFallbackMinutes,
};
