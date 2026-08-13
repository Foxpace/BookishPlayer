import 'package:audio_service/audio_service.dart';
import 'package:bookish_player/features/player/repos/implementations/player_audio_repository.dart';
import 'package:bookish_player/features/library/models/library_models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:just_audio/just_audio.dart';

class _RecordingAudioHandler extends BaseAudioHandler {
  var playCount = 0;
  var pauseCount = 0;

  @override
  Future<void> play() async {
    playCount++;
  }

  @override
  Future<void> pause() async {
    pauseCount++;
  }
}

void main() {
  group('Just audio player repository', () {
    TestWidgetsFlutterBinding.ensureInitialized();

    test(
      'Given the just audio player repository, When its behavior is exercised, Then routes playback commands through the audio service handler',
      () async {
        // GIVEN
        final sut = JustAudioPlayerRepository(AudioPlayer());
        final handler = _RecordingAudioHandler();
        sut.attachAudioHandler(handler);

        await sut.play();
        // WHEN
        await sut.pause();

        // THEN
        expect(handler.playCount, 1);
        expect(handler.pauseCount, 1);
      },
    );

    test(
      'Given the just audio player repository, When its behavior is exercised, Then duration probes always provide background audio metadata',
      () {
        // WHEN
        final item = durationProbeMediaItem(
          '/storage/emulated/0/Example Book.m4b',
        );

        // THEN
        expect(item, isA<MediaItem>());
        expect(item.id, contains('Example%20Book.m4b'));
        expect(item.title, 'Example Book');
      },
    );

    test(
      'Given the just audio player repository, When its behavior is exercised, Then splits a single-file audiobook into chapter notification items',
      () {
        // WHEN
        final segments = Audiobook(
          id: 'book',
          title: 'Book',
          filePath: '/book.m4b',
          durationMs: 90000,
          addedAt: DateTime(2026),
          chapters: const [
            AudioChapter(title: 'Opening', startMs: 0),
            AudioChapter(title: 'The road', startMs: 20000),
            AudioChapter(title: 'Home', startMs: 65000),
          ],
        ).playbackSegments;

        // THEN
        expect(segments.map((segment) => segment.title), [
          'Opening',
          'The road',
          'Home',
        ]);
        expect(segments.map((segment) => segment.globalStartMs), [
          0,
          20000,
          65000,
        ]);
        expect(segments.map((segment) => segment.sourceStartMs), [
          0,
          20000,
          65000,
        ]);
        expect(segments.map((segment) => segment.durationMs), [
          20000,
          45000,
          25000,
        ]);
      },
    );

    test(
      'Given the just audio player repository, When its behavior is exercised, Then clips chapter ranges correctly across physical audio tracks',
      () {
        // WHEN
        final segments = Audiobook(
          id: 'book',
          title: 'Book',
          filePath: '/part-1.mp3',
          durationMs: 100000,
          addedAt: DateTime(2026),
          tracks: const [
            AudioTrack(
              id: 'part-1',
              title: 'Part 1',
              filePath: '/part-1.mp3',
              durationMs: 40000,
              order: 0,
            ),
            AudioTrack(
              id: 'part-2',
              title: 'Part 2',
              filePath: '/part-2.mp3',
              durationMs: 60000,
              order: 1,
            ),
          ],
          chapters: const [
            AudioChapter(title: 'One', startMs: 0),
            AudioChapter(title: 'Two', startMs: 30000),
            AudioChapter(title: 'Three', startMs: 70000),
          ],
        ).playbackSegments;

        // THEN
        expect(segments.map((segment) => segment.title), [
          'One',
          'Two',
          'Two',
          'Three',
        ]);
        expect(segments.map((segment) => segment.globalStartMs), [
          0,
          30000,
          40000,
          70000,
        ]);
        expect(segments.map((segment) => segment.sourceStartMs), [
          0,
          30000,
          0,
          30000,
        ]);
        expect(segments.map((segment) => segment.durationMs), [
          30000,
          10000,
          30000,
          30000,
        ]);
      },
    );
  });
}
