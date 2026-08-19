part of 'player_application.dart';

class _PlayerApplicationRuntime {
  DateTime? pausedAt;
  DateTime? listeningStartedAt;
  Duration? listeningStartPosition;
  var wasPlaying = false;
  DateTime? lastProgressSavedAt;
  var progressWriteInFlight = false;
  ({Audiobook book, Duration position})? pendingProgress;
  var suppressingPlaybackEvents = false;

  DateTime get progressCheckpoint =>
      lastProgressSavedAt ?? DateTime.fromMillisecondsSinceEpoch(0);

  void clearPlaybackLifecycle() {
    pausedAt = null;
    listeningStartedAt = null;
    listeningStartPosition = null;
    wasPlaying = false;
    lastProgressSavedAt = null;
    progressWriteInFlight = false;
    pendingProgress = null;
  }
}

extension on PlayerApplication {
  Future<void> _updateListeningSession(
    bool playing,
    PlayerPlaybackContext context,
  ) async {
    if (playing && _runtime.listeningStartedAt == null) {
      final session = _lifecycle.startListeningSession(context.position);
      _runtime
        ..listeningStartedAt = session.startedAt
        ..listeningStartPosition = session.startPosition;
    } else if (!playing) {
      await finishListeningSession(context);
    }
  }

  Future<void> _flushProgressWrites() async {
    _runtime.progressWriteInFlight = true;
    try {
      while (_runtime.pendingProgress != null) {
        await _writePendingProgress();
      }
    } finally {
      _runtime.progressWriteInFlight = false;
    }
  }

  Future<void> _writePendingProgress() async {
    final pending = _runtime.pendingProgress;
    _runtime.pendingProgress = null;
    if (pending == null) {
      return;
    }
    final savedAt = await _sleep.save(pending.book, pending.position);
    if (savedAt != null) {
      _runtime.lastProgressSavedAt = savedAt;
    }
  }

  Future<T> _suppressPlaybackEvents<T>(Future<T> Function() operation) async {
    _runtime.suppressingPlaybackEvents = true;
    try {
      return await operation();
    } finally {
      _runtime.suppressingPlaybackEvents = false;
    }
  }
}
