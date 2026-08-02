import 'dart:async';

import 'package:bookish_player/features/library/domain/audiobook.dart';
import 'package:bookish_player/features/library/domain/audiobook_repository.dart';
import 'package:bookish_player/features/player/domain/audio_player_repository.dart';
import 'package:bookish_player/features/player/domain/book_note.dart';
import 'package:bookish_player/features/player/presentation/player_cubit.dart';
import 'package:bookish_player/features/player/presentation/player_state.dart';
import 'package:bookish_player/features/portability/domain/local_export_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'restores speed, checkpoints progress, and sleeps at chapter end',
    () async {
      final book = Audiobook(
        id: 'book',
        title: 'Book',
        filePath: '/book.mp3',
        durationMs: 120000,
        addedAt: DateTime(2026),
        playbackSpeed: 1.5,
        chapters: const [
          AudioChapter(title: 'One', startMs: 0),
          AudioChapter(title: 'Two', startMs: 60000),
        ],
      );
      final audio = _FakeAudioPlayer();
      final books = _FakeBooks(book);
      final cubit = PlayerCubit(audio, books, _FakeExports());
      addTearDown(() async {
        await cubit.close();
        await audio.close();
      });

      await cubit.open(book);
      expect(cubit.state.speed, 1.5);
      expect(audio.speed, 1.5);
      expect(cubit.state.currentChapter?.title, 'One');
      expect(cubit.state.chapterDuration, const Duration(seconds: 60));
      expect(cubit.state.chapterTimeline, hasLength(2));
      expect(
        cubit.state.chapterTimeline.map((chapter) => chapter.duration),
        everyElement(const Duration(seconds: 60)),
      );

      await cubit.changeSpeed(1.75);
      expect(books.savedSpeed, 1.75);

      audio.emitPosition(const Duration(seconds: 12, milliseconds: 345));
      await Future<void>.delayed(const Duration(milliseconds: 350));
      expect(books.progress, const Duration(seconds: 12, milliseconds: 345));
      expect(
        cubit.state.chapterPosition,
        const Duration(seconds: 12, milliseconds: 345),
      );

      await cubit.seekWithinChapter(const Duration(seconds: 30));
      expect(audio.currentPosition, const Duration(seconds: 30));
      await cubit.previousChapter();
      expect(audio.currentPosition, Duration.zero);
      await cubit.nextChapter();
      expect(audio.currentPosition, const Duration(seconds: 60));
      await cubit.previousChapter();
      expect(audio.currentPosition, Duration.zero);
      audio.emitPosition(const Duration(seconds: 12, milliseconds: 345));

      cubit.sleepAtEndOfChapter();
      expect(cubit.state.sleepTimerType, SleepTimerType.endOfChapter);
      audio.emitPosition(const Duration(seconds: 60));
      await Future<void>.delayed(Duration.zero);
      expect(audio.pauseCount, 1);
      expect(cubit.state.sleepTimerType, isNull);
      expect(cubit.state.currentChapter?.title, 'Two');
      expect(cubit.state.chapterPosition, Duration.zero);

      await cubit.seekWithinChapter(const Duration(seconds: 5));
      expect(audio.currentPosition, const Duration(seconds: 65));
    },
  );
}

class _FakeAudioPlayer implements AudioPlayerRepository {
  final _positions = StreamController<Duration>.broadcast();
  final _buffers = StreamController<Duration>.broadcast();
  final _durations = StreamController<Duration?>.broadcast();
  final _playing = StreamController<bool>.broadcast();
  final _completed = StreamController<bool>.broadcast();
  Duration currentPosition = Duration.zero;
  var speed = 1.0;
  var playing = false;
  var pauseCount = 0;

  void emitPosition(Duration value) {
    currentPosition = value;
    _positions.add(value);
  }

  Future<void> close() async {
    await _positions.close();
    await _buffers.close();
    await _durations.close();
    await _playing.close();
    await _completed.close();
  }

  @override
  Stream<Duration> get positionStream => _positions.stream;
  @override
  Stream<Duration> get bufferedPositionStream => _buffers.stream;
  @override
  Stream<Duration?> get durationStream => _durations.stream;
  @override
  Stream<bool> get playingStream => _playing.stream;
  @override
  Stream<bool> get completedStream => _completed.stream;
  @override
  Duration get position => currentPosition;
  @override
  bool get isPlaying => playing;
  @override
  Future<Duration> probeDuration(String path) async => Duration.zero;
  @override
  Future<void> load(Audiobook book) async {
    currentPosition = Duration(milliseconds: book.positionMs);
  }

  @override
  Future<void> play() async {
    playing = true;
    _playing.add(true);
  }

  @override
  Future<void> pause() async {
    pauseCount++;
    playing = false;
    _playing.add(false);
  }

  @override
  Future<void> seek(Duration position) async {
    currentPosition = position;
  }

  @override
  Future<void> setSpeed(double speed) async {
    this.speed = speed;
  }

  @override
  Future<void> dispose() async {}
}

class _FakeBooks implements AudiobookRepository {
  _FakeBooks(this.book);
  Audiobook book;
  Duration? progress;
  double? savedSpeed;

  @override
  Future<Audiobook?> getBook(String id) async => book;
  @override
  Future<List<Audiobook>> getBooks() async => [book];
  @override
  Future<void> saveBook(Audiobook book) async => this.book = book;
  @override
  Future<void> updateProgress(String id, Duration position) async =>
      progress = position;
  @override
  Future<void> updatePlaybackSpeed(String id, double speed) async =>
      savedSpeed = speed;
  @override
  Future<List<BookNote>> getNotes(String bookId) async => [];
  @override
  Future<List<BookNote>> getAllNotes() async => [];
  @override
  Future<void> saveNote(BookNote note) async {}
  @override
  Future<void> deleteNote(String id) async {}
  @override
  Future<void> deleteBook(String id) async {}
  @override
  Future<void> replaceLibrary(
    List<Audiobook> books,
    List<BookNote> notes,
  ) async {}
}

class _FakeExports implements LocalExportRepository {
  @override
  Future<bool> exportBackup(Map<String, dynamic> backup) async => true;
  @override
  Future<bool> exportNotes(Audiobook book, List<BookNote> notes) async => true;
  @override
  Future<Map<String, dynamic>?> pickBackup() async => null;
}
