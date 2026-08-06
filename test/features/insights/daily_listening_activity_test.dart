import 'package:bookish_player/features/insights/application/listening_activity.dart';
import 'package:bookish_player/features/library/domain/listening_session.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('aggregates sessions into bounded week, month, and year digests', () {
    final now = DateTime(2026, 8, 6, 18);
    final activity = aggregateListeningActivity([
      _session('today-1', DateTime(2026, 8, 6, 8), 10),
      _session('today-2', DateTime(2026, 8, 6, 12), 20),
      _session('yesterday', DateTime(2026, 8, 5, 9), 15),
      _session('too-old', DateTime(2026, 7, 30, 9), 60),
    ], now: now);

    final week = activity[InsightsPeriod.week]!;
    expect(week.buckets, hasLength(7));
    expect(week.totalListening, const Duration(minutes: 45));
    expect(week.buckets.first.startDate, DateTime(2026, 8, 6));
    expect(week.buckets.first.listening, const Duration(minutes: 30));
    expect(week.buckets[1].startDate, DateTime(2026, 8, 5));
    expect(week.buckets[1].listening, const Duration(minutes: 15));
    expect(week.buckets.last.startDate, DateTime(2026, 7, 31));
    expect(week.buckets.last.listening, Duration.zero);

    final month = activity[InsightsPeriod.month]!;
    expect(month.buckets, hasLength(5));
    expect(month.totalListening, const Duration(minutes: 105));
    expect(month.buckets.first.startDate, DateTime(2026, 7, 31));
    expect(month.buckets.last.endDate, DateTime(2026, 7, 9));

    final year = activity[InsightsPeriod.year]!;
    expect(year.buckets, hasLength(12));
    expect(year.totalListening, const Duration(minutes: 105));
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
