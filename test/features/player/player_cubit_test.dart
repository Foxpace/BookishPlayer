import 'dart:async';

import 'package:bookish_player/features/library/domain/audiobook.dart';
import 'package:bookish_player/features/library/domain/audiobook_repository.dart';
import 'package:bookish_player/features/player/domain/audio_player_repository.dart';
import 'package:bookish_player/features/player/domain/book_note.dart';
import 'package:bookish_player/features/player/presentation/player_cubit.dart';
import 'package:bookish_player/features/player/presentation/player_state.dart';
import 'package:bookish_player/features/portability/domain/local_export_repository.dart';
import 'package:bookish_player/core/presentation/now_playing_shell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  test('stores quote chapter and range metadata', () async {
    final book = Audiobook(
      id: 'book',
      title: 'Book',
      filePath: '/book.mp3',
      durationMs: 120000,
      addedAt: DateTime(2026),
    );
    final audio = _FakeAudioPlayer();
    final books = _FakeBooks(book);
    final cubit = PlayerCubit(audio, books, _FakeExports());
    addTearDown(() async {
      await cubit.close();
      await audio.close();
    });

    await cubit.open(book);
    await cubit.addNoteAt(
      'A transcribed quote',
      const Duration(seconds: 35),
      chapterTitle: 'Chapter two',
      endPosition: const Duration(seconds: 52),
    );

    expect(books.savedNote?.text, 'A transcribed quote');
    expect(books.savedNote?.positionMs, 35000);
    expect(books.savedNote?.endPositionMs, 52000);
    expect(books.savedNote?.chapterTitle, 'Chapter two');
  });

  test('chapter-relative seeks cannot cascade into later chapters', () async {
    final book = Audiobook(
      id: 'book',
      title: 'Book',
      filePath: '/book.mp3',
      durationMs: 90000,
      addedAt: DateTime(2026),
      chapters: const [
        AudioChapter(title: 'One', startMs: 0),
        AudioChapter(title: 'Two', startMs: 30000),
        AudioChapter(title: 'Three', startMs: 60000),
      ],
    );
    final audio = _FakeAudioPlayer();
    final cubit = PlayerCubit(audio, _FakeBooks(book), _FakeExports());
    addTearDown(() async {
      await cubit.close();
      await audio.close();
    });
    await cubit.open(book);

    await cubit.seekWithinChapter(const Duration(seconds: 30));
    await cubit.seekWithinChapter(const Duration(seconds: 30));

    expect(audio.currentPosition, const Duration(milliseconds: 29999));
    expect(cubit.state.currentChapterIndex, 0);
    expect(cubit.state.currentChapter?.title, 'One');
  });

  test('stops a paused current book before switching queues', () async {
    final first = Audiobook(
      id: 'first',
      title: 'First',
      filePath: '/first.mp3',
      durationMs: 60000,
      addedAt: DateTime(2026),
    );
    final second = Audiobook(
      id: 'second',
      title: 'Second',
      filePath: '/second.mp3',
      durationMs: 90000,
      addedAt: DateTime(2026),
    );
    final audio = _FakeAudioPlayer();
    final books = _FakeBooks.withBooks([first, second]);
    final cubit = PlayerCubit(audio, books, _FakeExports());
    addTearDown(() async {
      await cubit.close();
      await audio.close();
    });

    await cubit.open(first);
    expect(audio.playing, isFalse);
    expect(audio.currentPosition, Duration.zero);
    audio.currentPosition = const Duration(seconds: 12);

    await cubit.open(second);

    expect(audio.pauseCount, 1);
    expect(cubit.state.book?.id, 'second');
    expect(cubit.state.isPlaying, isFalse);
    expect(audio.currentPosition, Duration.zero);
    expect((await books.getBook('first'))?.positionMs, 12000);

    await cubit.openById('first');

    expect(cubit.state.book?.id, 'first');
    expect(audio.currentPosition, const Duration(seconds: 12));
  });

  testWidgets('shows and controls the current book outside the player', (
    tester,
  ) async {
    final book = Audiobook(
      id: 'book',
      title: 'Visible Book',
      filePath: '/book.mp3',
      durationMs: 60000,
      addedAt: DateTime(2026),
    );
    final audio = _FakeAudioPlayer();
    final cubit = PlayerCubit(audio, _FakeBooks(book), _FakeExports());
    addTearDown(() async {
      await cubit.close();
      await audio.close();
    });
    await cubit.open(book);

    await tester.pumpWidget(
      BlocProvider.value(
        value: cubit,
        child: const MaterialApp(
          home: NowPlayingShell(showMiniPlayer: true, child: SizedBox.expand()),
        ),
      ),
    );

    expect(find.text('Visible Book'), findsOneWidget);
    expect(find.text('Paused'), findsOneWidget);

    await tester.tap(find.byTooltip('Play'));
    await tester.pump();

    expect(find.byTooltip('Pause'), findsOneWidget);
    expect(find.text('Playing'), findsOneWidget);
  });
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
  _FakeBooks(this.book) : _books = {book.id: book};

  _FakeBooks.withBooks(List<Audiobook> books)
    : book = books.first,
      _books = {for (final book in books) book.id: book};

  Audiobook book;
  final Map<String, Audiobook> _books;
  Duration? progress;
  double? savedSpeed;
  BookNote? savedNote;

  @override
  Future<Audiobook?> getBook(String id) async => _books[id];
  @override
  Future<List<Audiobook>> getBooks() async => _books.values.toList();
  @override
  Future<void> saveBook(Audiobook book) async {
    this.book = book;
    _books[book.id] = book;
  }

  @override
  Future<void> updateProgress(String id, Duration position) async {
    progress = position;
    final stored = _books[id];
    if (stored != null) {
      final updated = stored.copyWith(positionMs: position.inMilliseconds);
      _books[id] = updated;
      if (book.id == id) {
        book = updated;
      }
    }
  }

  @override
  Future<void> updatePlaybackSpeed(String id, double speed) async =>
      savedSpeed = speed;
  @override
  Future<List<BookNote>> getNotes(String bookId) async => [];
  @override
  Future<List<BookNote>> getAllNotes() async => [];
  @override
  Future<void> saveNote(BookNote note) async => savedNote = note;
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
