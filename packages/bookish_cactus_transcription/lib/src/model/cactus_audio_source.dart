import 'package:freezed_annotation/freezed_annotation.dart';

import 'cactus_audio_track.dart';

part 'cactus_audio_source.freezed.dart';

@freezed
abstract class CactusAudioSource with _$CactusAudioSource {
  const factory CactusAudioSource({required List<CactusAudioTrack> tracks}) =
      _CactusAudioSource;
}
