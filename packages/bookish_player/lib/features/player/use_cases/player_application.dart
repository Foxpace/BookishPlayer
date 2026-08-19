import 'dart:async';

import 'package:injectable/injectable.dart';

import '../../../core/foundation/result.dart';
import '../../library/models/library_models.dart';
import '../../notes/models/book_note.dart';
import '../../notes/use_cases/player_notes_service.dart';
import '../models/playback_open_result.dart';
import '../models/share_origin.dart';
import 'player_application_events.dart';
import 'player_device_gateway.dart';
import 'player_lifecycle_use_cases.dart';
import 'player_note_use_cases.dart';
import 'player_playback_context.dart';
import 'player_sleep_use_cases.dart';
import 'player_transport_use_cases.dart';

export 'player_playback_context.dart';

part 'player_application_runtime.dart';

@lazySingleton
class PlayerApplication {
  PlayerApplication(
    this._lifecycle,
    this._notes,
    this._sleep,
    this._transport,
    this._device,
  );

  final PlayerLifecycleUseCases _lifecycle;
  final PlayerNoteUseCases _notes;
  final PlayerSleepUseCases _sleep;
  final PlayerTransportUseCases _transport;
  final PlayerDeviceGateway _device;
  final _subscriptions = <StreamSubscription<Object?>>[];
  final _runtime = _PlayerApplicationRuntime();
  Timer? _sleepTimer;

  void connect(PlayerApplicationEvents events) {
    if (_subscriptions.isNotEmpty) {
      throw StateError('Player application events are already connected.');
    }
    _subscriptions.addAll(_device.listen(events));
  }

  Future<void> disconnect(PlayerPlaybackContext context) async {
    cancelSleepTimer();
    try {
      await finishListeningSession(context);
      await saveProgress(context.book, context.position);
    } finally {
      final subscriptions = [..._subscriptions];
      _subscriptions.clear();
      await Future.wait(
        subscriptions.map((subscription) => subscription.cancel()),
      );
    }
  }

  bool shouldSuppressPlaybackEvents() => _runtime.suppressingPlaybackEvents;

  Future<Result<PlaybackOpenResult>> openBook(
    Audiobook book, {
    Audiobook? previousBook,
  }) async {
    try {
      return Result.success(
        await _lifecycle.openBook(book, previousBook: previousBook),
      );
    } catch (error) {
      return Result.failure(
        AppFailure.operationFailed('player.open', error: error),
      );
    }
  }

  Future<Result<Audiobook>> findBook(String bookId) async {
    try {
      final book = await _lifecycle.findBook(bookId);
      return book == null
          ? const Result.failure(AppFailure.notFound('player.book'))
          : Result.success(book);
    } catch (error) {
      return Result.failure(
        AppFailure.operationFailed('player.book.find', error: error),
      );
    }
  }

  Future<Result<List<BookNote>>> loadNotes(PlaybackOpenResult result) async {
    try {
      return Result.success(await _lifecycle.prepareOpened(result: result));
    } catch (error) {
      return Result.failure(
        AppFailure.operationFailed('player.notes.load', error: error),
      );
    }
  }

  Future<void> continuePlayback() => _lifecycle.continuePlayback();

  Future<void> togglePlayback({
    required bool ready,
    required Audiobook? book,
    required Duration position,
    required Duration duration,
  }) => _transport.toggle(
    ready: ready,
    book: book,
    position: position,
    duration: duration,
  );

  Future<Result<bool>> showAudioOutputPicker() async {
    try {
      await _device.showAudioOutputPicker();
      return const Result.success(true);
    } catch (error) {
      return Result.failure(
        AppFailure.operationFailed('player.audioOutput.pick', error: error),
      );
    }
  }

  Future<Duration> seek({
    required Audiobook? book,
    required Duration value,
    required Duration duration,
  }) => _transport.seek(book: book, value: value, duration: duration);

  Future<Duration> seekWithinChapter({
    required Audiobook? book,
    required Duration value,
    required Duration duration,
    required Duration chapterStart,
    required Duration chapterDuration,
  }) => _transport.seekWithinChapter(
    book: book,
    value: value,
    duration: duration,
    chapterStart: chapterStart,
    chapterDuration: chapterDuration,
  );

  Future<Duration?> seekToPreviousChapter({
    required Audiobook? book,
    required Duration duration,
    required int index,
    required Duration chapterPosition,
    required Duration chapterStart,
  }) => _transport.previousChapter(
    book: book,
    duration: duration,
    index: index,
    chapterPosition: chapterPosition,
    chapterStart: chapterStart,
  );

  Future<Duration?> seekToNextChapter({
    required Audiobook? book,
    required Duration duration,
    required int index,
  }) => _transport.nextChapter(book: book, duration: duration, index: index);

  Future<Audiobook?> changeSpeed(Audiobook? book, double speed) =>
      _transport.changeSpeed(book, speed);

  Future<List<BookNote>> addNote({
    required Audiobook? book,
    required List<BookNote> notes,
    required PlayerNoteInput input,
  }) => _notes.add(book: book, notes: notes, input: input);

  Future<List<BookNote>> deleteNote(List<BookNote> notes, BookNote note) =>
      _notes.delete(notes, note);

  Future<List<BookNote>> updateNote({
    required List<BookNote> notes,
    required BookNote note,
    required String? title,
    required String text,
  }) => _notes.update(notes: notes, note: note, title: title, text: text);

  Future<void> shareNote(
    Audiobook? book,
    BookNote note, {
    ShareOrigin? origin,
  }) => _notes.share(book, note, origin: origin);

  Future<bool> exportNotes(Audiobook? book, List<BookNote> notes) =>
      _notes.export(book, notes);

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
