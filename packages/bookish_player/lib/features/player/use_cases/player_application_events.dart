import 'playback_command_service.dart';

typedef PlayerApplicationEvents = ({
  void Function(PlaybackBookRequest request) playBookRequested,
  void Function(Duration position) positionChanged,
  void Function(Duration position) bufferedPositionChanged,
  void Function(Duration? duration) durationChanged,
  void Function({required bool playing}) playingChanged,
  void Function({required bool completed}) completedChanged,
});
