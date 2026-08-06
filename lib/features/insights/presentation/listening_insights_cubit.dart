import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/presentation/diagnostic_failure.dart';
import '../application/load_listening_insights.dart';
import '../application/listening_activity.dart';
import '../../library/domain/listening_history_repository.dart';
import '../../library/domain/book_metadata_repository.dart';
import 'listening_insights_state.dart';

@injectable
class ListeningInsightsCubit extends Cubit<ListeningInsightsState> {
  ListeningInsightsCubit(
    BookMetadataRepository metadata,
    ListeningHistoryRepository history,
  ) : _loader = LoadListeningInsights(metadata, history),
      super(const ListeningInsightsState());

  final LoadListeningInsights _loader;

  Future<void> load() async {
    emit(const ListeningInsightsState());
    try {
      final result = await _loader.run();
      emit(
        ListeningInsightsState(
          status: ListeningInsightsStatus.ready,
          activityByPeriod: result.activityByPeriod,
          totalListening: result.totalListening,
          completedBooks: result.completedBooks,
          activeDays: result.activeDays,
        ),
      );
    } catch (error) {
      emit(
        ListeningInsightsState(
          status: ListeningInsightsStatus.failure,
          message: diagnosticFailureMessage(
            'Listening insights could not be loaded.',
            error,
          ),
        ),
      );
    }
  }

  void selectPeriod(InsightsPeriod period) {
    emit(state.copyWith(selectedPeriod: period));
  }
}
