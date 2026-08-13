import 'package:injectable/injectable.dart';

import '../../../core/foundation/clock.dart';

typedef PlaybackResumeDecision = ({
  bool shouldSave,
  Duration rewind,
  DateTime? pausedAt,
  bool wasPlaying,
});

@lazySingleton
class PlaybackResumePolicy {
  const PlaybackResumePolicy(this._clock);

  final Clock _clock;

  PlaybackResumeDecision evaluate({
    required bool playing,
    required bool wasPlaying,
    required DateTime? pausedAt,
    required Duration position,
    required Duration chapterStart,
  }) {
    if (playing == false && wasPlaying) {
      return _pausedDecision();
    }

    if (playing && wasPlaying == false && pausedAt != null) {
      return _resumedDecision(pausedAt, position, chapterStart);
    }

    return (
      shouldSave: false,
      rewind: Duration.zero,
      pausedAt: pausedAt,
      wasPlaying: playing,
    );
  }

  PlaybackResumeDecision _pausedDecision() => (
    shouldSave: true,
    rewind: Duration.zero,
    pausedAt: _clock.now(),
    wasPlaying: false,
  );

  PlaybackResumeDecision _resumedDecision(
    DateTime pausedAt,
    Duration position,
    Duration chapterStart,
  ) {
    final pausedFor = _clock.now().difference(pausedAt);
    final rewind = _clampToChapter(
      _rewindForPause(pausedFor),
      position - chapterStart,
    );

    return (
      shouldSave: false,
      rewind: rewind,
      pausedAt: null,
      wasPlaying: true,
    );
  }

  Duration _rewindForPause(Duration pausedFor) {
    if (pausedFor >= const Duration(minutes: 10)) {
      return const Duration(seconds: 20);
    }
    if (pausedFor >= const Duration(minutes: 2)) {
      return const Duration(seconds: 10);
    }

    return Duration.zero;
  }

  Duration _clampToChapter(Duration rewind, Duration chapterPosition) {
    if (rewind <= chapterPosition) {
      return rewind;
    }

    return chapterPosition > Duration.zero ? chapterPosition : Duration.zero;
  }
}
