import 'package:injectable/injectable.dart';

import '../../../player/repos/audio_player_repository.dart';
import '../media_probe.dart';

@LazySingleton(as: MediaProbe)
class AudioPlayerMediaProbe implements MediaProbe {
  AudioPlayerMediaProbe(this._audio);

  final AudioPlayerRepository _audio;

  @override
  Future<Duration> probeDuration(String path) => _audio.probeDuration(path);
}
