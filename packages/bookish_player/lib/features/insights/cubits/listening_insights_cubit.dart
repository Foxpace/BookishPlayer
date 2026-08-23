import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/foundation/result.dart';
import '../../../core/presentation/app_message.dart';
import '../use_cases/load_listening_insights_use_case.dart';
import '../models/insights_period.dart';
import 'listening_insights_state.dart';
import 'listening_insights_status.dart';

@injectable
class ListeningInsightsCubit extends Cubit<ListeningInsightsState> {
  ListeningInsightsCubit(this._loadListeningInsights)
    : super(const ListeningInsightsState());

  final LoadListeningInsightsUseCase _loadListeningInsights;

  Future<void> load() async {
    emit(
      state.copyWith(status: ListeningInsightsStatus.loading, message: null),
    );
    await _loadInsightsAndEmit();
  }

  Future<void> _loadInsightsAndEmit() async {
    switch (await _loadListeningInsights()) {
      case ResultSuccess(:final value):
        emit(
          state.copyWith(
            status: ListeningInsightsStatus.ready,
            activityByPeriod: value.activityByPeriod,
            totalListening: value.totalListening,
            completedBooks: value.completedBooks,
            activeDays: value.activeDays,
            streakDays: value.streakDays,
          ),
        );
      case ResultFailure():
        _emitInsightsLoadFailure();
    }
  }

  void _emitInsightsLoadFailure() {
    emit(
      state.copyWith(
        status: ListeningInsightsStatus.failure,
        message: AppMessage.listeningInsightsLoadFailed,
        effectRevision: state.effectRevision + 1,
      ),
    );
  }

  void selectPeriod(InsightsPeriod period) {
    emit(state.copyWith(selectedPeriod: period));
  }
}
