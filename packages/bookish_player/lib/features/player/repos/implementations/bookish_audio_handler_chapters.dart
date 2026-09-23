part of 'bookish_audio_handler.dart';

Duration? nextChapterPosition(List<AudioChapter> chapters, Duration position) {
  for (final chapter in chapters) {
    if (chapter.startMs > position.inMilliseconds) {
      return Duration(milliseconds: chapter.startMs);
    }
  }
  return null;
}

Duration previousChapterPosition(
  List<AudioChapter> chapters,
  Duration position,
) {
  final index = _chapterIndex(chapters, position.inMilliseconds);
  final start = chapters[index].startMs;
  final previous = position.inMilliseconds - start > 3000 || index == 0
      ? start
      : chapters[index - 1].startMs;
  return Duration(milliseconds: previous);
}

int _chapterIndex(List<AudioChapter> chapters, int position) {
  for (var index = chapters.length - 1; index > 0; index--) {
    if (position >= chapters[index].startMs) {
      return index;
    }
  }
  return 0;
}

extension _BookishAudioHandlerChapters on BookishAudioHandler {
  void _broadcastCurrentItem() {
    final sequence = _player.sequence;
    final index = _player.currentIndex;
    if (index == null || index >= sequence.length) {
      return;
    }
    final tag = sequence[index].tag;
    if (tag is! MediaItem) {
      return;
    }

    final chapters = _chaptersFor(tag);
    final current = chapters == null
        ? tag
        : tag.copyWith(
            displaySubtitle:
                chapters[_chapterIndex(
                      chapters,
                      _player.position.inMilliseconds,
                    )]
                    .title,
          );
    if (mediaItem.value?.id != current.id ||
        mediaItem.value?.displaySubtitle != current.displaySubtitle) {
      mediaItem.add(current);
    }
  }

  List<AudioChapter>? get _currentChapters {
    final index = _player.currentIndex;
    final sequence = _player.sequence;
    if (index == null || index >= sequence.length) {
      return null;
    }
    final tag = sequence[index].tag;
    return tag is MediaItem ? _chaptersFor(tag) : null;
  }

  List<AudioChapter>? _chaptersFor(MediaItem item) {
    if (identical(item, _chapterItem)) {
      return _chapters;
    }
    _chapterItem = item;
    final values = item.extras?['chapters'];
    if (values is! List || values.isEmpty) {
      _chapters = null;
      return _chapters;
    }
    _chapters = [
      for (final value in values)
        AudioChapter.fromJson(Map<String, dynamic>.from(value as Map)),
    ];
    return _chapters;
  }
}
