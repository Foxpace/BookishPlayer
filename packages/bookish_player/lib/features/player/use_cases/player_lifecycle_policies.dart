import 'package:injectable/injectable.dart';

import '../../../core/foundation/clock.dart';
import '../../library/models/library_models.dart';
import 'listening_session_tracker.dart';
import 'playback_resume_policy.dart';
import 'series_continuation_policy.dart';

@lazySingleton
class PlayerLifecyclePolicies {
  const PlayerLifecyclePolicies(
    this._clock,
    this._sessions,
    this._resume,
    this._series,
  );

  final Clock _clock;
  final ListeningSessionTracker _sessions;
  final PlaybackResumePolicy _resume;
  final SeriesContinuationPolicy _series;

  DateTime now() => _clock.now();

  ({DateTime startedAt, Duration startPosition}) startSession(
    Duration position,
  ) => _sessions.start(position);

  Future<void> finishSession({
    required DateTime? startedAt,
    required Duration? startPosition,
    required Audiobook? book,
    required Duration position,
    required double speed,
  }) => _sessions.finish(
    startedAt: startedAt,
    startPosition: startPosition,
    book: book,
    position: position,
    speed: speed,
  );

  PlaybackResumeDecision evaluateResume({
    required bool playing,
    required bool wasPlaying,
    required DateTime? pausedAt,
    required Duration position,
    required Duration chapterStart,
  }) => _resume.evaluate(
    playing: playing,
    wasPlaying: wasPlaying,
    pausedAt: pausedAt,
    position: position,
    chapterStart: chapterStart,
  );

  Audiobook? selectNext(Audiobook finished, List<Audiobook> books) =>
      _series.selectNextBook(finished, books);
}
