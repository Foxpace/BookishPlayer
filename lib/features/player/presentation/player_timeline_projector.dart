import '../../library/domain/audiobook.dart';
import 'player_state.dart';

class PlayerTimelineProjector {
  const PlayerTimelineProjector();

  PlayerState project(PlayerState value) {
    final book = value.book;
    if (book == null) {
      return value;
    }
    final total = value.duration > Duration.zero
        ? value.duration
        : Duration(milliseconds: book.durationMs);
    final chapters = _orderedChapters(book);
    if (chapters.isEmpty) {
      return value.copyWith(
        currentChapter: null,
        currentChapterIndex: 0,
        chapterCount: 0,
        chapterStart: Duration.zero,
        chapterPosition: bounded(value.position, total),
        chapterBufferedPosition: bounded(value.bufferedPosition, total),
        chapterDuration: total,
        chapterTimeline: const [],
      );
    }
    return _projectChapters(value, chapters, total);
  }

  PlayerState _projectChapters(
    PlayerState value,
    List<AudioChapter> chapters,
    Duration total,
  ) {
    final timeline = _timeline(chapters, total);
    final index = _chapterIndex(chapters, value.position);
    final totalMs = total.inMilliseconds;
    final declaredStartMs = chapters[index].startMs.clamp(0, totalMs).toInt();
    final positionMs = value.position.inMilliseconds;
    final startMs = index == 0 && positionMs < declaredStartMs
        ? 0
        : declaredStartMs;
    final nextStartMs = index + 1 < chapters.length
        ? chapters[index + 1].startMs.clamp(startMs, totalMs).toInt()
        : totalMs;
    final chapterStart = Duration(milliseconds: startMs);
    final chapterDuration = Duration(milliseconds: nextStartMs - startMs);
    return value.copyWith(
      currentChapter: chapters[index],
      currentChapterIndex: index,
      chapterCount: chapters.length,
      chapterStart: chapterStart,
      chapterPosition: bounded(value.position - chapterStart, chapterDuration),
      chapterBufferedPosition: bounded(
        value.bufferedPosition - chapterStart,
        chapterDuration,
      ),
      chapterDuration: chapterDuration,
      chapterTimeline: timeline,
    );
  }

  List<PlayerChapter> _timeline(List<AudioChapter> chapters, Duration total) =>
      [
        for (var index = 0; index < chapters.length; index++)
          _timelineChapter(chapters, index, total.inMilliseconds),
      ];

  PlayerChapter _timelineChapter(
    List<AudioChapter> chapters,
    int index,
    int totalMs,
  ) {
    final startMs = chapters[index].startMs.clamp(0, totalMs).toInt();
    final endMs = index + 1 < chapters.length
        ? chapters[index + 1].startMs.clamp(startMs, totalMs).toInt()
        : totalMs;
    return PlayerChapter(
      index: index,
      title: chapters[index].title,
      start: Duration(milliseconds: startMs),
      duration: Duration(milliseconds: endMs - startMs),
    );
  }

  int _chapterIndex(List<AudioChapter> chapters, Duration position) {
    var index = 0;
    for (var candidate = 1; candidate < chapters.length; candidate++) {
      if (chapters[candidate].startMs > position.inMilliseconds) {
        break;
      }
      index = candidate;
    }
    return index;
  }

  List<AudioChapter> _orderedChapters(Audiobook book) =>
      [...book.chapters]..sort((a, b) => a.startMs.compareTo(b.startMs));

  Duration bounded(Duration value, Duration maximum) {
    if (value < Duration.zero) {
      return Duration.zero;
    }
    if (maximum > Duration.zero && value > maximum) {
      return maximum;
    }
    return value;
  }
}
