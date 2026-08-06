class PlaybackResumePolicy {
  PlaybackResumePolicy({DateTime Function()? now}) : _now = now ?? DateTime.now;

  final DateTime Function() _now;
  DateTime? _pausedAt;
  var _wasPlaying = false;

  ({bool shouldSave, Duration rewind}) update({
    required bool playing,
    required Duration position,
    required Duration chapterStart,
  }) {
    var shouldSave = false;
    var rewind = Duration.zero;
    if (!playing && _wasPlaying) {
      _pausedAt = _now();
      shouldSave = true;
    } else if (playing && !_wasPlaying && _pausedAt != null) {
      final pausedFor = _now().difference(_pausedAt!);
      rewind = pausedFor >= const Duration(minutes: 10)
          ? const Duration(seconds: 20)
          : pausedFor >= const Duration(minutes: 2)
          ? const Duration(seconds: 10)
          : Duration.zero;
      final chapterPosition = position - chapterStart;
      if (rewind > chapterPosition) {
        rewind = chapterPosition > Duration.zero
            ? chapterPosition
            : Duration.zero;
      }
      _pausedAt = null;
    }
    _wasPlaying = playing;
    return (shouldSave: shouldSave, rewind: rewind);
  }
}
