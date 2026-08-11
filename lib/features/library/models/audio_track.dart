import 'package:freezed_annotation/freezed_annotation.dart';
part 'audio_track.freezed.dart';
part 'audio_track.g.dart';

@freezed
abstract class AudioTrack with _$AudioTrack {
  const factory AudioTrack({
    required String id,
    required String title,
    required String filePath,
    required int durationMs,
    required int order,
  }) = _AudioTrack;

  factory AudioTrack.fromJson(Map<String, dynamic> json) =>
      _$AudioTrackFromJson(json);
}
