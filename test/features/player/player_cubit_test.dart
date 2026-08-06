import 'dart:async';

import 'package:bookish_player/core/presentation/book_cover.dart';
import 'package:bookish_player/features/library/domain/audiobook.dart';
import 'package:bookish_player/features/library/domain/audiobook_repository.dart';
import 'package:bookish_player/features/library/domain/listening_session.dart';
import 'package:bookish_player/features/player/domain/audio_player_repository.dart';
import 'package:bookish_player/features/player/application/playback_command_service.dart';
import 'package:bookish_player/features/player/domain/book_note.dart';
import 'package:bookish_player/features/player/domain/quote_share_repository.dart';
import 'package:bookish_player/features/player/presentation/player_cubit.dart';
import 'package:bookish_player/features/player/presentation/player_state.dart';
import 'package:bookish_player/features/player/presentation/player_screen.dart';
import 'package:bookish_player/features/portability/domain/local_export_repository.dart';
import 'package:bookish_player/features/portability/domain/bookish_backup.dart';
import 'package:bookish_player/features/player/presentation/now_playing_shell.dart';
import 'package:bookish_player/features/settings/domain/playback_preferences.dart';
import 'package:bookish_player/features/settings/domain/settings_repository.dart';
import 'package:bookish_player/features/settings/domain/theme_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

part 'player_cubit_fakes.dart';
part 'player_cubit_note_tests.dart';
part 'player_cubit_widget_tests.dart';
part 'player_screen_layout_tests.dart';

PlayerCubit _createPlayerCubit(
  AudioPlayerRepository audio,
  _FakeBooks books,
  LocalExportRepository exports,
  SettingsRepository settings, [
  _FakeSharing? sharing,
]) => PlayerCubit(
  audio,
  books,
  books,
  books,
  exports,
  sharing ?? _FakeSharing(),
  PlaybackCommandService(audio, books, settings),
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  registerPlayerCubitWidgetTests();
  registerPlayerCubitNoteTests();
  registerPlayerScreenLayoutTests();

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
      final cubit = _createPlayerCubit(
        audio,
        books,
        _FakeExports(),
        _FakeSettings(),
      );
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

  test('continues with the next numbered unfinished series volume', () async {
    final first = Audiobook(
      id: 'first',
      title: 'First',
      series: 'Saga',
      seriesPosition: 1,
      filePath: '/first.mp3',
      durationMs: 60000,
      addedAt: DateTime(2025),
    );
    final second = Audiobook(
      id: 'second',
      title: 'Second',
      series: 'Saga',
      seriesPosition: 2,
      filePath: '/second.mp3',
      durationMs: 60000,
      addedAt: DateTime(2026),
    );
    final audio = _FakeAudioPlayer();
    final books = _FakeBooks.withBooks([first, second]);
    final cubit = _createPlayerCubit(
      audio,
      books,
      _FakeExports(),
      _FakeSettings(),
    );
    addTearDown(() async {
      await cubit.close();
      await audio.close();
    });
    await cubit.open(first);

    audio.emitCompleted();
    await Future<void>.delayed(const Duration(milliseconds: 20));

    expect(cubit.state.book?.id, 'second');
    expect(audio.playing, isTrue);
    final completed = await books.getBook('first');
    expect(completed?.isFinished, isTrue);
    expect(completed?.completedAt, isNotNull);
    expect(completed?.positionMs, first.durationMs);
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
    final cubit = _createPlayerCubit(
      audio,
      _FakeBooks(book),
      _FakeExports(),
      _FakeSettings(),
    );
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
    final cubit = _createPlayerCubit(
      audio,
      books,
      _FakeExports(),
      _FakeSettings(),
    );
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
}
