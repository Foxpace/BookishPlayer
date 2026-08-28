import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/presentation/app_message.dart';
import '../../library/models/library_models.dart';
import '../../notes/models/book_note.dart';
import '../../settings/models/playback_preferences.dart';

import 'player_status.dart';
import 'sleep_timer_type.dart';
import 'player_chapter.dart';
part 'player_state.freezed.dart';

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
    @Default(PlaybackPreferences()) PlaybackPreferences playback,

    @Default(false) bool continueListeningChecked,
    Audiobook? continueListeningBook,

    SleepTimerType? sleepTimerType,
    int? sleepRemainingMinutes,
    int? sleepChapterEndMs,

    @Default(<BookNote>[]) List<BookNote> notes,
    AppMessage? message,
    @Default(0) int effectRevision,
  }) = _PlayerState;
}
