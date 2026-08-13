import 'package:bookish_player/features/library/models/library_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Audiobook model', () {
    test(
      'Given the audiobook model, When its behavior is exercised, Then migrates legacy books and computes listening status',
      () {
        // WHEN
        final sut = Audiobook.fromJson({
          'id': 'legacy',
          'title': 'Legacy Book',
          'filePath': '/book.mp3',
          'durationMs': 100000,
          'positionMs': 50000,
          'addedAt': '2026-01-01T00:00:00.000Z',
        });

        // THEN
        expect(sut.playbackSpeed, 1.0);
        expect(sut.isFavorite, isFalse);
        expect(sut.statusOverride, isNull);
        expect(sut.seriesPosition, isNull);
        expect(sut.author, isEmpty);
        expect(sut.tracks, isEmpty);
        expect(sut.playableTracks, hasLength(1));
        expect(sut.listeningStatus, ListeningStatus.inProgress);
      },
    );

    test(
      'Given the audiobook model, When its behavior is exercised, Then explicit shelf status and remaining time are honored',
      () {
        // WHEN
        final sut = Audiobook(
          id: 'planned',
          title: 'Planned Book',
          filePath: '/book.mp3',
          durationMs: 120000,
          positionMs: 60000,
          playbackSpeed: 2,
          addedAt: DateTime(2026),
          statusOverride: ListeningStatus.wantToListen,
          isFavorite: true,
          seriesPosition: 2.5,
        );

        // THEN
        expect(sut.listeningStatus, ListeningStatus.wantToListen);
        expect(sut.remainingDuration, const Duration(minutes: 1));
        expect(Audiobook.fromJson(sut.toJson()), sut);
      },
    );

    test(
      'Given the audiobook model, When its behavior is exercised, Then a recorded completion marks the book as finished',
      () {
        // WHEN
        final sut = Audiobook(
          id: 'completed',
          title: 'Completed Book',
          filePath: '/book.mp3',
          durationMs: 120000,
          addedAt: DateTime(2026),
          completedAt: DateTime(2026, 2),
        );

        // THEN
        expect(sut.listeningStatus, ListeningStatus.finished);
        expect(sut.isFinished, isTrue);
      },
    );

    test(
      'Given the audiobook model, When its behavior is exercised, Then orders multi-file tracks by persisted order',
      () {
        // WHEN
        final sut = Audiobook(
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

        // THEN
        expect(sut.playableTracks.map((track) => track.id), ['1', '2']);
      },
    );
  });
}
