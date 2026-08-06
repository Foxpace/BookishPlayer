import 'package:freezed_annotation/freezed_annotation.dart';

import 'listening_activity.dart';

part 'listening_insights_summary.freezed.dart';

@freezed
abstract class ListeningInsightsSummary with _$ListeningInsightsSummary {
  const factory ListeningInsightsSummary({
    required Map<InsightsPeriod, ListeningActivityRange> activityByPeriod,
    required Duration totalListening,
    required int completedBooks,
    required int activeDays,
  }) = _ListeningInsightsSummary;
}
