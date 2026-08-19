part of 'player_cubit.dart';

extension PlayerCubitProgress on PlayerCubit {
  void handlePosition(Duration position) {
    _emit(state.copyWith(position: position).projectTimeline());
    final chapterEnd = state.sleepChapterEndMs;
    if (chapterEnd != null && position.inMilliseconds >= chapterEnd) {
      unawaited(_sleepAtChapterBoundary());
    }
    if (_application.progressCheckpointDue()) {
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

  Future<void> saveProgress() =>
      _application.saveProgress(state.book, state.position);
}
