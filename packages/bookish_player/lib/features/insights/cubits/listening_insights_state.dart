import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/presentation/app_message.dart';
import '../models/insights_period.dart';
import '../models/listening_activity_range.dart';

import 'listening_insights_status.dart';
part 'listening_insights_state.freezed.dart';

@freezed
abstract class ListeningInsightsState with _$ListeningInsightsState {
  const factory ListeningInsightsState({
    @Default(ListeningInsightsStatus.loading) ListeningInsightsStatus status,
    @Default(<InsightsPeriod, ListeningActivityRange>{})
    Map<InsightsPeriod, ListeningActivityRange> activityByPeriod,
    @Default(InsightsPeriod.week) InsightsPeriod selectedPeriod,
    @Default(Duration.zero) Duration totalListening,
    @Default(0) int completedBooks,
    @Default(0) int activeDays,
    AppMessage? message,
    @Default(0) int effectRevision,
  }) = _ListeningInsightsState;
}
