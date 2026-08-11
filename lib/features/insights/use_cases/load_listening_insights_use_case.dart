import 'package:injectable/injectable.dart';

import '../../../core/foundation/clock.dart';
import '../repos/listening_insights_repository.dart';
import '../models/insights_models.dart';
import '../models/listening_insights_summary.dart';

@injectable
class LoadListeningInsightsUseCase {
  LoadListeningInsightsUseCase(this._repository, this._clock);

  final ListeningInsightsRepository _repository;
  final Clock _clock;

  Future<ListeningInsightsSummary> call() async {
    final (metadata, sessions) = await (
      _repository.loadMetadata(),
      _repository.loadSessions(),
    ).wait;
    final now = _clock.now();
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
