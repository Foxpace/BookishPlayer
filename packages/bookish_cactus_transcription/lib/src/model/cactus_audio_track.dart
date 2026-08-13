import 'package:freezed_annotation/freezed_annotation.dart';

part 'cactus_audio_track.freezed.dart';

@freezed
abstract class CactusAudioTrack with _$CactusAudioTrack {
  const factory CactusAudioTrack({
    required String filePath,
    required int durationMs,
  }) = _CactusAudioTrack;
}
