import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../application/load_listening_insights.dart';
import '../../library/domain/audiobook_catalog_repository.dart';
import '../../library/domain/listening_history_repository.dart';
import 'listening_insights_state.dart';

@injectable
class ListeningInsightsCubit extends Cubit<ListeningInsightsState> {
  ListeningInsightsCubit(
    AudiobookCatalogRepository books,
    ListeningHistoryRepository history,
  ) : _loader = LoadListeningInsights(books, history),
      super(const ListeningInsightsState());

  final LoadListeningInsights _loader;

  Future<void> load() async {
    emit(const ListeningInsightsState());
    try {
      final result = await _loader.run();
      emit(
        ListeningInsightsState(
          status: ListeningInsightsStatus.ready,
          books: result.books,
          sessions: result.sessions,
          totalListening: result.totalListening,
          lastSevenDays: result.lastSevenDays,
          completedBooks: result.completedBooks,
          activeDays: result.activeDays,
        ),
      );
    } catch (_) {
      emit(
        const ListeningInsightsState(
          status: ListeningInsightsStatus.failure,
          message: 'Listening insights could not be loaded.',
        ),
      );
    }
  }
}
