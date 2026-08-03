import '../../library/domain/audiobook_catalog_repository.dart';
import '../../library/domain/audiobook.dart';
import '../../library/domain/listening_history_repository.dart';
import 'listening_insights_summary.dart';

class LoadListeningInsights {
  LoadListeningInsights(this._books, this._history);

  final AudiobookCatalogRepository _books;
  final ListeningHistoryRepository _history;

  Future<ListeningInsightsSummary> run() async {
    final books = await _books.getBooks();
    final sessions = await _history.getListeningSessions();
    final weekStart = DateTime.now().subtract(const Duration(days: 7));
    final totalMs = sessions.fold<int>(0, (sum, item) => sum + item.listenedMs);
    final weekMs = sessions
        .where((item) => item.startedAt.isAfter(weekStart))
        .fold<int>(0, (sum, item) => sum + item.listenedMs);
    final activeDates = sessions
        .map(
          (item) => DateTime(
            item.startedAt.year,
            item.startedAt.month,
            item.startedAt.day,
          ),
        )
        .toSet();
    return ListeningInsightsSummary(
      books: books,
      sessions: sessions,
      totalListening: Duration(milliseconds: totalMs),
      lastSevenDays: Duration(milliseconds: weekMs),
      completedBooks: books.where((book) => book.isFinished).length,
      activeDays: activeDates.length,
    );
  }
}
