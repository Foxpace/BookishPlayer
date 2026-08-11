import 'package:injectable/injectable.dart';

import '../../library/models/library_models.dart';

@lazySingleton
class SeriesContinuationPolicy {
  const SeriesContinuationPolicy();

  Audiobook? selectNextBook(Audiobook current, List<Audiobook> books) {
    final series = books.where((book) => _isCandidate(book, current)).toList()
      ..sort(_compareSeriesOrder);

    if (series.isEmpty) {
      return null;
    }

    final currentPosition = current.seriesPosition;
    final later = series.where(
      (book) => _isLaterInSeries(book, currentPosition),
    );

    return later.isEmpty ? series.first : later.first;
  }

  bool _isCandidate(Audiobook book, Audiobook current) {
    return book.id != current.id &&
        book.series.trim().toLowerCase() ==
            current.series.trim().toLowerCase() &&
        book.isFinished == false;
  }

  int _compareSeriesOrder(Audiobook left, Audiobook right) {
    final byPosition = (left.seriesPosition ?? double.infinity).compareTo(
      right.seriesPosition ?? double.infinity,
    );
    return byPosition != 0 ? byPosition : left.addedAt.compareTo(right.addedAt);
  }

  bool _isLaterInSeries(Audiobook book, double? currentPosition) {
    final bookPosition = book.seriesPosition;
    return currentPosition == null ||
        bookPosition == null ||
        bookPosition > currentPosition;
  }
}
