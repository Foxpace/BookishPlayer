import '../../library/domain/audiobook.dart';
import '../application/playback_open_result.dart';
import '../domain/book_note.dart';
import 'player_state.dart';
import 'player_timeline_projector.dart';

class PlayerStateFactory {
  const PlayerStateFactory(this._timeline);

  final PlayerTimelineProjector _timeline;

  PlayerState opening(Audiobook book) => _timeline.project(
    PlayerState(
      status: PlayerStatus.loading,
      book: book,
      position: Duration(milliseconds: book.positionMs),
      duration: Duration(milliseconds: book.durationMs),
      speed: book.playbackSpeed,
    ),
  );

  PlayerState ready(PlaybackOpenResult result, List<BookNote> notes) =>
      _timeline.project(
        PlayerState(
          status: PlayerStatus.ready,
          book: result.book,
          position: Duration(milliseconds: result.book.positionMs),
          duration: Duration(milliseconds: result.book.durationMs),
          speed: result.book.playbackSpeed,
          playback: result.preferences,
          notes: notes,
        ),
      );

  PlayerState clearSleep(PlayerState state) => state.copyWith(
    sleepTimerType: null,
    sleepEndsAt: null,
    sleepChapterEndMs: null,
  );
}
