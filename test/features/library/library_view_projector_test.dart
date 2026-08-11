import 'package:bookish_player/features/library/cubits/library_cubits.dart';
import 'package:bookish_player/features/library/cubits/library_state_projection.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/fixtures.dart';

void main() {
  group('Books across every listening and metadata category', () {
    late LibraryState state;

    setUp(() {
      state = LibraryState(
        books: [
          audiobookFixture(id: 'want').copyWith(
            title: 'Zebra',
            author: '',
            narrator: 'Narrator One',
            series: '',
            folder: '',
            statusOverride: .wantToListen,
            addedAt: fixtureTime.subtract(const Duration(days: 3)),
          ),
          audiobookFixture(id: 'new').copyWith(
            title: 'Alpha',
            author: 'Baker',
            series: 'Saga',
            folder: 'Shelf',
            isFavorite: true,
            addedAt: fixtureTime.subtract(const Duration(days: 2)),
          ),
          audiobookFixture(id: 'active').copyWith(
            title: 'Middle',
            author: 'Adam',
            series: 'Saga',
            folder: 'Shelf',
            positionMs: 1_000_000,
            lastPlayedAt: fixtureTime,
          ),
          audiobookFixture(id: 'done').copyWith(
            title: 'Finished',
            author: 'Baker',
            series: '',
            folder: '',
            completedAt: fixtureTime,
          ),
        ],
      );
    });

    test(
      'Given books across every listening and metadata category, When every filter and sort projection is requested, Then visible books follow typed criteria without mutating source state',
      () {
        // WHEN
        final expectedByFilter = {
          LibraryFilter.wantToListen: 'want',
          LibraryFilter.notStarted: 'new',
          LibraryFilter.inProgress: 'active',
          LibraryFilter.finished: 'done',
          LibraryFilter.favorites: 'new',
        };
        // THEN
        for (final entry in expectedByFilter.entries) {
          final projected = state.copyWith(filter: entry.key).projectView();
          expect(projected.sections.single.books.single.id, entry.value);
        }

        for (final sort in LibrarySort.values) {
          final projected = state.copyWith(sort: sort).projectView();
          expect(projected.sections.single.books, hasLength(4));
        }

        final searched = state.copyWith(query: 'narrator one').projectView();
        expect(searched.sections.single.books.single.id, 'want');
        expect(state.sections, isEmpty);
      },
    );

    test(
      'Given books across every listening and metadata category, When every cohesive grouping is requested, Then section titles remain typed and deterministic',
      () {
        // WHEN
        final listening = state
            .copyWith(grouping: LibraryGrouping.listeningStatus)
            .projectView();
        // THEN
        expect(listening.sections.map((section) => section.label).toSet(), {
          LibrarySectionLabel.wantToListen,
          LibrarySectionLabel.notStarted,
          LibrarySectionLabel.listening,
          LibrarySectionLabel.finished,
        });

        final authors = state
            .copyWith(grouping: LibraryGrouping.author)
            .projectView();
        expect(
          authors.sections.any(
            (section) => section.label == LibrarySectionLabel.unknownAuthor,
          ),
          isTrue,
        );
        expect(
          authors.sections.map((section) => section.title),
          contains('Adam'),
        );

        final series = state
            .copyWith(grouping: LibraryGrouping.series)
            .projectView();
        expect(
          series.sections.any(
            (section) => section.label == LibrarySectionLabel.noSeries,
          ),
          isTrue,
        );
        expect(
          series.sections.map((section) => section.title),
          contains('Saga'),
        );

        final folders = state
            .copyWith(grouping: LibraryGrouping.folder)
            .projectView();
        expect(
          folders.sections.any(
            (section) => section.label == LibrarySectionLabel.imported,
          ),
          isTrue,
        );
        expect(
          folders.sections.map((section) => section.title),
          contains('Shelf'),
        );
      },
    );
  });
}
