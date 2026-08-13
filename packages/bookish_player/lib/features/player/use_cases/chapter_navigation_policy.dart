import 'package:injectable/injectable.dart';

import '../../library/models/library_models.dart';

@lazySingleton
class ChapterNavigationPolicy {
  const ChapterNavigationPolicy();

  Duration selectPreviousChapter({
    required Audiobook book,
    required int index,
    required Duration chapterPosition,
    required Duration chapterStart,
  }) {
    if (chapterPosition > const Duration(seconds: 3)) {
      return chapterStart;
    }
    final chapters = _orderChapters(book);
    final previous = (index - 1).clamp(0, chapters.length - 1).toInt();
    return Duration(milliseconds: chapters[previous].startMs);
  }

  Duration selectNextChapter(Audiobook book, int index) {
    final chapters = _orderChapters(book);
    final next = index + 1;
    return next >= chapters.length
        ? Duration(milliseconds: book.durationMs)
        : Duration(milliseconds: chapters[next].startMs);
  }

  List<AudioChapter> _orderChapters(Audiobook book) =>
      [...book.chapters]
        ..sort((left, right) => left.startMs.compareTo(right.startMs));
}
