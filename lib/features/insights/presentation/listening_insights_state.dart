import 'package:freezed_annotation/freezed_annotation.dart';

import '../../library/domain/audiobook.dart';
import '../../library/domain/listening_session.dart';

part 'listening_insights_state.freezed.dart';

enum ListeningInsightsStatus { loading, ready, failure }

@freezed
abstract class ListeningInsightsState with _$ListeningInsightsState {
  const factory ListeningInsightsState({
    @Default(ListeningInsightsStatus.loading) ListeningInsightsStatus status,
    @Default(<Audiobook>[]) List<Audiobook> books,
    @Default(<ListeningSession>[]) List<ListeningSession> sessions,
    @Default(Duration.zero) Duration totalListening,
    @Default(Duration.zero) Duration lastSevenDays,
    @Default(0) int completedBooks,
    @Default(0) int activeDays,
    String? message,
  }) = _ListeningInsightsState;
}
