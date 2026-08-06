import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/presentation/diagnostic_failure.dart';
import '../../library/domain/audiobook.dart';
import '../../library/domain/audiobook_catalog_repository.dart';
import '../../library/domain/book_note_repository.dart';
import '../../library/domain/listening_history_repository.dart';
import '../../portability/domain/local_export_repository.dart';
import '../application/playback_command_service.dart';
import '../application/playback_open_result.dart';
import '../application/player_notes_service.dart';
import '../application/player_progress_saver.dart';
import '../application/listening_session_tracker.dart';
import '../application/chapter_navigation_policy.dart';
import '../application/series_continuation_policy.dart';
import '../application/sleep_timer_coordinator.dart';
import '../domain/audio_player_repository.dart';
import '../domain/book_note.dart';
import '../domain/quote_share_repository.dart';
import 'player_state.dart';
import 'player_state_factory.dart';
import 'player_timeline_projector.dart';
import 'playback_resume_policy.dart';

part 'player_cubit_notes.dart';
part 'player_cubit_lifecycle.dart';

@lazySingleton
class PlayerCubit extends Cubit<PlayerState> {
  PlayerCubit(
    this._audio,
    this._books,
    this._history,
    BookNoteRepository noteRepository,
    LocalExportRepository exports,
    QuoteShareRepository sharing,
    this._commands,
  ) : super(const PlayerState()) {
    _progress = PlayerProgressSaver(_audio, _books);
    _notes = PlayerNotesService(noteRepository, exports, sharing);
    _sessions = ListeningSessionTracker(_history);
    _sleep = SleepTimerCoordinator(_audio);
    _subscriptions.add(_commands.opened.listen(_onExternallyOpened));
    _subscriptions.add(_audio.positionStream.listen(_onPosition));
    _subscriptions.add(
      _audio.bufferedPositionStream.listen(
        (value) =>
            emit(_timeline.project(state.copyWith(bufferedPosition: value))),
      ),
    );
    _subscriptions.add(
      _audio.durationStream.listen((value) {
        if (value != null) {
          emit(_timeline.project(state.copyWith(duration: value)));
        }
      }),
    );
    _subscriptions.add(
      _audio.playingStream.listen((playing) => _handlePlaying(playing)),
    );
    _subscriptions.add(
      _audio.completedStream.listen((completed) {
        if (completed) {
          unawaited(_handleCompleted());
        }
      }),
    );
  }

  final AudioPlayerRepository _audio;
  final AudiobookCatalogRepository _books;
  final ListeningHistoryRepository _history;
  final PlaybackCommandService _commands;
  final _timeline = const PlayerTimelineProjector();
  late final _states = PlayerStateFactory(_timeline);
  late final PlayerProgressSaver _progress;
  late final PlayerNotesService _notes;
  late final ListeningSessionTracker _sessions;
  final List<StreamSubscription<Object?>> _subscriptions = [];
  late final SleepTimerCoordinator _sleep;
  final _resumePolicy = PlaybackResumePolicy();
  final _series = const SeriesContinuationPolicy();
  final _chapters = const ChapterNavigationPolicy();
  var _openingLocally = false;
  var _resettingAppData = false;

  void _emit(PlayerState value) => emit(value);

  Future<void> open(Audiobook book) async {
    final currentBook = state.book;
    if (currentBook != null && currentBook.id != book.id) {
      await _finishListeningSession();
      _sleep.cancel();
    }
    emit(_states.opening(book));
    try {
      _openingLocally = true;
      final result = await _commands.open(book);
      await _applyOpened(result);
    } catch (error) {
      _fail('This audiobook could not be played.', error);
    } finally {
      _openingLocally = false;
    }
  }

  Future<void> openById(String bookId) async {
    if (state.book?.id == bookId && state.status == PlayerStatus.ready) {
      return;
    }
    emit(state.copyWith(status: PlayerStatus.loading));
    try {
      final book = await _books.getBook(bookId);
      if (book == null) {
        throw StateError('missing book');
      }
      await open(book);
    } catch (error) {
      _fail('This audiobook could not be opened.', error);
    }
  }

  Future<void> togglePlayback() async {
    if (state.status != PlayerStatus.ready) {
      return;
    }
    if (_audio.isPlaying) {
      await _commands.toggle();
      await saveProgress();
    } else {
      if (state.position >= state.duration && state.duration > Duration.zero) {
        await _audio.seek(Duration.zero);
      }
      await _commands.toggle();
    }
  }

