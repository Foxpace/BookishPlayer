import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/foundation/result.dart';
import '../../../core/presentation/app_message.dart';
import '../../library/models/library_models.dart';
import '../../notes/models/book_note.dart';
import '../../notes/models/book_note_kind.dart';
import '../models/playback_open_result.dart';
import '../models/player_device_failure.dart';
import '../models/share_origin.dart';
import '../use_cases/playback_command_service.dart';
import '../use_cases/player_lifecycle_use_cases.dart';
import '../use_cases/player_application.dart';
import 'player_duration_clamp.dart';
import 'player_cubits.dart';
import 'player_state_factory.dart';
import 'player_state_timeline.dart';

part 'player_cubit_lifecycle.dart';
part 'player_cubit_notes_and_sleep.dart';
part 'player_cubit_progress.dart';

@lazySingleton
class PlayerCubit extends Cubit<PlayerState> {
  PlayerCubit(this._application, this._states) : super(const PlayerState()) {
    _application.connect((
      playBookRequested: _handlePlayBookRequest,
      positionChanged: handlePosition,
      bufferedPositionChanged: _handleBufferedPosition,
      durationChanged: _handleDuration,
      playingChanged: _handlePlaying,
      completedChanged: _handleCompletedSignal,
    ));
  }

  final PlayerApplication _application;
  final PlayerStateFactory _states;

  PlayerPlaybackContext get _playbackContext => (
    book: state.book,
    position: state.position,
    duration: state.duration,
    chapterStart: state.chapterStart,
    speed: state.speed,
  );

  void _emit(PlayerState nextState) => emit(nextState);

  Future<void> open(Audiobook book) async {
    final previousBook = state.book;
    if (previousBook != null && previousBook.id != book.id) {
      await finishListeningSession();
      _application.cancelSleepTimer();
    }
    emit(_states.buildOpeningState(book));
    await _openBookAndApply(book, previousBook);
  }

  Future<void> openById(String bookId) async {
    if (state.book?.id == bookId && state.status == PlayerStatus.ready) {
      return;
    }
    emit(state.copyWith(status: PlayerStatus.loading));
    await _openBookById(bookId);
  }

  Future<void> togglePlayback() => _application.togglePlayback(
    ready: state.status == PlayerStatus.ready,
    book: state.book,
    position: state.position,
    duration: state.duration,
  );

  Future<Result<bool, PlayerDeviceFailure>> pickAudioOutput() =>
      _application.showAudioOutputPicker();

  Future<void> _openBookAndApply(
    Audiobook book,
    Audiobook? previousBook,
  ) async {
    switch (await _application.openBook(book, previousBook: previousBook)) {
      case ResultSuccess(:final value):
        await _applyOpened(value);
      case ResultFailure():
        _fail(AppMessage.audiobookPlaybackFailed);
    }
  }

  Future<void> _openBookById(String bookId) async {
    switch (await _application.findBook(bookId)) {
      case ResultSuccess(:final value):
        await open(value);
      case ResultFailure():
        _fail(AppMessage.audiobookOpenFailed);
    }
  }

  void _handlePlayBookRequest(PlaybackBookRequest request) {
    request.completeWith(_playRequestedBook(request.bookId));
  }

  Future<void> _playRequestedBook(String bookId) async {
    await openById(bookId);

    if (state.status == PlayerStatus.ready && state.book?.id == bookId) {
      await _application.continuePlayback();
    }
  }

  Future<void> _applyOpened(PlaybackOpenResult result) async {
    final previous = state;
    if (previous.book != null && previous.book?.id != result.book.id) {
      await finishListeningSession();
      _application.cancelSleepTimer();
    }
    switch (await _application.loadNotes(result)) {
      case ResultSuccess(:final value):
        emit(_states.buildReadyState(result, value));
      case ResultFailure():
        _fail(AppMessage.audiobookPlaybackFailed);
    }
  }

  void _fail(AppMessage message) => emit(
    state.copyWith(
      status: PlayerStatus.failure,
      message: message,
      effectRevision: state.effectRevision + 1,
    ),
  );

  Future<void> seek(Duration value) => _applySeek(
    _application.seek(book: state.book, value: value, duration: state.duration),
  );
  Future<void> seekWithinChapter(Duration value) => _applySeek(
    _application.seekWithinChapter(
      book: state.book,
      value: value,
      duration: state.duration,
      chapterStart: state.chapterStart,
      chapterDuration: state.chapterDuration,
    ),
  );
  Future<void> skipBy(Duration delta) => seek(state.position + delta);
  Future<void> previousChapter() => _applySeek(
    _application.seekToPreviousChapter(
      book: state.book,
      duration: state.duration,
      index: state.currentChapterIndex,
      chapterPosition: state.chapterPosition,
      chapterStart: state.chapterStart,
    ),
  );
  Future<void> nextChapter() => _applySeek(
    _application.seekToNextChapter(
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
    final book = await _application.changeSpeed(state.book, speed);
    emit(state.copyWith(speed: speed, book: book ?? state.book));
  }

  Future<void> resetForAppDataRemoval() async {
    await _application.resetForAppDataRemoval(_playbackContext);
    emit(PlayerState(effectRevision: state.effectRevision));
  }

  Future<void> removeBook(String bookId) async {
    final removed = await _application.removeBook(
      bookId: bookId,
      context: _playbackContext,
    );
    if (removed) {
      emit(PlayerState(effectRevision: state.effectRevision));
    }
  }

  Future<void> handleCompleted() async {
    final result = await _application.complete(
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
      await _application.continuePlayback();
    }
  }

  @override
  Future<void> close() async {
    await _application.disconnect(_playbackContext);
    return super.close();
  }
}
