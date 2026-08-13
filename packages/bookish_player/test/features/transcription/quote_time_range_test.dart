import 'package:bookish_player/features/transcription/models/quote_time_range.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Quote time range', () {
    group('QuoteTimeRange', () {
      test(
        'Given the quote time range, When its behavior is exercised, Then starts with the last 30 seconds before the chapter anchor',
        () {
          // WHEN
          final range = QuoteTimeRange.initial(
            chapterDuration: const Duration(minutes: 20),
            anchor: const Duration(minutes: 12),
          );

          // THEN
          expect(range.start, const Duration(minutes: 11, seconds: 30));
          expect(range.end, const Duration(minutes: 12));
        },
      );

      test(
        'Given the quote time range, When its behavior is exercised, Then presets change only the start and keep the endpoint stable',
        () {
          // WHEN
          final initial = QuoteTimeRange.initial(
            chapterDuration: const Duration(hours: 2),
            anchor: const Duration(minutes: 70),
          );

          // THEN
          for (final seconds in [15, 30, 60, 120]) {
            final range = initial.withPreset(Duration(seconds: seconds));
            expect(range.end, initial.end);
            expect(range.lengthMs, seconds * 1000);
          }
        },
      );

      test(
        'Given the quote time range, When its behavior is exercised, Then preset clamps at the beginning without moving the endpoint',
        () {
          // GIVEN
          final initial = QuoteTimeRange.initial(
            chapterDuration: const Duration(minutes: 30),
            anchor: const Duration(seconds: 20),
          );
          // WHEN
          final range = initial.withPreset(const Duration(minutes: 2));

          // THEN
          expect(range.start, Duration.zero);
          expect(range.end, const Duration(seconds: 20));
        },
      );

      test(
        'Given the quote time range, When its behavior is exercised, Then start and end controls cannot cross or leave the chapter',
        () {
          // GIVEN
          final initial = QuoteTimeRange.initial(
            chapterDuration: const Duration(minutes: 10),
            anchor: const Duration(minutes: 5),
          );

          // WHEN
          final startPastEnd = initial.withStart(const Duration(minutes: 8));
          // THEN
          expect(startPastEnd.start, const Duration(minutes: 4, seconds: 59));
          expect(startPastEnd.end, const Duration(minutes: 5));

          final endBeforeStart = initial.withEnd(Duration.zero);
          expect(endBeforeStart.start, initial.start);
          expect(endBeforeStart.lengthMs, 1000);

          expect(
            initial.withEnd(const Duration(hours: 1)).end,
            const Duration(minutes: 10),
          );
        },
      );

      test(
        'Given the quote time range, When its behavior is exercised, Then manual boundaries preserve exact millisecond precision',
        () {
          // GIVEN
          final initial = QuoteTimeRange.initial(
            chapterDuration: const Duration(minutes: 10),
            anchor: const Duration(minutes: 5),
          );
          // WHEN
          final precise = initial
              .withStart(const Duration(minutes: 4, milliseconds: 123))
              .withEnd(const Duration(minutes: 5, milliseconds: 789));

          // THEN
          expect(precise.startMs, 240123);
          expect(precise.endMs, 300789);
        },
      );

      test(
        'Given the quote time range, When its behavior is exercised, Then shifting preserves duration and clamps at both boundaries',
        () {
          // GIVEN
          final initial = QuoteTimeRange.initial(
            chapterDuration: const Duration(minutes: 2),
            anchor: const Duration(seconds: 90),
          ).withPreset(const Duration(seconds: 60));

          // WHEN
          final earlier = initial.shift(const Duration(minutes: -5));
          // THEN
          expect(earlier.start, Duration.zero);
          expect(earlier.end, const Duration(seconds: 60));
          expect(earlier.lengthMs, initial.lengthMs);

          final later = initial.shift(const Duration(minutes: 5));
          expect(later.start, const Duration(seconds: 60));
          expect(later.end, const Duration(minutes: 2));
          expect(later.lengthMs, initial.lengthMs);
        },
      );

      test(
        'Given the quote time range, When its behavior is exercised, Then very short chapters still produce a valid full range',
        () {
          // WHEN
          final range = QuoteTimeRange.initial(
            chapterDuration: const Duration(milliseconds: 400),
            anchor: const Duration(seconds: 3),
          );

          // THEN
          expect(range.start, Duration.zero);
          expect(range.end, const Duration(milliseconds: 400));
          expect(range.minimumLengthMs, 400);
        },
      );
    });
  });
}
