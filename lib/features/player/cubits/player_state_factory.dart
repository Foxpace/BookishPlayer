import 'package:injectable/injectable.dart';

import '../../library/models/library_models.dart';
import '../models/playback_open_result.dart';
import '../../notes/models/note_models.dart';
import 'player_state.dart';
import 'player_status.dart';
import 'player_state_timeline.dart';

@lazySingleton
class PlayerStateFactory {
  const PlayerStateFactory();

  PlayerState buildOpeningState(Audiobook book) => PlayerState(
    status: PlayerStatus.loading,
    book: book,
    position: Duration(milliseconds: book.positionMs),
    duration: Duration(milliseconds: book.durationMs),
    speed: book.playbackSpeed,
  ).projectTimeline();

  PlayerState buildReadyState(
    PlaybackOpenResult result,
    List<BookNote> notes,
  ) => PlayerState(
    status: PlayerStatus.ready,
    book: result.book,
    position: Duration(milliseconds: result.book.positionMs),
    duration: Duration(milliseconds: result.book.durationMs),
    speed: result.book.playbackSpeed,
    playback: result.preferences,
    notes: notes,
  ).projectTimeline();

  PlayerState clearSleep(PlayerState state) => state.copyWith(
    sleepTimerType: null,
    sleepRemainingMinutes: null,
    sleepChapterEndMs: null,
  );
}
