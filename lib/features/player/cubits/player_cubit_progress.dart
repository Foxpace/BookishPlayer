part of 'player_cubit.dart';

extension PlayerCubitProgress on PlayerCubit {
  void handlePosition(Duration position) {
    _emit(state.copyWith(position: position).projectTimeline());
    final chapterEnd = state.sleepChapterEndMs;
    if (chapterEnd != null && position.inMilliseconds >= chapterEnd) {
      unawaited(_sleepAtChapterBoundary());
    }
    if (_useCases.sleep.checkpointDue(_runtime.progressCheckpoint)) {
      unawaited(saveProgress());
    }
  }

  void _handleBufferedPosition(Duration value) {
    _emit(state.copyWith(bufferedPosition: value).projectTimeline());
  }

  void _handleDuration(Duration? value) {
    if (value != null) {
      _emit(state.copyWith(duration: value).projectTimeline());
    }
  }

  void _handleCompletedSignal({required bool completed}) {
    if (completed) {
      unawaited(handleCompleted());
    }
  }

  Future<void> saveProgress() async {
    final book = state.book;
    if (book == null) {
      return;
    }

    _runtime = _runtime.copyWith(
      pendingProgress: PlayerProgressSnapshot(
        book: book,
        position: state.position,
      ),
    );
    if (_runtime.progressWriteInFlight) {
      return;
    }
    await _flushProgressWrites();
  }

  Future<void> _flushProgressWrites() async {
    _runtime = _runtime.copyWith(progressWriteInFlight: true);
    try {
      while (_runtime.pendingProgress != null) {
        await _writePendingProgress();
      }
    } finally {
      _runtime = _runtime.copyWith(progressWriteInFlight: false);
    }
  }

  Future<void> _writePendingProgress() async {
    final pending = _runtime.pendingProgress;
    _runtime = _runtime.copyWith(pendingProgress: null);
    if (pending == null) {
      return;
    }
    final savedAt = await _useCases.sleep.save(pending.book, pending.position);
    if (savedAt != null) {
      _runtime = _runtime.copyWith(lastProgressSavedAt: savedAt);
    }
  }
}
