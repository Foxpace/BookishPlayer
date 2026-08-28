import '../../../test_support/features/player/player_test_support.dart';
import '../../../test_support/features/player/player_cubit_note_tests.dart';
import '../../../test_support/features/player/player_cubit_continue_listening_tests.dart';
import '../../../test_support/features/player/player_cubit_playback_flow_tests.dart';
import '../../../test_support/features/player/player_cubit_widget_tests.dart';
import '../../../test_support/features/player/player_screen_layout_tests.dart';
import 'package:bookish_player/features/player/use_cases/playback_command_service.dart';

void main() {
  group('Player cubit', () {
    TestWidgetsFlutterBinding.ensureInitialized();
    registerPlayerCubitWidgetTests();
    registerPlayerCubitNoteTests();
    registerPlayerCubitContinueListeningTests();
    registerPlayerCubitPlaybackFlowTests();
    registerPlayerScreenLayoutTests();
    group('Player intents', () {
      late _PlayerHarness harness;

      tearDown(() => harness.close());

      test(
        'Given the player cubit, When its behavior is exercised, Then external playback requests are handled as Cubit intents',
        () async {
          // GIVEN
          final book = _book(id: 'external-book', title: 'External book');
          harness = _PlayerHarness([book]);
          final sut = harness.sut;

          // WHEN
          await harness.playBook(book.id);

          // THEN
          expect(sut.state.book?.id, book.id);
          expect(sut.state.status, PlayerStatus.ready);
          expect(harness.audio.playing, isTrue);
        },
      );

      test(
        'Given the player cubit, When its behavior is exercised, Then app data reset clears playback and the active player state',
        () async {
          // GIVEN
          final book = _book(id: 'reset-book', title: 'Reset book');
          harness = _PlayerHarness([book]);
          final sut = await harness.open(book, playing: true);

          // WHEN
          await sut.resetForAppDataRemoval();

          // THEN
          expect(sut.state, const PlayerState());
          expect(harness.audio.playing, isFalse);
          expect(harness.audio.currentPosition, Duration.zero);
        },
      );

      test(
        'Given the player cubit, When its behavior is exercised, Then continues with the next numbered unfinished series volume',
        () async {
          // GIVEN
          final first = _book(
            id: 'first',
            title: 'First',
            details: (
              durationMs: 60000,
              series: 'Saga',
              seriesPosition: 1,
              addedAt: DateTime(2025),
              chapters: const [],
            ),
          );
          final second = _book(
            id: 'second',
            title: 'Second',
            details: (
              durationMs: 60000,
              series: 'Saga',
              seriesPosition: 2,
              addedAt: DateTime(2026),
              chapters: const [],
            ),
          );
          harness = _PlayerHarness([first, second]);
          final sut = await harness.open(first);

          harness.audio.emitCompleted();
          // WHEN
          await Future<void>.delayed(const Duration(milliseconds: 20));

          // THEN
          expect(sut.state.book?.id, 'second');
          expect(harness.audio.playing, isTrue);
          final completed = await harness.books.getBook('first');
          expect(completed?.isFinished, isTrue);
          expect(completed?.completedAt, isNotNull);
          expect(completed?.positionMs, first.durationMs);
        },
      );

      test(
        'Given the player cubit, When its behavior is exercised, Then chapter-relative seeks cannot cascade into later chapters',
        () async {
          // GIVEN
          final book = _book(
            id: 'book',
            title: 'Book',
            details: (
              durationMs: 90000,
              series: '',
              seriesPosition: null,
              addedAt: null,
              chapters: const [
                AudioChapter(title: 'One', startMs: 0),
                AudioChapter(title: 'Two', startMs: 30000),
                AudioChapter(title: 'Three', startMs: 60000),
              ],
            ),
          );
          harness = _PlayerHarness([book]);
          final sut = await harness.open(book);
          await sut.seekWithinChapter(const Duration(seconds: 30));
          // WHEN
          await sut.seekWithinChapter(const Duration(seconds: 30));

          // THEN
          expect(
            harness.audio.currentPosition,
            const Duration(milliseconds: 29999),
          );
          expect(sut.state.currentChapterIndex, 0);
          expect(sut.state.currentChapter?.title, 'One');
        },
      );

      test(
        'Given a chapter boundary, When skip controls cross it, Then playback stays in the current chapter',
        () async {
          // GIVEN
          final book = _book(
            id: 'book',
            title: 'Book',
            details: (
              durationMs: 90000,
              series: '',
              seriesPosition: null,
              addedAt: null,
              chapters: const [
                AudioChapter(title: 'One', startMs: 0),
                AudioChapter(title: 'Two', startMs: 30000),
                AudioChapter(title: 'Three', startMs: 60000),
              ],
            ),
          );
          harness = _PlayerHarness([book]);
          final sut = await harness.open(book, playing: true);
          await sut.seekWithinChapter(const Duration(seconds: 20));

          // WHEN
          await sut.skipBy(const Duration(seconds: 15));
          final forwardPosition = harness.audio.currentPosition;
          final forwardChapter = sut.state.currentChapter?.title;
          final wasPlayingAfterForwardSkip = harness.audio.playing;
          await sut.seekWithinChapter(const Duration(seconds: 10));
          await sut.skipBy(const Duration(seconds: -15));

          // THEN
          expect(forwardPosition, const Duration(milliseconds: 29999));
          expect(forwardChapter, 'One');
          expect(wasPlayingAfterForwardSkip, isFalse);
          expect(harness.audio.currentPosition, Duration.zero);
          expect(sut.state.currentChapter?.title, 'One');
        },
      );

      test(
        'Given the player cubit, When its behavior is exercised, Then stops a paused current book before switching queues',
        () async {
          // GIVEN
          final first = _book(id: 'first', title: 'First');
          final second = _book(
            id: 'second',
            title: 'Second',
            details: const (
              durationMs: 90000,
              series: '',
              seriesPosition: null,
              addedAt: null,
              chapters: [],
            ),
          );
          harness = _PlayerHarness([first, second]);
          final sut = harness.sut;

          // WHEN
          await sut.open(first);
          // THEN
          expect(harness.audio.playing, isFalse);
          expect(harness.audio.currentPosition, Duration.zero);
          harness.audio.currentPosition = const Duration(seconds: 12);

          await sut.open(second);

          expect(harness.audio.pauseCount, 1);
          expect(sut.state.book?.id, 'second');
          expect(sut.state.isPlaying, isFalse);
          expect(harness.audio.currentPosition, Duration.zero);
          expect((await harness.books.getBook('first'))?.positionMs, 12000);

          await sut.openById('first');

          expect(sut.state.book?.id, 'first');
          expect(harness.audio.currentPosition, const Duration(seconds: 12));
        },
      );

      test(
        'Given active playback, When playback is paused explicitly, Then audio stops without toggling it back on',
        () async {
          // GIVEN
          final book = _book(id: 'book', title: 'Book');
          harness = _PlayerHarness([book]);
          final sut = await harness.open(book, playing: true);

          // WHEN
          await sut.pausePlayback();
          await sut.pausePlayback();

          // THEN
          expect(harness.audio.playing, isFalse);
          expect(harness.audio.pauseCount, 2);
        },
      );
    });
  });
}

