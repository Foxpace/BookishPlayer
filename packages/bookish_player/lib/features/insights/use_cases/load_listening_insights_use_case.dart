import 'package:injectable/injectable.dart';

import '../../../core/foundation/clock.dart';
import '../../../core/foundation/result.dart';
import '../models/listening_insights_failure.dart';
import '../repos/listening_insights_repository.dart';
import '../models/listening_activity.dart';
import '../models/listening_insights_summary.dart';

@injectable
class LoadListeningInsightsUseCase {
  LoadListeningInsightsUseCase(this._repository, this._clock);

  final ListeningInsightsRepository _repository;
  final Clock _clock;

  Future<Result<ListeningInsightsSummary, ListeningInsightsFailure>>
  call() async {
    try {
      return await _loadResult();
    } catch (_) {
      return const Result.failure(ListeningInsightsFailure.load);
    }
  }

  Future<Result<ListeningInsightsSummary, ListeningInsightsFailure>>
  _loadResult() async => Result.success(await _loadSummary());

  Future<ListeningInsightsSummary> _loadSummary() async {
    final (metadata, sessions) = await (
      _repository.loadMetadata(),
      _repository.loadSessions(),
    ).wait;
    final totalMs = sessions.fold<int>(0, (sum, item) => sum + item.listenedMs);
    final activeDates = sessions
        .map((item) => item.startedAt.toLocal())
        .map((date) => DateTime(date.year, date.month, date.day))
        .toSet();
    return ListeningInsightsSummary(
      activityByPeriod: aggregateListeningActivity(sessions, now: _clock.now()),
      totalListening: Duration(milliseconds: totalMs),
      completedBooks: metadata.where((item) => item.completedAt != null).length,
      activeDays: activeDates.length,
    );
  }
}
