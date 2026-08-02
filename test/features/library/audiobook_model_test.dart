import 'package:bookish_player/features/library/domain/audiobook.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('migrates legacy books and computes listening status', () {
    final book = Audiobook.fromJson({
      'id': 'legacy',
      'title': 'Legacy Book',
      'filePath': '/book.mp3',
      'durationMs': 100000,
      'positionMs': 50000,
      'addedAt': '2026-01-01T00:00:00.000Z',
    });

    expect(book.playbackSpeed, 1.0);
    expect(book.author, isEmpty);
    expect(book.tracks, isEmpty);
    expect(book.playableTracks, hasLength(1));
    expect(book.listeningStatus, ListeningStatus.inProgress);
  });

  test('orders multi-file tracks by persisted order', () {
    final book = Audiobook(
      id: 'multi',
      title: 'Multi',
      filePath: '/part1.mp3',
      durationMs: 20,
      addedAt: DateTime(2026),
      tracks: const [
        AudioTrack(
          id: '2',
          title: 'Part 2',
          filePath: '/part2.mp3',
          durationMs: 10,
          order: 1,
        ),
        AudioTrack(
          id: '1',
          title: 'Part 1',
          filePath: '/part1.mp3',
          durationMs: 10,
          order: 0,
        ),
      ],
    );

    expect(book.playableTracks.map((track) => track.id), ['1', '2']);
  });
}
