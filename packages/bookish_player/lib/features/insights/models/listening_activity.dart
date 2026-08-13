import 'package:freezed_annotation/freezed_annotation.dart';

import '../../library/models/listening_session.dart';

import 'insights_period.dart';
import 'listening_activity_range.dart';
part 'listening_activity.freezed.dart';

@freezed
abstract class ListeningActivityBucket with _$ListeningActivityBucket {
  const factory ListeningActivityBucket({
    required DateTime startDate,
    required DateTime endDate,
    required Duration listening,
  }) = _ListeningActivityBucket;
}

Map<InsightsPeriod, ListeningActivityRange> aggregateListeningActivity(
  Iterable<ListeningSession> sessions, {
  required DateTime now,
}) {
  final localSessions = sessions
      .map(
        (session) => (
          date: _dateOnly(session.startedAt.toLocal()),
          listenedMs: session.listenedMs,
        ),
      )
      .toList(growable: false);
  final today = _dateOnly(now.toLocal());
  final bounds = <InsightsPeriod, List<(DateTime, DateTime)>>{
    InsightsPeriod.week: _rollingDayBounds(today, days: 7, bucketDays: 1),
    InsightsPeriod.month: _rollingDayBounds(today, days: 30, bucketDays: 7),
    InsightsPeriod.year: _monthlyBounds(today, months: 12),
  };

  return {
    for (final entry in bounds.entries)
      entry.key: _aggregateRange(localSessions, entry.value),
  };
}

ListeningActivityRange _aggregateRange(
  List<({DateTime date, int listenedMs})> sessions,
  List<(DateTime, DateTime)> bounds,
) {
  final buckets = [
    for (final (startDate, endDate) in bounds)
      ListeningActivityBucket(
        startDate: startDate,
        endDate: endDate,
        listening: _listeningBetween(sessions, startDate, endDate),
      ),
  ];

  return ListeningActivityRange(
    totalListening: buckets.fold(
      Duration.zero,
      (total, bucket) => total + bucket.listening,
    ),
    buckets: buckets,
  );
}

Duration _listeningBetween(
  List<({DateTime date, int listenedMs})> sessions,
  DateTime startDate,
  DateTime endDate,
) {
  final milliseconds = sessions
      .where(
        (session) =>
            session.date.isBefore(startDate) == false &&
            session.date.isAfter(endDate) == false,
      )
      .fold(0, (sum, session) => sum + session.listenedMs);

  return Duration(milliseconds: milliseconds);
}

List<(DateTime, DateTime)> _rollingDayBounds(
  DateTime today, {
  required int days,
  required int bucketDays,
}) {
  final firstDay = today.subtract(Duration(days: days - 1));
  final result = <(DateTime, DateTime)>[];
  var endDate = today;

  while (endDate.isBefore(firstDay) == false) {
    final proposedStart = endDate.subtract(Duration(days: bucketDays - 1));
    final startDate = proposedStart.isBefore(firstDay)
        ? firstDay
        : proposedStart;
    result.add((startDate, endDate));
    endDate = startDate.subtract(const Duration(days: 1));
  }

  return result;
}

List<(DateTime, DateTime)> _monthlyBounds(
  DateTime today, {
  required int months,
}) {
  return [
    for (var offset = 0; offset < months; offset++)
      (
        DateTime(today.year, today.month - offset),
        offset == 0 ? today : DateTime(today.year, today.month - offset + 1, 0),
      ),
  ];
}

DateTime _dateOnly(DateTime date) => DateTime(date.year, date.month, date.day);