  void _fail(String action, Object error) => emit(
    state.copyWith(
      status: PlayerStatus.failure,
      message: diagnosticFailureMessage(action, error),
    ),
  );

  void _onExternallyOpened(PlaybackOpenResult result) {
    if (!_openingLocally) {
      unawaited(_applyOpened(result));
    }
  }

  Future<void> _applyOpened(PlaybackOpenResult result) async {
    final previous = state.book;
    if (previous != null && previous.id != result.book.id) {
      await _finishListeningSession();
      _sleep.cancel();
    }
    emit(_states.ready(result, await _notes.load(result.book.id)));
  }

  Future<void> seek(Duration value) async {
    final target = _timeline.bounded(value, state.duration);
    emit(_timeline.project(state.copyWith(position: target)));
    await _audio.seek(target);
    await saveProgress();
  }

  Future<void> seekWithinChapter(Duration value) {
    final duration = state.chapterDuration;
    final maximum = duration > Duration.zero
        ? duration - const Duration(milliseconds: 1)
        : Duration.zero;
    final relative = _timeline.bounded(value, maximum);
    return seek(state.chapterStart + relative);
  }

  Future<void> skipBy(Duration delta) => seek(state.position + delta);

  Future<void> previousChapter() async {
    final book = state.book;
    if (book == null || book.chapters.isEmpty) {
      return;
    }
    await seek(
      _chapters.previous(
        book: book,
        index: state.currentChapterIndex,
        chapterPosition: state.chapterPosition,
        chapterStart: state.chapterStart,
      ),
    );
  }

  Future<void> nextChapter() async {
    final book = state.book;
    if (book == null || book.chapters.isEmpty) {
      return;
    }
    await seek(_chapters.next(book, state.currentChapterIndex));
  }

  Future<void> changeSpeed(double speed) async {
    await _audio.setSpeed(speed);
    final book = state.book;
    if (book != null) {
      await _books.updatePlaybackSpeed(book.id, speed);
      emit(
        state.copyWith(
          speed: speed,
          book: book.copyWith(playbackSpeed: speed),
        ),
      );
    } else {
      emit(state.copyWith(speed: speed));
    }
  }

  void setSleepTimer(Duration duration) {
    final fade = Duration(seconds: state.playback.sleepFadeSeconds);
    _sleep.scheduleFixed(duration, fade, _finishSleep);
    emit(
      state.copyWith(
        sleepTimerType: SleepTimerType.fixed,
        sleepEndsAt: DateTime.now().add(duration),
        sleepChapterEndMs: null,
      ),
    );
  }

  Future<void> _finishSleep() async {
    await saveProgress();
    cancelSleepTimer();
  }

  void sleepAtEndOfChapter() {
    final minutes = state.playback.chapterFallbackMinutes;
    final book = state.book;
    if (book == null) {
      return;
    }
    _sleep.cancel();
    if (minutes > 0) {
      _sleep.scheduleChapterFallback(
        Duration(minutes: minutes),
        Duration(seconds: state.playback.sleepFadeSeconds),
        _finishSleep,
      );
    }
    emit(
      state.copyWith(
        sleepTimerType: SleepTimerType.endOfChapter,
        sleepEndsAt: null,
        sleepChapterEndMs: _sleep.chapterEnd(book, state.position),
      ),
    );
  }

  void cancelSleepTimer() {
    _sleep.cancel();
    emit(_states.clearSleep(state));
  }

  Future<void> saveProgress() => _progress.save(state.book);

  void _onPosition(Duration position) {
    emit(_timeline.project(state.copyWith(position: position)));
    final sleepTarget = state.sleepChapterEndMs;
    if (sleepTarget != null && position.inMilliseconds >= sleepTarget) {
      unawaited(_sleepAtChapterBoundary());
    }
    if (_progress.checkpointDue) {
      unawaited(saveProgress());
    }
  }

  Future<void> _sleepAtChapterBoundary() async {
    if (state.sleepChapterEndMs == null) {
      return;
    }
    await _audio.pause();
    await saveProgress();
    cancelSleepTimer();
  }

  @override
  Future<void> close() async {
    _sleep.dispose();
    await _finishListeningSession();
    await saveProgress();
    for (final subscription in _subscriptions) {
      await subscription.cancel();
    }
    return super.close();
  }
}
