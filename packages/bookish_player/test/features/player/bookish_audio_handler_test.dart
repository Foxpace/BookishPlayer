import 'dart:async';

import 'package:bookish_player/features/player/repos/implementations/bookish_audio_handler.dart';
import 'package:bookish_player/features/library/models/library_models.dart';
import 'package:bookish_player/features/player/use_cases/playback_command_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:just_audio/just_audio.dart';

import '../../../test_support/features/player/fake_audio_player.dart';
import '../../../test_support/features/player/fake_books.dart';
import '../../../test_support/features/player/fake_settings.dart';

class _NotificationAudioPlayer extends AudioPlayer {
  _NotificationAudioPlayer(this.audio);

  final FakeAudioPlayer audio;
  final events = StreamController<PlayerEvent>.broadcast(sync: true);
  final currentEvent = PlayerEvent(
    playing: true,
    playbackEvent: PlaybackEvent(processingState: ProcessingState.ready),
  );

  @override
  Stream<PlayerEvent> get playerEventStream => events.stream;
  @override
  Stream<Duration> get positionStream => audio.positionStream;
  @override
  Stream<List<IndexedAudioSource>> get sequenceStream => const Stream.empty();
  @override
  Stream<int?> get currentIndexStream => const Stream.empty();
  @override
  PlayerEvent get playerEvent => currentEvent;
  @override
  Duration get position => audio.position;
  @override
  bool get playing => audio.isPlaying;
  @override
  ProcessingState get processingState => ProcessingState.ready;
  @override
  double get speed => audio.speed;
  @override
  List<IndexedAudioSource> get sequence => const [];
  @override
  int? get currentIndex => null;
}

void main() {
  group('Bookish audio handler', () {
    TestWidgetsFlutterBinding.ensureInitialized();

    test('Given playback advances, When position ticks arrive, Then notification progress advances once per second', () async {
      // GIVEN
      final audio = FakeAudioPlayer();
      final player = _NotificationAudioPlayer(audio);
      final books = FakeBooks(
        Audiobook(
          id: 'book',
          title: 'Book',
          filePath: '/book.mp3',
          durationMs: 30000,
          addedAt: DateTime(2026),
        ),
      );
      final handler = BookishAudioHandler(
        player,
        books,
        PlaybackCommandService(audio, books, FakeSettings()),
      );

      // WHEN
      await audio.play();
      player.events.add(player.currentEvent);
      await Future<void>.delayed(Duration.zero);
      final progress = <Duration>[];
      for (final position in const [
        Duration(milliseconds: 500),
        Duration(milliseconds: 1100),
        Duration(milliseconds: 1500),
        Duration(milliseconds: 2100),
      ]) {
        audio.emitPosition(position);
        await Future<void>.delayed(Duration.zero);
        progress.add(handler.playbackState.value.updatePosition);
      }

      // THEN
      expect(progress, const [
        Duration.zero,
        Duration(milliseconds: 1100),
        Duration(milliseconds: 1100),
        Duration(milliseconds: 2100),
      ]);

      await player.events.close();
      await audio.close();
      await player.dispose();
    });

    test('Given chapters in one audio file, When a chapter ends, Then notification navigation selects the next chapter', () {
      // GIVEN
      const chapters = [
        AudioChapter(title: 'One', startMs: 0),
        AudioChapter(title: 'Two', startMs: 30000),
        AudioChapter(title: 'Three', startMs: 60000),
      ];

      // WHEN / THEN
      expect(
        nextChapterPosition(chapters, const Duration(seconds: 30)),
        const Duration(seconds: 60),
      );
      expect(
        nextChapterPosition(chapters, const Duration(seconds: 60)),
        isNull,
      );
      expect(
        previousChapterPosition(chapters, const Duration(seconds: 31)),
        Duration.zero,
      );
      expect(
        previousChapterPosition(chapters, const Duration(seconds: 35)),
        const Duration(seconds: 30),
      );
    });

    test('Given the bookish audio handler, When its behavior is exercised, Then moves forward by 15 seconds across a chapter boundary', () {
      // WHEN
      final target = relativeSeekTarget(
        durations: const [Duration(seconds: 20), Duration(seconds: 30)],
        currentIndex: 0,
        currentPosition: const Duration(seconds: 12),
        delta: BookishAudioHandler.skipInterval,
      );

      // THEN
      expect(target.index, 1);
      expect(target.position, const Duration(seconds: 7));
    });

    test('Given the bookish audio handler, When its behavior is exercised, Then moves backward by 15 seconds across a chapter boundary', () {
      // WHEN
      final target = relativeSeekTarget(
        durations: const [Duration(seconds: 20), Duration(seconds: 30)],
        currentIndex: 1,
        currentPosition: const Duration(seconds: 4),
        delta: -BookishAudioHandler.skipInterval,
      );

      // THEN
      expect(target.index, 0);
      expect(target.position, const Duration(seconds: 9));
    });

    test('Given the bookish audio handler, When its behavior is exercised, Then clamps notification seeks at the beginning and end', () {
      // THEN
      expect(
        relativeSeekTarget(
          durations: const [Duration(seconds: 20)],
          currentIndex: 0,
          currentPosition: const Duration(seconds: 3),
          delta: -BookishAudioHandler.skipInterval,
        ).position,
        Duration.zero,
      );
      expect(
        relativeSeekTarget(
          durations: const [Duration(seconds: 20)],
          currentIndex: 0,
          currentPosition: const Duration(seconds: 18),
          delta: BookishAudioHandler.skipInterval,
        ).position,
        const Duration(seconds: 20),
      );
    });
  });
}
