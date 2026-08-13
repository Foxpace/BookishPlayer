import 'dart:async';

import 'package:injectable/injectable.dart';

import '../../library/models/library_models.dart';
import '../repos/audio_player_repository.dart';

@injectable
class SleepTimerUseCase {
  const SleepTimerUseCase(this._audio);

  final AudioPlayerRepository _audio;

  Timer scheduleFixed(
    Duration duration,
    Duration fade,
    Future<void> Function() onElapsed,
  ) => _schedule(duration - fade, () => _fadeAndPause(fade, onElapsed));

  Timer scheduleChapterFallback(
    Duration fallback,
    Duration fade,
    Future<void> Function() onElapsed,
  ) => _schedule(fallback, () => _fadeAndPause(fade, onElapsed));

  int chapterEnd(Audiobook book, Duration position) {
    final following = book.chapters
        .where((chapter) => chapter.startMs > position.inMilliseconds + 500)
        .map((chapter) => chapter.startMs);
    return following.isEmpty ? book.durationMs : following.first;
  }

  Timer _schedule(Duration delay, Future<void> Function() onElapsed) =>
      Timer(delay < Duration.zero ? Duration.zero : delay, onElapsed);

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
}
