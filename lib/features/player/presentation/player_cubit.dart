import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:injectable/injectable.dart';

import '../../library/domain/audiobook.dart';
import '../../library/domain/audiobook_repository.dart';
import '../../portability/domain/local_export_repository.dart';
import '../domain/audio_player_repository.dart';
import '../domain/book_note.dart';
import 'player_state.dart';

@lazySingleton
class PlayerCubit extends Cubit<PlayerState> with WidgetsBindingObserver {
  PlayerCubit(this._audio, this._books, this._exports)
    : super(const PlayerState()) {
    WidgetsBinding.instance.addObserver(this);
    _subscriptions.add(_audio.positionStream.listen(_onPosition));
    _subscriptions.add(
      _audio.bufferedPositionStream.listen(
        (value) =>
            emit(_withChapterTimeline(state.copyWith(bufferedPosition: value))),
      ),
    );
    _subscriptions.add(
      _audio.durationStream.listen((value) {
        if (value != null) {
          emit(_withChapterTimeline(state.copyWith(duration: value)));
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
  final LocalExportRepository _exports;
  final _uuid = const Uuid();
  final List<StreamSubscription<Object?>> _subscriptions = [];
  var _lastSavedAt = DateTime.fromMillisecondsSinceEpoch(0);
  Timer? _sleepTimer;
  DateTime? _pausedAt;
  var _wasPlaying = false;
  var _progressWriteInFlight = false;
  ({String bookId, Duration position})? _pendingProgress;

  Future<void> open(Audiobook book) async {
    final currentBook = state.book;
    if (currentBook != null && currentBook.id != book.id) {
      await _audio.pause();
      await saveProgress();
      _sleepTimer?.cancel();
      _sleepTimer = null;
    } else {
      await saveProgress();
    }
    emit(
      _withChapterTimeline(
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
      final notes = await _books.getNotes(book.id);
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
    final target = _clamp(value);
    emit(_withChapterTimeline(state.copyWith(position: target)));
    await _audio.seek(target);
    await saveProgress();
  }

  Future<void> seekWithinChapter(Duration value) {
    final relative = _bounded(value, state.chapterDuration);
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
    _sleepTimer?.cancel();
    final endsAt = DateTime.now().add(duration);
    emit(
      state.copyWith(
        sleepTimerType: SleepTimerType.fixed,
        sleepEndsAt: endsAt,
        sleepChapterEndMs: null,
      ),
    );
    _sleepTimer = Timer(duration, () async {
      await _audio.pause();
      await saveProgress();
      cancelSleepTimer();
    });
  }

  void sleepAtEndOfChapter() {
    final book = state.book;
    if (book == null) {
      return;
    }
    final positionMs = state.position.inMilliseconds;
    final following = book.chapters
        .where((chapter) => chapter.startMs > positionMs + 500)
        .map((chapter) => chapter.startMs)
        .toList();
    final target = following.isEmpty ? book.durationMs : following.first;
    _sleepTimer?.cancel();
    emit(
      state.copyWith(
        sleepTimerType: SleepTimerType.endOfChapter,
        sleepEndsAt: null,
        sleepChapterEndMs: target,
      ),
    );
  }

  void cancelSleepTimer() {
    _sleepTimer?.cancel();
    _sleepTimer = null;
    emit(
      state.copyWith(
        sleepTimerType: null,
        sleepEndsAt: null,
        sleepChapterEndMs: null,
      ),
    );
  }

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
    final note = BookNote(
      id: _uuid.v4(),
      bookId: book.id,
      positionMs: _clamp(position).inMilliseconds,
      text: clean,
      createdAt: DateTime.now(),
      chapterTitle: chapterTitle,
      endPositionMs: endPosition == null
          ? null
          : _clamp(endPosition).inMilliseconds,
    );
    await _books.saveNote(note);
    final notes = [...state.notes, note]
      ..sort((a, b) => a.positionMs.compareTo(b.positionMs));
    emit(state.copyWith(notes: notes));
  }

  Future<void> deleteNote(BookNote note) async {
    await _books.deleteNote(note.id);
    emit(
      state.copyWith(
        notes: state.notes.where((item) => item.id != note.id).toList(),
      ),
    );
  }

  Future<bool> exportNotes() async {
    final book = state.book;
    if (book == null) {
      return false;
    }
    return _exports.exportNotes(book, state.notes);
  }

  Future<void> saveProgress() async {
    final book = state.book;
    if (book == null) {
      return;
    }
    _pendingProgress = (bookId: book.id, position: _audio.position);
    if (_progressWriteInFlight) {
      return;
    }
    _progressWriteInFlight = true;
    try {
      while (_pendingProgress != null) {
        final pending = _pendingProgress!;
        _pendingProgress = null;
        await _books.updateProgress(pending.bookId, pending.position);
        _lastSavedAt = DateTime.now();
      }
    } finally {
      _progressWriteInFlight = false;
    }
  }

  void _onPosition(Duration position) {
    emit(_withChapterTimeline(state.copyWith(position: position)));
    final sleepTarget = state.sleepChapterEndMs;
    if (sleepTarget != null && position.inMilliseconds >= sleepTarget) {
      unawaited(_sleepAtChapterBoundary());
    }
    if (DateTime.now().difference(_lastSavedAt) >=
        const Duration(milliseconds: 250)) {
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
    if (!playing && _wasPlaying) {
      _pausedAt = DateTime.now();
      unawaited(saveProgress());
    } else if (playing && !_wasPlaying && _pausedAt != null) {
      final pausedFor = DateTime.now().difference(_pausedAt!);
      final rewind = pausedFor >= const Duration(minutes: 10)
          ? const Duration(seconds: 20)
          : pausedFor >= const Duration(minutes: 2)
          ? const Duration(seconds: 10)
          : Duration.zero;
      if (rewind > Duration.zero) {
        unawaited(seek(state.position - rewind));
      }
      _pausedAt = null;
    }
    _wasPlaying = playing;
  }

  Duration _clamp(Duration value) {
    if (value < Duration.zero) {
      return Duration.zero;
    }
    if (state.duration > Duration.zero && value > state.duration) {
      return state.duration;
    }
    return value;
  }

  PlayerState _withChapterTimeline(PlayerState value) {
    final book = value.book;
    if (book == null) {
      return value;
    }
    final total = value.duration > Duration.zero
        ? value.duration
        : Duration(milliseconds: book.durationMs);
    final chapters = _orderedChapters(book);
    if (chapters.isEmpty) {
      return value.copyWith(
        currentChapter: null,
        currentChapterIndex: 0,
        chapterCount: 0,
        chapterStart: Duration.zero,
        chapterPosition: _bounded(value.position, total),
        chapterBufferedPosition: _bounded(value.bufferedPosition, total),
        chapterDuration: total,
        chapterTimeline: const [],
      );
    }

    final totalMs = total.inMilliseconds;
    final chapterTimeline = <PlayerChapter>[];
    for (var chapterIndex = 0; chapterIndex < chapters.length; chapterIndex++) {
      final chapterStartMs = chapters[chapterIndex].startMs
          .clamp(0, totalMs)
          .toInt();
      final chapterEndMs = chapterIndex + 1 < chapters.length
          ? chapters[chapterIndex + 1].startMs
                .clamp(chapterStartMs, totalMs)
                .toInt()
          : totalMs;
      chapterTimeline.add(
        PlayerChapter(
          index: chapterIndex,
          title: chapters[chapterIndex].title,
          start: Duration(milliseconds: chapterStartMs),
          duration: Duration(milliseconds: chapterEndMs - chapterStartMs),
        ),
      );
    }

    final positionMs = value.position.inMilliseconds;
    var index = 0;
    for (var candidate = 1; candidate < chapters.length; candidate++) {
      if (chapters[candidate].startMs > positionMs) {
        break;
      }
      index = candidate;
    }
    final declaredStartMs = chapters[index].startMs.clamp(0, totalMs).toInt();
    final startMs = index == 0 && positionMs < declaredStartMs
        ? 0
        : declaredStartMs;
    final nextStartMs = index + 1 < chapters.length
        ? chapters[index + 1].startMs.clamp(startMs, totalMs).toInt()
        : totalMs;
    final chapterStart = Duration(milliseconds: startMs);
    final chapterDuration = Duration(milliseconds: nextStartMs - startMs);
    return value.copyWith(
      currentChapter: chapters[index],
      currentChapterIndex: index,
      chapterCount: chapters.length,
      chapterStart: chapterStart,
      chapterPosition: _bounded(value.position - chapterStart, chapterDuration),
      chapterBufferedPosition: _bounded(
        value.bufferedPosition - chapterStart,
        chapterDuration,
      ),
      chapterDuration: chapterDuration,
      chapterTimeline: chapterTimeline,
    );
  }

  Duration _bounded(Duration value, Duration maximum) {
    if (value < Duration.zero) {
      return Duration.zero;
    }
    if (maximum > Duration.zero && value > maximum) {
      return maximum;
    }
    return value;
  }

  List<AudioChapter> _orderedChapters(Audiobook book) =>
      [...book.chapters]..sort((a, b) => a.startMs.compareTo(b.startMs));

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) {
      unawaited(saveProgress());
    }
  }

  @override
  Future<void> close() async {
    WidgetsBinding.instance.removeObserver(this);
    _sleepTimer?.cancel();
    await saveProgress();
    for (final subscription in _subscriptions) {
      await subscription.cancel();
    }
    return super.close();
  }
}
