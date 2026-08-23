import 'package:bookish_player/features/insights/models/insights_period.dart';
import 'package:bookish_player/features/insights/models/listening_activity.dart';
import 'package:bookish_player/features/library/models/listening_session.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Daily listening activity', () {
    test(
      'Given the daily listening activity, When its behavior is exercised, Then aggregates sessions into bounded week, month, and year digests',
      () {
        // GIVEN
        final now = DateTime(2026, 8, 6, 18);
        final activity = aggregateListeningActivity([
          _session('today-1', DateTime(2026, 8, 6, 8), 10),
          _session('today-2', DateTime(2026, 8, 6, 12), 20),
          _session('yesterday', DateTime(2026, 8, 5, 9), 15),
          _session('too-old', DateTime(2026, 7, 30, 9), 60),
        ], now: now);

        final week = activity[InsightsPeriod.week];
        // WHEN
        if (week == null) {
          fail('Weekly activity must be present.');
        }
        // THEN
        expect(week.buckets, hasLength(7));
        expect(week.totalListening, const Duration(minutes: 45));
        expect(week.buckets.first.startDate, DateTime(2026, 8, 6));
        expect(week.buckets.first.listening, const Duration(minutes: 30));
        expect(week.buckets[1].startDate, DateTime(2026, 8, 5));
        expect(week.buckets[1].listening, const Duration(minutes: 15));
        expect(week.buckets.last.startDate, DateTime(2026, 7, 31));
        expect(week.buckets.last.listening, Duration.zero);

        final month = activity[InsightsPeriod.month];
        if (month == null) {
          fail('Monthly activity must be present.');
        }
        expect(month.buckets, hasLength(5));
        expect(month.totalListening, const Duration(minutes: 105));
        expect(month.buckets.first.startDate, DateTime(2026, 7, 31));
        expect(month.buckets.last.endDate, DateTime(2026, 7, 9));

        final year = activity[InsightsPeriod.year];
        if (year == null) {
          fail('Yearly activity must be present.');
        }
        expect(year.buckets, hasLength(12));
        expect(year.totalListening, const Duration(minutes: 105));
      },
    );
  });

  group('Current listening streak', () {
    test(
      'Given listening on consecutive days including today, When the streak is calculated, Then each distinct day is counted once',
      () {
        // GIVEN
        final now = DateTime(2026, 8, 6, 18);
        final sessions = [
          _session('today-1', DateTime(2026, 8, 6, 8), 10),
          _session('today-2', DateTime(2026, 8, 6, 12), 20),
          _session('yesterday', DateTime(2026, 8, 5, 9), 15),
          _session('two-days-ago', DateTime(2026, 8, 4, 9), 10),
        ];

        // WHEN
        final streak = calculateCurrentListeningStreak(sessions, now: now);

        // THEN
        expect(streak, 3);
      },
    );

    test(
      'Given consecutive listening ending yesterday, When the streak is calculated, Then the current streak remains active',
      () {
        // GIVEN
        final now = DateTime(2026, 8, 6, 18);
        final sessions = [
          _session('yesterday', DateTime(2026, 8, 5, 9), 15),
          _session('two-days-ago', DateTime(2026, 8, 4, 9), 10),
        ];

        // WHEN
        final streak = calculateCurrentListeningStreak(sessions, now: now);

        // THEN
        expect(streak, 2);
      },
    );

    test(
      'Given listening stopped before yesterday, When the streak is calculated, Then the current streak is zero',
      () {
        // GIVEN
        final now = DateTime(2026, 8, 6, 18);
        final sessions = [
          _session('two-days-ago', DateTime(2026, 8, 4, 9), 10),
          _session('three-days-ago', DateTime(2026, 8, 3, 9), 10),
        ];

        // WHEN
        final streak = calculateCurrentListeningStreak(sessions, now: now);

        // THEN
        expect(streak, 0);
      },
    );
  });
}

ListeningSession _session(String id, DateTime startedAt, int minutes) {
  return ListeningSession(
    id: id,
    metadataId: 'metadata',
    startedAt: startedAt,
    endedAt: startedAt.add(Duration(minutes: minutes)),
    listenedMs: Duration(minutes: minutes).inMilliseconds,
    startPositionMs: 0,
    endPositionMs: Duration(minutes: minutes).inMilliseconds,
    speed: 1,
  );
}
