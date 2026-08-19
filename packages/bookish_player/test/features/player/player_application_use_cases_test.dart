import 'package:bookish_player/core/foundation/result.dart';
import 'package:bookish_player/features/library/repos/listening_history_repository.dart';
import 'package:bookish_player/features/library/models/listening_session.dart';
import 'package:bookish_player/features/player/use_cases/listening_session_tracker.dart';
import 'package:bookish_player/features/player/models/player_open_failure.dart';
import 'package:bookish_player/features/player/models/playback_open_result.dart';
import 'package:bookish_player/features/player/use_cases/playback_command_service.dart';
import 'package:bookish_player/features/player/use_cases/sleep_timer_use_case.dart';
import 'package:bookish_player/features/settings/models/playback_preferences.dart';
import 'package:fake_async/fake_async.dart';

import '../../../test_support/support/fakes/fake_clock.dart';
import '../../../test_support/support/fakes/fake_id_generator.dart';
import '../../../test_support/support/fakes/fake_library_test_support.dart';
import '../../../test_support/support/fixtures.dart';
import '../../../test_support/features/player/player_test_support.dart';

void main() {
  group('Stateless playback sleep use case', () {
    late _VolumeAudio audio;
    late SleepTimerUseCase sut;

    setUp(() {
      audio = _VolumeAudio();
      sut = SleepTimerUseCase(audio);
    });

    test(
      'Given a stateless playback sleep use case, When an immediate timer elapses, Then volume fades, playback pauses, and completion runs',
      () {
        fakeAsync((time) {
          var elapsedCalls = 0;

          // WHEN
          sut.scheduleFixed(Duration.zero, Duration.zero, () async {
            elapsedCalls++;
          });
          time.elapse(Duration.zero);
          time.flushMicrotasks();

          // THEN
          expect(audio.volumes, hasLength(11));
          expect(audio.volumes.first, .9);
          expect(audio.volumes.last, 1);
          expect(audio.pauseCount, 1);
          expect(elapsedCalls, 1);
        });
      },
    );

    test(
      'Given a stateless playback sleep use case, When chapter boundaries and cancellation are evaluated, Then the next stable boundary is selected and cancelled work stops',
      () {
        fakeAsync((time) {
          // GIVEN
          final book = audiobookFixture().copyWith(
            durationMs: 60_000,
            chapters: const [
              AudioChapter(title: 'One', startMs: 0),
              AudioChapter(title: 'Two', startMs: 20_000),
            ],
          );

          // WHEN
          final timer = sut.scheduleChapterFallback(
            const Duration(seconds: 5),
            Duration.zero,
            () async {},
          );
          timer.cancel();
          time.elapse(const Duration(seconds: 5));
          time.flushMicrotasks();

          // THEN
          expect(sut.chapterEnd(book, const Duration(seconds: 5)), 20_000);
          expect(sut.chapterEnd(book, const Duration(seconds: 20)), 60_000);
          expect(audio.pauseCount, 0);
        });
      },
    );
  });

  group('Deterministic listening-session tracker', () {
    test(
      'Given a deterministic listening-session tracker, When short and meaningful sessions finish, Then only meaningful playback is persisted with stable metadata',
      () async {
        // GIVEN
        final history = _History();
        final clock = FakeClock(fixtureTime);
        final sut = ListeningSessionTracker(
          history,
          clock,
          FakeIdGenerator('session'),
        );

        final shortSession = sut.start(const Duration(seconds: 2));
        clock.advance(const Duration(seconds: 1));
        // WHEN
        await sut.finish(
          startedAt: shortSession.startedAt,
          startPosition: shortSession.startPosition,
          book: audiobookFixture(),
          position: const Duration(seconds: 3),
          speed: 1,
        );
        // THEN
        expect(history.sessions, isEmpty);

        final session = sut.start(const Duration(seconds: 10));
        clock.advance(const Duration(seconds: 1));
        clock.advance(const Duration(seconds: 2));
        await sut.finish(
          startedAt: session.startedAt,
          startPosition: session.startPosition,
          book: audiobookFixture(),
          position: const Duration(seconds: 15),
          speed: 1.25,
        );

        expect(history.sessions.single.id, 'session-0');
        expect(history.sessions.single.metadataId, 'metadata-1');
        expect(history.sessions.single.listenedMs, 3000);
        expect(history.sessions.single.startPositionMs, 10_000);
        expect(history.sessions.single.endPositionMs, 15_000);
        expect(history.sessions.single.speed, 1.25);

        await sut.finish(
          startedAt: null,
          startPosition: null,
          book: null,
          position: Duration.zero,
          speed: 1,
        );
        expect(history.sessions, hasLength(1));
      },
    );
  });

  group('Stateless playback command service and two local books', () {
    test(
      'Given a stateless playback command service and two local books, When explicit context and playback intents are supplied, Then audio commands and progress remain transactionally ordered',
      () async {
        // GIVEN
        final first = audiobookFixture();
        final second = audiobookFixture(id: 'book-2');
        final books = FakeBooks.withBooks([first, second]);
        final audio = _CommandAudio()
          ..currentPosition = const Duration(seconds: 12);
        final settings = FakeLibrarySettings()
          ..playback = const PlaybackPreferences(
            rewindSeconds: 20,
            forwardSeconds: 45,
            shortenSilence: true,
            voiceBoost: true,
          );
        final sut = PlaybackCommandService(audio, books, settings);
        final requestedIds = <String>[];
        final requestSubscription = sut.playRequests.listen((request) async {
          requestedIds.add(request.bookId);
          await audio.play();
          request.completion.complete();
        });

        // WHEN
        final opened = await sut.openById('book-1');
        // THEN
        expect(switch (opened) {
          ResultSuccess(:final value) => value.book.id,
          ResultFailure() => null,
        }, 'book-1');
        expect(audio.loadedIds, ['book-1']);
        expect(audio.skipIntervals.single, (20, 45));
        expect(audio.shortenSilenceValues, [true]);
        expect(audio.voiceBoostValues, [true]);

        audio.currentPosition = const Duration(seconds: 12);
        await sut.open(second, previousBook: first);
        expect(audio.pauseCount, 1);
        expect(books.progress, const Duration(seconds: 12));

        await sut.playBook('book-2');
        expect(requestedIds, ['book-2']);
        expect(audio.playing, isTrue);
        await sut.toggle();
        expect(audio.playing, isFalse);
        await sut.toggle();
        expect(audio.playing, isTrue);

        await sut.removeCurrentBook();
        expect(audio.playing, isFalse);
        await sut.reset();
        expect(audio.clearCalls, 1);

        expect(
          await sut.openById('missing'),
          const Result<PlaybackOpenResult, PlayerOpenFailure>.failure(
            PlayerOpenFailure.notFound,
          ),
        );
        await requestSubscription.cancel();
      },
    );
  });
}

