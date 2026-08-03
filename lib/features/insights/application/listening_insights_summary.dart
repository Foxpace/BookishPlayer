import 'package:freezed_annotation/freezed_annotation.dart';

import '../../library/domain/audiobook.dart';
import '../../library/domain/listening_session.dart';

part 'listening_insights_summary.freezed.dart';

@freezed
abstract class ListeningInsightsSummary with _$ListeningInsightsSummary {
  const factory ListeningInsightsSummary({
    required List<Audiobook> books,
    required List<ListeningSession> sessions,
    required Duration totalListening,
    required Duration lastSevenDays,
    required int completedBooks,
    required int activeDays,
  }) = _ListeningInsightsSummary;
}
