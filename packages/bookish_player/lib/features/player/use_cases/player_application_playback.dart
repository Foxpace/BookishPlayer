part of 'player_application.dart';

extension PlayerApplicationPlayback on PlayerApplication {
  void scheduleFixedSleep({
    required Duration duration,
    required int fadeSeconds,
    required Future<void> Function() onFinished,
  }) {
    cancelSleepTimer();
    _sleepTimer = _sleep.scheduleFixed(
      duration: duration,
      fadeSeconds: fadeSeconds,
      onFinished: onFinished,
    );
  }

  int scheduleChapterEndSleep({
    required Audiobook book,
    required Duration position,
    required int fallbackMinutes,
    required int fadeSeconds,
    required Future<void> Function() onFinished,
  }) {
    cancelSleepTimer();
    final scheduled = _sleep.scheduleChapterEnd(
      book: book,
      position: position,
      fallbackMinutes: fallbackMinutes,
      fadeSeconds: fadeSeconds,
      onFinished: onFinished,
    );
    _sleepTimer = scheduled.fallbackTimer;
    return scheduled.chapterEnd;
  }

  void cancelSleepTimer() {
    _sleepTimer?.cancel();
    _sleepTimer = null;
  }

  Future<void> pauseForSleep() => _sleep.pause();

  bool progressCheckpointDue() =>
      _sleep.checkpointDue(_runtime.progressCheckpoint);

  Future<void> saveProgress(Audiobook? book, Duration position) {
    if (book == null) {
      return Future.value();
    }
    _runtime.pendingProgress = (book: book, position: position);
    if (_runtime.progressWriteInFlight) {
      return Future.value();
    }
    return _flushProgressWrites();
  }

  Future<PlayerPlayingResult> updatePlaying({
    required bool playing,
    required PlayerPlaybackContext context,
  }) async {
    await _updateListeningSession(playing, context);
    final result = await _lifecycle.updatePlaying((
      playing: playing,
      book: context.book,
      position: context.position,
      duration: context.duration,
      chapterStart: context.chapterStart,
      wasPlaying: _runtime.wasPlaying,
      pausedAt: _runtime.pausedAt,
    ));
    _runtime
      ..wasPlaying = result.wasPlaying
      ..pausedAt = result.pausedAt;

    if (result.shouldSave) {
      await saveProgress(context.book, result.position ?? context.position);
    }
    return result;
  }

  Future<void> finishListeningSession(PlayerPlaybackContext context) async {
    final startedAt = _runtime.listeningStartedAt;
    final startPosition = _runtime.listeningStartPosition;
    _runtime
      ..listeningStartedAt = null
      ..listeningStartPosition = null;
    await _lifecycle.finishListeningSession(
      startedAt: startedAt,
      startPosition: startPosition,
      book: context.book,
      position: context.position,
      speed: context.speed,
    );
  }

  Future<void> resetForAppDataRemoval(PlayerPlaybackContext context) =>
      _suppressPlaybackEvents(() async {
        cancelSleepTimer();
        await finishListeningSession(context);
        await _lifecycle.resetForAppDataRemoval();
        _runtime.clearPlaybackLifecycle();
      });

  Future<bool> removeBook({
    required String bookId,
    required PlayerPlaybackContext context,
  }) => _suppressPlaybackEvents(() async {
    if (context.book?.id == bookId) {
      cancelSleepTimer();
      await finishListeningSession(context);
    }
    final removed = await _lifecycle.removeBook(
      currentBook: context.book,
      bookId: bookId,
    );
    if (removed) {
      _runtime.clearPlaybackLifecycle();
    }
    return removed;
  });

  Future<PlayerCompletionResult?> complete({
    required Audiobook? currentBook,
    required Duration duration,
    required bool continueSeries,
  }) => _lifecycle.complete(
    currentBook: currentBook,
    duration: duration,
    continueSeries: continueSeries,
  );
}
