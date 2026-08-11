import 'player_test_support.dart';

void registerPlayerCubitPlaybackFlowTests() {
  group('Playback flow', () {
    group('Opening a book', () {
      late _PlaybackFlowHarness harness;

      setUp(() => harness = _PlaybackFlowHarness());
      tearDown(() => harness.close());

      test(
        'Given a saved speed, When a book opens, Then speed and chapters are restored',
        () async {
          // WHEN
          await harness.open();

          // THEN
          expect(harness.sut.state.speed, 1.5);
          expect(harness.audio.speed, 1.5);
          expect(harness.sut.state.chapterTimeline, hasLength(2));
        },
      );
    });

    group('Open book', () {
      late _PlaybackFlowHarness harness;

      setUp(() async => harness = await _PlaybackFlowHarness.opened());
      tearDown(() => harness.close());

      test(
        'Given an open book, When speed and position change, Then both are persisted',
        () async {
          // WHEN
          await harness.changeSpeedAndEmitPosition();

          // THEN
          expect(harness.books.savedSpeed, 1.75);
          expect(harness.books.progress, _checkpoint);
          expect(harness.sut.state.chapterPosition, _checkpoint);
        },
      );

      test(
        'Given an open chapter, When its end-sleep boundary is reached, Then playback pauses in the next chapter',
        () async {
          // WHEN
          await harness.reachEndOfChapter();

          // THEN
          expect(harness.audio.pauseCount, 1);
          expect(harness.sut.state.sleepTimerType, isNull);
          expect(harness.sut.state.currentChapter?.title, 'Two');
        },
      );

      test(
        'Given an open book, When chapter navigation is requested, Then seeks stay chapter-relative',
        () async {
          // WHEN
          final positions = await harness.navigateChapters();

          // THEN
          expect(positions, [Duration.zero, const Duration(seconds: 60)]);
        },
      );
    });
  });
}

final class _PlaybackFlowHarness {
  _PlaybackFlowHarness() : audio = FakeAudioPlayer(), books = FakeBooks(_book) {
    sut = createPlayerCubit(audio, books, FakeExports(), FakeSettings());
  }

  static Future<_PlaybackFlowHarness> opened() async {
    final harness = _PlaybackFlowHarness();
    await harness.open();
    return harness;
  }

  final FakeAudioPlayer audio;
  final FakeBooks books;
  late final PlayerCubit sut;

  Future<void> open() => sut.open(_book);

  Future<void> changeSpeedAndEmitPosition() async {
    await sut.changeSpeed(1.75);
    audio.emitPosition(_checkpoint);
    await Future<void>.delayed(const Duration(milliseconds: 350));
  }

  Future<void> reachEndOfChapter() async {
    sut.sleepAtEndOfChapter();
    audio.emitPosition(const Duration(seconds: 60));
    await Future<void>.delayed(Duration.zero);
  }

  Future<List<Duration>> navigateChapters() async {
    await sut.seekWithinChapter(const Duration(seconds: 30));
    await sut.previousChapter();
    final previous = audio.currentPosition;
    await sut.nextChapter();
    return [previous, audio.currentPosition];
  }

  Future<void> close() async {
    await sut.close();
    await audio.close();
  }
}

final _book = Audiobook(
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

const _checkpoint = Duration(seconds: 12, milliseconds: 345);
