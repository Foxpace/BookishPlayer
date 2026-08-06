import '../../library/domain/listening_history_repository.dart';
import '../../library/domain/book_metadata_repository.dart';
import 'listening_activity.dart';
import 'listening_insights_summary.dart';

class LoadListeningInsights {
  LoadListeningInsights(this._metadata, this._history);

  final BookMetadataRepository _metadata;
  final ListeningHistoryRepository _history;

  Future<ListeningInsightsSummary> run() async {
    final metadata = await _metadata.getBookMetadata();
    final sessions = await _history.getListeningSessions();
    final now = DateTime.now();
    final totalMs = sessions.fold<int>(0, (sum, item) => sum + item.listenedMs);
    final activityByPeriod = aggregateListeningActivity(sessions, now: now);
    final activeDates = sessions
        .map((item) => item.startedAt.toLocal())
        .map((date) => DateTime(date.year, date.month, date.day))
        .toSet();
    return ListeningInsightsSummary(
      activityByPeriod: activityByPeriod,
      totalListening: Duration(milliseconds: totalMs),
      completedBooks: metadata.where((item) => item.completedAt != null).length,
      activeDays: activeDates.length,
    );
  }
}
