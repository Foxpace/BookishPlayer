import '../../library/models/library_models.dart';
import 'player_cubits.dart';
import 'player_duration_clamp.dart';

typedef _ChapterWindow = ({Duration start, Duration duration});

extension PlayerStateTimeline on PlayerState {
  Duration chapterSeekDistance(Duration relativePosition) =>
      chapterStart + relativePosition - position;

  bool requiresSeekConfirmation(Duration distance) =>
      distance.abs() >= Duration(minutes: playback.largeSeekMinutes);

  PlayerState projectTimeline() {
    final currentBook = book;
    if (currentBook == null) {
      return this;
    }

    final total = duration > Duration.zero
        ? duration
        : Duration(milliseconds: currentBook.durationMs);
    final orderedChapters = [...currentBook.chapters]
      ..sort((left, right) => left.startMs.compareTo(right.startMs));

    if (orderedChapters.isEmpty) {
      return _withoutChapters(total);
    }
    return _withChapters(orderedChapters, total);
  }

  PlayerState _withoutChapters(Duration total) => copyWith(
    currentChapter: null,
    currentChapterIndex: 0,
    chapterCount: 0,
    chapterStart: Duration.zero,
    chapterPosition: position.clampedTo(total),
    chapterBufferedPosition: bufferedPosition.clampedTo(total),
    chapterDuration: total,
    chapterTimeline: const [],
  );

  PlayerState _withChapters(List<AudioChapter> chapters, Duration total) {
    final timeline = _buildTimeline(chapters, total);
    final index = _findChapterIndex(chapters);
    final window = _chapterWindow(chapters, index, total);

    return copyWith(
      currentChapter: chapters[index],
      currentChapterIndex: index,
      chapterCount: chapters.length,
      chapterStart: window.start,
      chapterPosition: (position - window.start).clampedTo(window.duration),
      chapterBufferedPosition: (bufferedPosition - window.start).clampedTo(
        window.duration,
      ),
      chapterDuration: window.duration,
      chapterTimeline: timeline,
    );
  }

  _ChapterWindow _chapterWindow(
    List<AudioChapter> chapters,
    int index,
    Duration total,
  ) {
    final totalMs = total.inMilliseconds;
    final declaredStartMs = chapters[index].startMs.clamp(0, totalMs).toInt();
    final positionMs = position.inMilliseconds;
    final startMs = index == 0 && positionMs < declaredStartMs
        ? 0
        : declaredStartMs;
    final nextStartMs = index + 1 < chapters.length
        ? chapters[index + 1].startMs.clamp(startMs, totalMs).toInt()
        : totalMs;

    return (
      start: Duration(milliseconds: startMs),
      duration: Duration(milliseconds: nextStartMs - startMs),
    );
  }

  List<PlayerChapter> _buildTimeline(
    List<AudioChapter> chapters,
    Duration total,
  ) => [
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

  int _findChapterIndex(List<AudioChapter> chapters) {
    var index = 0;
    for (var candidate = 1; candidate < chapters.length; candidate++) {
      if (chapters[candidate].startMs > position.inMilliseconds) {
        break;
      }
      index = candidate;
    }
    return index;
  }
}
