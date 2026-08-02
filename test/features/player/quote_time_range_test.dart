import 'package:bookish_player/features/player/domain/quote_time_range.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('QuoteTimeRange', () {
    test('starts with the last 30 seconds before the chapter anchor', () {
      final range = QuoteTimeRange.initial(
        chapterDuration: const Duration(minutes: 20),
        anchor: const Duration(minutes: 12),
      );

      expect(range.start, const Duration(minutes: 11, seconds: 30));
      expect(range.end, const Duration(minutes: 12));
    });

    test('presets change only the start and keep the endpoint stable', () {
      final initial = QuoteTimeRange.initial(
        chapterDuration: const Duration(hours: 2),
        anchor: const Duration(minutes: 70),
      );

      for (final seconds in [15, 30, 60, 120]) {
        final range = initial.withPreset(Duration(seconds: seconds));
        expect(range.end, initial.end);
        expect(range.lengthMs, seconds * 1000);
      }
    });

    test('preset clamps at the beginning without moving the endpoint', () {
      final initial = QuoteTimeRange.initial(
        chapterDuration: const Duration(minutes: 30),
        anchor: const Duration(seconds: 20),
      );
      final range = initial.withPreset(const Duration(minutes: 2));

      expect(range.start, Duration.zero);
      expect(range.end, const Duration(seconds: 20));
    });

    test('start and end controls cannot cross or leave the chapter', () {
      final initial = QuoteTimeRange.initial(
        chapterDuration: const Duration(minutes: 10),
        anchor: const Duration(minutes: 5),
      );

      final startPastEnd = initial.withStart(const Duration(minutes: 8));
      expect(startPastEnd.start, const Duration(minutes: 4, seconds: 59));
      expect(startPastEnd.end, const Duration(minutes: 5));

      final endBeforeStart = initial.withEnd(Duration.zero);
      expect(endBeforeStart.start, initial.start);
      expect(endBeforeStart.lengthMs, 1000);

      expect(
        initial.withEnd(const Duration(hours: 1)).end,
        const Duration(minutes: 10),
      );
    });

    test('manual boundaries preserve exact millisecond precision', () {
      final initial = QuoteTimeRange.initial(
        chapterDuration: const Duration(minutes: 10),
        anchor: const Duration(minutes: 5),
      );
      final precise = initial
          .withStart(const Duration(minutes: 4, milliseconds: 123))
          .withEnd(const Duration(minutes: 5, milliseconds: 789));

      expect(precise.startMs, 240123);
      expect(precise.endMs, 300789);
    });

    test('shifting preserves duration and clamps at both boundaries', () {
      final initial = QuoteTimeRange.initial(
        chapterDuration: const Duration(minutes: 2),
        anchor: const Duration(seconds: 90),
      ).withPreset(const Duration(seconds: 60));

      final earlier = initial.shift(const Duration(minutes: -5));
      expect(earlier.start, Duration.zero);
      expect(earlier.end, const Duration(seconds: 60));
      expect(earlier.lengthMs, initial.lengthMs);

      final later = initial.shift(const Duration(minutes: 5));
      expect(later.start, const Duration(seconds: 60));
      expect(later.end, const Duration(minutes: 2));
      expect(later.lengthMs, initial.lengthMs);
    });

    test('very short chapters still produce a valid full range', () {
      final range = QuoteTimeRange.initial(
        chapterDuration: const Duration(milliseconds: 400),
        anchor: const Duration(seconds: 3),
      );

      expect(range.start, Duration.zero);
      expect(range.end, const Duration(milliseconds: 400));
      expect(range.minimumLengthMs, 400);
    });
  });
}
