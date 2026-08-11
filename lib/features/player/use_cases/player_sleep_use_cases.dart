import 'dart:async';

import 'package:injectable/injectable.dart';

import '../../library/models/library_models.dart';
import '../repos/audio_player_repository.dart';
import 'player_progress_saver.dart';
import 'sleep_timer_use_case.dart';

@lazySingleton
class PlayerSleepUseCases {
  const PlayerSleepUseCases(this._timer, this._progress, this._audio);

  final SleepTimerUseCase _timer;
  final PlayerProgressSaver _progress;
  final AudioPlayerRepository _audio;

  Timer scheduleFixed({
    required Duration duration,
    required int fadeSeconds,
    required Future<void> Function() onFinished,
  }) {
    return _timer.scheduleFixed(
      duration,
      Duration(seconds: fadeSeconds),
      onFinished,
    );
  }

  ({Timer? fallbackTimer, int chapterEnd}) scheduleChapterEnd({
    required Audiobook book,
    required Duration position,
    required int fallbackMinutes,
    required int fadeSeconds,
    required Future<void> Function() onFinished,
  }) {
    Timer? fallbackTimer;
    if (fallbackMinutes > 0) {
      fallbackTimer = _timer.scheduleChapterFallback(
        Duration(minutes: fallbackMinutes),
        Duration(seconds: fadeSeconds),
        onFinished,
      );
    }

    return (
      fallbackTimer: fallbackTimer,
      chapterEnd: _timer.chapterEnd(book, position),
    );
  }

  bool checkpointDue(DateTime lastSavedAt) =>
      _progress.checkpointDue(lastSavedAt);

  Future<void> pause() => _audio.pause();

  Future<DateTime?> save(Audiobook? book, Duration position) =>
      _progress.save(book, position);
}
