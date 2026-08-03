class PlaybackResumePolicy {
  DateTime? _pausedAt;
  var _wasPlaying = false;

  ({bool shouldSave, Duration rewind}) update({required bool playing}) {
    var shouldSave = false;
    var rewind = Duration.zero;
    if (!playing && _wasPlaying) {
      _pausedAt = DateTime.now();
      shouldSave = true;
    } else if (playing && !_wasPlaying && _pausedAt != null) {
      final pausedFor = DateTime.now().difference(_pausedAt!);
      rewind = pausedFor >= const Duration(minutes: 10)
          ? const Duration(seconds: 20)
          : pausedFor >= const Duration(minutes: 2)
          ? const Duration(seconds: 10)
          : Duration.zero;
      _pausedAt = null;
    }
    _wasPlaying = playing;
    return (shouldSave: shouldSave, rewind: rewind);
  }
}
