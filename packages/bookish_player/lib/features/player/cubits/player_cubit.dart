import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/presentation/app_message.dart';
import '../../library/models/library_models.dart';
import '../../notes/models/note_models.dart';
import '../models/playback_open_result.dart';
import '../models/share_origin.dart';
import '../use_cases/playback_command_service.dart';
import '../use_cases/player_lifecycle_use_cases.dart';
import '../use_cases/player_use_cases.dart';
import 'player_duration_clamp.dart';
import 'player_playback_streams.dart';
import 'player_runtime_state.dart';
import 'player_cubits.dart';
import 'player_state_factory.dart';
import 'player_state_timeline.dart';

part 'player_cubit_lifecycle.dart';
part 'player_cubit_notes_and_sleep.dart';
part 'player_cubit_progress.dart';

@lazySingleton
class PlayerCubit extends Cubit<PlayerState> {
  PlayerCubit(this._useCases, this._states, PlayerPlaybackStreams streams)
    : _runtime = const PlayerRuntimeState(),
      super(const PlayerState()) {
    _subscriptions.addAll(
      streams.listen((
        onPlayBookRequested: _handlePlayBookRequest,
        onPosition: handlePosition,
        onBufferedPosition: _handleBufferedPosition,
        onDuration: _handleDuration,
        onPlaying: _handlePlaying,
        onCompleted: _handleCompletedSignal,
      )),
    );
  }

  final PlayerUseCases _useCases;
  final PlayerStateFactory _states;
  final List<StreamSubscription<Object?>> _subscriptions = [];
  Timer? _sleepTimer;
  PlayerRuntimeState _runtime;

  void _emit(PlayerState nextState) => emit(nextState);

  Future<void> open(Audiobook book) async {
    final previousBook = state.book;
    if (previousBook != null && previousBook.id != book.id) {
      await finishListeningSession();
      _cancelSleepTimer();
    }
    emit(_states.buildOpeningState(book));
    try {
      await _openBookAndApply(book, previousBook);
    } catch (_) {
      _fail(AppMessage.audiobookPlaybackFailed);
    }
  }

  Future<void> openById(String bookId) async {
    if (state.book?.id == bookId && state.status == PlayerStatus.ready) {
      return;
    }
    emit(state.copyWith(status: PlayerStatus.loading));
    try {
      await _openBookById(bookId);
    } catch (_) {
      _fail(AppMessage.audiobookOpenFailed);
    }
  }

  Future<void> togglePlayback() => _useCases.transport.toggle(
    ready: state.status == PlayerStatus.ready,
    book: state.book,
    position: state.position,
    duration: state.duration,
  );

  Future<void> pickAudioOutput() => _useCases.showAudioOutputPicker();

  Future<void> _openBookAndApply(
    Audiobook book,
    Audiobook? previousBook,
  ) async {
    final result = await _useCases.lifecycle.openBook(
      book,
      previousBook: previousBook,
    );
    await _applyOpened(result);
  }

  Future<void> _openBookById(String bookId) async {
    final book = await _useCases.lifecycle.findBook(bookId);
    if (book == null) {
      throw StateError('missing book');
    }
    await open(book);
  }

  void _handlePlayBookRequest(PlaybackBookRequest request) {
    request.completeWith(_playRequestedBook(request.bookId));
  }

  Future<void> _playRequestedBook(String bookId) async {
    await openById(bookId);

    if (state.status == PlayerStatus.ready && state.book?.id == bookId) {
      await _useCases.lifecycle.continuePlayback();
    }
  }

  Future<void> _applyOpened(PlaybackOpenResult result) async {
    final previous = state;
    if (previous.book != null && previous.book?.id != result.book.id) {
      await finishListeningSession();
      _cancelSleepTimer();
    }
    final notes = await _useCases.lifecycle.prepareOpened(result: result);
    emit(_states.buildReadyState(result, notes));
  }

  void _fail(AppMessage message) => emit(
    state.copyWith(
      status: PlayerStatus.failure,
      message: message,
      effectRevision: state.effectRevision + 1,
    ),
  );

  Future<void> seek(Duration value) => _applySeek(
    _useCases.transport.seek(
      book: state.book,
      value: value,
      duration: state.duration,
    ),
  );
  Future<void> seekWithinChapter(Duration value) => _applySeek(
    _useCases.transport.seekWithinChapter(
      book: state.book,
      value: value,
      duration: state.duration,
      chapterStart: state.chapterStart,
      chapterDuration: state.chapterDuration,
    ),
  );
  Future<void> skipBy(Duration delta) => seek(state.position + delta);
  Future<void> previousChapter() => _applySeek(
    _useCases.transport.previousChapter(
      book: state.book,
      duration: state.duration,
      index: state.currentChapterIndex,
      chapterPosition: state.chapterPosition,
      chapterStart: state.chapterStart,
    ),
  );
  Future<void> nextChapter() => _applySeek(
    _useCases.transport.nextChapter(
      book: state.book,
      duration: state.duration,
      index: state.currentChapterIndex,
    ),
  );

  Future<void> _applySeek(Future<Duration?> operation) async {
    final position = await operation;
    if (position != null) {
      emit(state.copyWith(position: position).projectTimeline());
      await saveProgress();
    }
  }

  Future<void> changeSpeed(double speed) async {
    final book = await _useCases.transport.changeSpeed(state.book, speed);
    emit(state.copyWith(speed: speed, book: book ?? state.book));
  }

  Future<void> resetForAppDataRemoval() async {
    _runtime = _runtime.copyWith(suppressingPlaybackEvents: true);
    try {
      await _resetAndEmit();
    } finally {
      _runtime = _runtime.copyWith(suppressingPlaybackEvents: false);
    }
  }

  Future<void> _resetAndEmit() async {
    _cancelSleepTimer();
    await finishListeningSession();
    await _useCases.lifecycle.resetForAppDataRemoval();
    _runtime = _runtime.clearPlaybackLifecycle();
    emit(PlayerState(effectRevision: state.effectRevision));
  }

  Future<void> removeBook(String bookId) async {
    _runtime = _runtime.copyWith(suppressingPlaybackEvents: true);
    try {
      await _removeBookAndEmit(bookId);
    } finally {
      _runtime = _runtime.copyWith(suppressingPlaybackEvents: false);
    }
  }

  Future<void> _removeBookAndEmit(String bookId) async {
    if (state.book?.id == bookId) {
      _cancelSleepTimer();
      await finishListeningSession();
    }
    final removed = await _useCases.lifecycle.removeBook(
      currentBook: state.book,
      bookId: bookId,
    );
    if (removed) {
      _runtime = _runtime.clearPlaybackLifecycle();
      emit(PlayerState(effectRevision: state.effectRevision));
    }
  }

  Future<void> handleCompleted() async {
    final result = await _useCases.lifecycle.complete(
      currentBook: state.book,
      duration: state.duration,
      continueSeries: state.playback.continueSeries,
    );
    if (result == null) {
      return;
    }

    emit(
      state
          .copyWith(book: result.finishedBook, position: result.position)
          .projectTimeline(),
    );

    final nextBook = result.nextBook;
    if (nextBook != null) {
      await open(nextBook);
      await _useCases.lifecycle.continuePlayback();
    }
  }

  @override
  Future<void> close() async {
    _cancelSleepTimer();
    await finishListeningSession();
    await saveProgress();
    for (final subscription in _subscriptions) {
      await subscription.cancel();
    }
    return super.close();
  }
}
