import 'package:bookish_player/features/player/presentation/playback_resume_policy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('smart resume does not rewind into the previous chapter', () {
    var now = DateTime(2026);
    final policy = PlaybackResumePolicy(now: () => now);

    policy.update(
      playing: true,
      position: const Duration(minutes: 1),
      chapterStart: const Duration(minutes: 1),
    );
    policy.update(
      playing: false,
      position: const Duration(minutes: 1),
      chapterStart: const Duration(minutes: 1),
    );
    now = now.add(const Duration(minutes: 10));

    final action = policy.update(
      playing: true,
      position: const Duration(minutes: 1),
      chapterStart: const Duration(minutes: 1),
    );

    expect(action.rewind, Duration.zero);
  });

  test('smart resume is limited to elapsed time in the current chapter', () {
    var now = DateTime(2026);
    final policy = PlaybackResumePolicy(now: () => now);

    policy.update(
      playing: true,
      position: const Duration(seconds: 65),
      chapterStart: const Duration(minutes: 1),
    );
    policy.update(
      playing: false,
      position: const Duration(seconds: 65),
      chapterStart: const Duration(minutes: 1),
    );
    now = now.add(const Duration(minutes: 10));

    final action = policy.update(
      playing: true,
      position: const Duration(seconds: 65),
      chapterStart: const Duration(minutes: 1),
    );

    expect(action.rewind, const Duration(seconds: 5));
  });
}
