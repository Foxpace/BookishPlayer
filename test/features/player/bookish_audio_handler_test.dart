import 'package:bookish_player/features/player/repos/implementations/bookish_audio_handler.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Bookish audio handler', () {
    test(
      'Given the bookish audio handler, When its behavior is exercised, Then moves forward by 15 seconds across a chapter boundary',
      () {
        // WHEN
        final target = relativeSeekTarget(
          durations: const [Duration(seconds: 20), Duration(seconds: 30)],
          currentIndex: 0,
          currentPosition: const Duration(seconds: 12),
          delta: BookishAudioHandler.skipInterval,
        );

        // THEN
        expect(target.index, 1);
        expect(target.position, const Duration(seconds: 7));
      },
    );

    test(
      'Given the bookish audio handler, When its behavior is exercised, Then moves backward by 15 seconds across a chapter boundary',
      () {
        // WHEN
        final target = relativeSeekTarget(
          durations: const [Duration(seconds: 20), Duration(seconds: 30)],
          currentIndex: 1,
          currentPosition: const Duration(seconds: 4),
          delta: -BookishAudioHandler.skipInterval,
        );

        // THEN
        expect(target.index, 0);
        expect(target.position, const Duration(seconds: 9));
      },
    );

    test(
      'Given the bookish audio handler, When its behavior is exercised, Then clamps notification seeks at the beginning and end',
      () {
        // THEN
        expect(
          relativeSeekTarget(
            durations: const [Duration(seconds: 20)],
            currentIndex: 0,
            currentPosition: const Duration(seconds: 3),
            delta: -BookishAudioHandler.skipInterval,
          ).position,
          Duration.zero,
        );
        expect(
          relativeSeekTarget(
            durations: const [Duration(seconds: 20)],
            currentIndex: 0,
            currentPosition: const Duration(seconds: 18),
            delta: BookishAudioHandler.skipInterval,
          ).position,
          const Duration(seconds: 20),
        );
      },
    );
  });
}
