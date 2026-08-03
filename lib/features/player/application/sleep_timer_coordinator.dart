import 'dart:async';

import '../../library/domain/audiobook.dart';
import '../domain/audio_player_repository.dart';

class SleepTimerCoordinator {
  SleepTimerCoordinator(this._audio);

  final AudioPlayerRepository _audio;
  Timer? _timer;

  void scheduleFixed(
    Duration duration,
    Duration fade,
    Future<void> Function() onElapsed,
  ) {
    _schedule(duration - fade, () => _fadeAndPause(fade, onElapsed));
  }

  void scheduleChapterFallback(
    Duration fallback,
    Duration fade,
    Future<void> Function() onElapsed,
  ) {
    _schedule(fallback, () => _fadeAndPause(fade, onElapsed));
  }

  int chapterEnd(Audiobook book, Duration position) {
    final following = book.chapters
        .where((chapter) => chapter.startMs > position.inMilliseconds + 500)
        .map((chapter) => chapter.startMs);
    return following.isEmpty ? book.durationMs : following.first;
  }

  void _schedule(Duration delay, Future<void> Function() onElapsed) {
    _timer?.cancel();
    _timer = Timer(delay < Duration.zero ? Duration.zero : delay, onElapsed);
  }

  Future<void> _fadeAndPause(
    Duration fade,
    Future<void> Function() onElapsed,
  ) async {
    const steps = 10;
    final step = fade.inMilliseconds <= 0
        ? Duration.zero
        : Duration(milliseconds: fade.inMilliseconds ~/ steps);
    for (var index = steps - 1; index >= 0; index--) {
      await _audio.setVolume(index / steps);
      if (step > Duration.zero) {
        await Future<void>.delayed(step);
      }
    }
    await _audio.pause();
    await _audio.setVolume(1);
    await onElapsed();
  }

  void cancel() {
    _timer?.cancel();
    _timer = null;
  }

  void dispose() => cancel();
}
