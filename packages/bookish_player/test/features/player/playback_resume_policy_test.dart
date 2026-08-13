import 'package:bookish_player/features/player/use_cases/playback_resume_policy.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/fakes/fake_clock.dart';

void main() {
  group('Playback resume policy', () {
    late FakeClock clock;
    late PlaybackResumePolicy sut;

    setUp(() {
      clock = FakeClock(DateTime(2026));
      sut = PlaybackResumePolicy(clock);
    });

    PlaybackResumeDecision pauseAt(Duration position) {
      final playing = sut.evaluate(
        playing: true,
        wasPlaying: false,
        pausedAt: null,
        position: position,
        chapterStart: const Duration(minutes: 1),
      );
      return sut.evaluate(
        playing: false,
        wasPlaying: playing.wasPlaying,
        pausedAt: playing.pausedAt,
        position: position,
        chapterStart: const Duration(minutes: 1),
      );
    }

    test(
      'Given the playback resume policy, When its behavior is exercised, Then smart resume does not rewind into the previous chapter',
      () {
        // GIVEN
        final paused = pauseAt(const Duration(minutes: 1));
        clock.advance(const Duration(minutes: 10));

        // WHEN
        final action = sut.evaluate(
          playing: true,
          wasPlaying: paused.wasPlaying,
          pausedAt: paused.pausedAt,
          position: const Duration(minutes: 1),
          chapterStart: const Duration(minutes: 1),
        );

        // THEN
        expect(action.rewind, Duration.zero);
      },
    );

    test(
      'Given the playback resume policy, When its behavior is exercised, Then smart resume is limited to elapsed time in the current chapter',
      () {
        // GIVEN
        final paused = pauseAt(const Duration(seconds: 65));
        clock.advance(const Duration(minutes: 10));

        // WHEN
        final action = sut.evaluate(
          playing: true,
          wasPlaying: paused.wasPlaying,
          pausedAt: paused.pausedAt,
          position: const Duration(seconds: 65),
          chapterStart: const Duration(minutes: 1),
        );

        // THEN
        expect(action.rewind, const Duration(seconds: 5));
      },
    );
  });
}
