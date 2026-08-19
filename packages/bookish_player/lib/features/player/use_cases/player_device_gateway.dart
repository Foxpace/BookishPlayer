import 'dart:async';

import 'package:injectable/injectable.dart';

import '../repos/audio_output_picker.dart';
import '../repos/audio_player_repository.dart';
import 'playback_command_service.dart';
import 'player_application_events.dart';

@lazySingleton
class PlayerDeviceGateway {
  const PlayerDeviceGateway(this._audio, this._commands, this._output);

  final AudioPlayerRepository _audio;
  final PlaybackCommandService _commands;
  final AudioOutputPicker _output;

  List<StreamSubscription<Object?>> listen(PlayerApplicationEvents events) => [
    _commands.playRequests.listen(events.playBookRequested),
    _audio.positionStream.listen(events.positionChanged),
    _audio.bufferedPositionStream.listen(events.bufferedPositionChanged),
    _audio.durationStream.listen(events.durationChanged),
    _audio.playingStream.listen(
      (playing) => events.playingChanged(playing: playing),
    ),
    _audio.completedStream.listen(
      (completed) => events.completedChanged(completed: completed),
    ),
  ];

  Future<void> showAudioOutputPicker() => _output.showAudioOutputPicker();
}
