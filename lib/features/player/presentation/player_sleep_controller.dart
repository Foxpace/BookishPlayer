import 'dart:async';

import 'player_state.dart';

class PlayerSleepController {
  Timer? _timer;

  PlayerState setFixed(
    PlayerState state,
    Duration duration,
    Future<void> Function() onElapsed,
  ) {
    _timer?.cancel();
    _timer = Timer(duration, onElapsed);
    return state.copyWith(
      sleepTimerType: SleepTimerType.fixed,
      sleepEndsAt: DateTime.now().add(duration),
      sleepChapterEndMs: null,
    );
  }

  PlayerState setChapterEnd(PlayerState state) {
    final book = state.book;
    if (book == null) {
      return state;
    }
    final positionMs = state.position.inMilliseconds;
    final following = book.chapters
        .where((chapter) => chapter.startMs > positionMs + 500)
        .map((chapter) => chapter.startMs);
    _timer?.cancel();
    return state.copyWith(
      sleepTimerType: SleepTimerType.endOfChapter,
      sleepEndsAt: null,
      sleepChapterEndMs: following.isEmpty ? book.durationMs : following.first,
    );
  }

  PlayerState cancel(PlayerState state) {
    _timer?.cancel();
    _timer = null;
    return state.copyWith(
      sleepTimerType: null,
      sleepEndsAt: null,
      sleepChapterEndMs: null,
    );
  }

  void dispose() => _timer?.cancel();
}
