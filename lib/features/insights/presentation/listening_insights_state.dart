import 'package:freezed_annotation/freezed_annotation.dart';

import '../application/listening_activity.dart';

part 'listening_insights_state.freezed.dart';

enum ListeningInsightsStatus { loading, ready, failure }

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
    String? message,
  }) = _ListeningInsightsState;
}