final class _PlayerHarness {
  _PlayerHarness(List<Audiobook> availableBooks)
    : audio = FakeAudioPlayer(),
      books = FakeBooks.withBooks(availableBooks) {
    final created = createPlayerCubitHarness(
      audio,
      books,
      FakeExports(),
      FakeSettings(),
    );
    sut = created.sut;
    _commands = created.commands;
  }

  final FakeAudioPlayer audio;
  final FakeBooks books;
  late final PlayerCubit sut;
  late final PlaybackCommandService _commands;

  Future<void> playBook(String bookId) => _commands.playBook(bookId);

  Future<PlayerCubit> open(Audiobook book, {bool playing = false}) async {
    await sut.open(book);
    if (playing) {
      await sut.togglePlayback();
    }
    return sut;
  }

  Future<void> close() async {
    await sut.close();
    await audio.close();
  }
}

Audiobook _book({
  required String id,
  required String title,
  ({
    int durationMs,
    String series,
    double? seriesPosition,
    DateTime? addedAt,
    List<AudioChapter> chapters,
  })
  details = const (
    durationMs: 60000,
    series: '',
    seriesPosition: null,
    addedAt: null,
    chapters: [],
  ),
}) => Audiobook(
  id: id,
  title: title,
  series: details.series,
  seriesPosition: details.seriesPosition,
  filePath: '/$id.mp3',
  durationMs: details.durationMs,
  addedAt: details.addedAt ?? DateTime(2026),
  chapters: details.chapters,
);