class _VolumeAudio extends FakeAudioPlayer {
  final volumes = <double>[];

  @override
  Future<void> setVolume(double volume) async {
    volumes.add(volume);
  }
}

class _CommandAudio extends FakeAudioPlayer {
  final loadedIds = <String>[];
  final skipIntervals = <(int, int)>[];
  final shortenSilenceValues = <bool>[];
  final voiceBoostValues = <bool>[];
  var clearCalls = 0;

  @override
  Future<void> load(Audiobook book) async {
    loadedIds.add(book.id);
    await super.load(book);
  }

  @override
  Future<void> setSkipIntervals(Duration rewind, Duration forward) async {
    skipIntervals.add((rewind.inSeconds, forward.inSeconds));
  }

  @override
  Future<void> setShortenSilence({required bool enabled}) async {
    shortenSilenceValues.add(enabled);
  }

  @override
  Future<void> setVoiceBoost({required bool enabled}) async {
    voiceBoostValues.add(enabled);
  }

  @override
  Future<void> clear() async {
    clearCalls++;
    await super.clear();
  }
}

class _History implements ListeningHistoryRepository {
  final sessions = <ListeningSession>[];

  @override
  Future<List<ListeningSession>> getListeningSessions() async => sessions;

  @override
  Future<void> saveListeningSession(ListeningSession session) async {
    sessions.add(session);
  }
}
