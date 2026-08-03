import '../../library/domain/audiobook.dart';

class SeriesContinuationPolicy {
  const SeriesContinuationPolicy();

  Audiobook? next(Audiobook current, List<Audiobook> books) {
    final series =
        books
            .where(
              (book) =>
                  book.id != current.id &&
                  book.series.trim().toLowerCase() ==
                      current.series.trim().toLowerCase() &&
                  !book.isFinished,
            )
            .toList()
          ..sort((left, right) {
            final byPosition = (left.seriesPosition ?? double.infinity)
                .compareTo(right.seriesPosition ?? double.infinity);
            return byPosition != 0
                ? byPosition
                : left.addedAt.compareTo(right.addedAt);
          });
    if (series.isEmpty) {
      return null;
    }
    final later = series.where(
      (book) =>
          current.seriesPosition == null ||
          book.seriesPosition == null ||
          book.seriesPosition! > current.seriesPosition!,
    );
    return later.isEmpty ? series.first : later.first;
  }
}
