import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../library/domain/audiobook.dart';
import '../../library/domain/audiobook_repository.dart';
import '../../portability/domain/local_export_repository.dart';
import '../application/player_notes_service.dart';
import '../domain/audio_player_repository.dart';
import '../domain/book_note.dart';
import 'player_state.dart';
import 'player_progress_saver.dart';
import 'player_sleep_controller.dart';
import 'player_timeline_projector.dart';
import 'playback_resume_policy.dart';

@lazySingleton
class PlayerCubit extends Cubit<PlayerState> {
  PlayerCubit(this._audio, this._books, LocalExportRepository exports)
    : super(const PlayerState()) {
    _progress = PlayerProgressSaver(_audio, _books);
    _notes = PlayerNotesService(_books, exports);
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
    _subscriptions.add(_audio.playingStream.listen(_handlePlaying));
    _subscriptions.add(
      _audio.completedStream.listen((completed) {
        if (completed) {
          unawaited(saveProgress());
        }
      }),
    );
  }

  final AudioPlayerRepository _audio;
  final AudiobookRepository _books;
  final _timeline = const PlayerTimelineProjector();
  late final PlayerProgressSaver _progress;
  late final PlayerNotesService _notes;
  final List<StreamSubscription<Object?>> _subscriptions = [];
  final _sleep = PlayerSleepController();
  final _resumePolicy = PlaybackResumePolicy();

  Future<void> open(Audiobook book) async {
    final currentBook = state.book;
    if (currentBook != null && currentBook.id != book.id) {
      await _audio.pause();
      await saveProgress();
      _sleep.cancel(state);
    } else {
      await saveProgress();
    }
    emit(
      _timeline.project(
        PlayerState(
          status: PlayerStatus.loading,
          book: book,
          position: Duration(milliseconds: book.positionMs),
          duration: Duration(milliseconds: book.durationMs),
          speed: book.playbackSpeed,
        ),
      ),
    );
    try {
      await _audio.load(book);
      await _audio.setSpeed(book.playbackSpeed);
      final notes = await _notes.load(book.id);
      emit(state.copyWith(status: PlayerStatus.ready, notes: notes));
    } catch (_) {
      emit(
        state.copyWith(
          status: PlayerStatus.failure,
          message: 'This audiobook could not be played.',
        ),
      );
    }
  }

  Future<void> openById(String bookId) async {
    if (state.book?.id == bookId && state.status == PlayerStatus.ready) {
      return;
    }
    emit(state.copyWith(status: PlayerStatus.loading));
    final book = await _books.getBook(bookId);
    if (book == null) {
      emit(
        state.copyWith(
          status: PlayerStatus.failure,
          message: 'This audiobook is no longer in your library.',
        ),
      );
      return;
    }
    await open(book);
  }

  Future<void> togglePlayback() async {
    if (state.status != PlayerStatus.ready) {
      return;
    }
    if (_audio.isPlaying) {
      await _audio.pause();
      await saveProgress();
    } else {
      if (state.position >= state.duration && state.duration > Duration.zero) {
        await _audio.seek(Duration.zero);
      }
      await _audio.play();
    }
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
    if (state.chapterPosition > const Duration(seconds: 3)) {
      await seek(state.chapterStart);
      return;
    }
    final chapters = _orderedChapters(book);
    final previousIndex = (state.currentChapterIndex - 1)
        .clamp(0, chapters.length - 1)
        .toInt();
    await seek(Duration(milliseconds: chapters[previousIndex].startMs));
  }

  Future<void> nextChapter() async {
    final book = state.book;
    if (book == null || book.chapters.isEmpty) {
      return;
    }
    final chapters = _orderedChapters(book);
    final nextIndex = state.currentChapterIndex + 1;
    if (nextIndex >= chapters.length) {
      await seek(state.duration);
      return;
    }
    await seek(Duration(milliseconds: chapters[nextIndex].startMs));
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
    emit(
      _sleep.setFixed(state, duration, () async {
        await _audio.pause();
        await saveProgress();
        cancelSleepTimer();
      }),
    );
  }

  void sleepAtEndOfChapter() => emit(_sleep.setChapterEnd(state));

  void cancelSleepTimer() => emit(_sleep.cancel(state));

  Future<void> addNote(String text) async {
    return addNoteAt(
      text,
      state.position,
      chapterTitle: state.currentChapter?.title,
    );
  }

  Future<void> addNoteAt(
    String text,
    Duration position, {
    String? chapterTitle,
    Duration? endPosition,
  }) async {
    final book = state.book;
    final clean = text.trim();
    if (book == null || clean.isEmpty) {
      return;
    }
    final notes = await _notes.add(
      book: book,
      notes: state.notes,
      text: clean,
      position: _timeline.bounded(position, state.duration),
      endPosition: endPosition == null
          ? null
          : _timeline.bounded(endPosition, state.duration),
      chapterTitle: chapterTitle,
    );
    emit(state.copyWith(notes: notes));
  }

  Future<void> deleteNote(BookNote note) async {
    emit(state.copyWith(notes: await _notes.delete(state.notes, note)));
  }

  Future<bool> exportNotes() async {
    final book = state.book;
    if (book == null) {
      return false;
    }
    return _notes.export(book, state.notes);
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

  void _handlePlaying(bool playing) {
    emit(state.copyWith(isPlaying: playing));
    final action = _resumePolicy.update(playing: playing);
    if (action.shouldSave) {
      unawaited(saveProgress());
    }
    if (action.rewind > Duration.zero) {
      unawaited(seek(state.position - action.rewind));
    }
  }

  List<AudioChapter> _orderedChapters(Audiobook book) =>
      [...book.chapters]..sort((a, b) => a.startMs.compareTo(b.startMs));

  @override
  Future<void> close() async {
    _sleep.dispose();
    await saveProgress();
    for (final subscription in _subscriptions) {
      await subscription.cancel();
    }
    return super.close();
  }
}
