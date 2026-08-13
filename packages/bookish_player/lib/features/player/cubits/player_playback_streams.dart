import 'dart:async';

import 'package:injectable/injectable.dart';

import '../use_cases/playback_command_service.dart';
import '../repos/audio_player_repository.dart';

typedef PlayerPlayingListener = void Function({required bool playing});
typedef PlayerCompletedListener = void Function({required bool completed});

@lazySingleton
class PlayerPlaybackStreams {
  const PlayerPlaybackStreams(this._audio, this._commands);

  final AudioPlayerRepository _audio;
  final PlaybackCommandService _commands;

  List<StreamSubscription<Object?>> listen(
    ({
      void Function(PlaybackBookRequest request) onPlayBookRequested,
      void Function(Duration position) onPosition,
      void Function(Duration position) onBufferedPosition,
      void Function(Duration? duration) onDuration,
      PlayerPlayingListener onPlaying,
      PlayerCompletedListener onCompleted,
    })
    listeners,
  ) {
    return [
      _commands.playRequests.listen(listeners.onPlayBookRequested),
      _audio.positionStream.listen(listeners.onPosition),
      _audio.bufferedPositionStream.listen(listeners.onBufferedPosition),
      _audio.durationStream.listen(listeners.onDuration),

      _audio.playingStream.listen(
        (playing) => listeners.onPlaying(playing: playing),
      ),
      _audio.completedStream.listen(
        (completed) => listeners.onCompleted(completed: completed),
      ),
    ];
  }
}
