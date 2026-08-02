import 'package:freezed_annotation/freezed_annotation.dart';

import '../../library/domain/audiobook.dart';
import '../domain/book_note.dart';

part 'player_state.freezed.dart';

enum PlayerStatus { idle, loading, ready, failure }

enum SleepTimerType { fixed, endOfChapter }

@freezed
abstract class PlayerState with _$PlayerState {
  const factory PlayerState({
    @Default(PlayerStatus.idle) PlayerStatus status,
    Audiobook? book,
    @Default(Duration.zero) Duration position,
    @Default(Duration.zero) Duration bufferedPosition,
    @Default(Duration.zero) Duration duration,
    AudioChapter? currentChapter,
    @Default(0) int currentChapterIndex,
    @Default(0) int chapterCount,
    @Default(Duration.zero) Duration chapterStart,
    @Default(Duration.zero) Duration chapterPosition,
    @Default(Duration.zero) Duration chapterBufferedPosition,
    @Default(Duration.zero) Duration chapterDuration,
    @Default(<PlayerChapter>[]) List<PlayerChapter> chapterTimeline,
    @Default(false) bool isPlaying,
    @Default(1.0) double speed,
    SleepTimerType? sleepTimerType,
    DateTime? sleepEndsAt,
    int? sleepChapterEndMs,
    @Default(<BookNote>[]) List<BookNote> notes,
    String? message,
  }) = _PlayerState;
}

@freezed
abstract class PlayerChapter with _$PlayerChapter {
  const factory PlayerChapter({
    required int index,
    required String title,
    required Duration start,
    required Duration duration,
  }) = _PlayerChapter;
}
