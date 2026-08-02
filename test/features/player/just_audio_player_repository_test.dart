import 'package:audio_service/audio_service.dart';
import 'package:bookish_player/features/player/data/just_audio_player_repository.dart';
import 'package:bookish_player/features/library/domain/audiobook.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('duration probes always provide background audio metadata', () {
    final item = durationProbeMediaItem('/storage/emulated/0/Example Book.m4b');

    expect(item, isA<MediaItem>());
    expect(item.id, contains('Example%20Book.m4b'));
    expect(item.title, 'Example Book');
  });

  test('splits a single-file audiobook into chapter notification items', () {
    final segments = buildPlaybackSegments(
      Audiobook(
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
      ),
    );

    expect(segments.map((segment) => segment.title), [
      'Opening',
      'The road',
      'Home',
    ]);
    expect(segments.map((segment) => segment.globalStartMs), [0, 20000, 65000]);
    expect(segments.map((segment) => segment.sourceStartMs), [0, 20000, 65000]);
    expect(segments.map((segment) => segment.durationMs), [
      20000,
      45000,
      25000,
    ]);
  });

  test('clips chapter ranges correctly across physical audio tracks', () {
    final segments = buildPlaybackSegments(
      Audiobook(
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
      ),
    );

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
  });
}
