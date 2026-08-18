import 'package:bookish_player/features/library/cubits/library_cubit.dart';
import 'package:bookish_player/features/library/cubits/library_intents.dart';
import 'package:bookish_player/features/library/ui/library_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_support/support/fakes/fake_library_test_support.dart';
import '../../../test_support/support/fixtures.dart';
import '../../../test_support/support/pump_bookish_app.dart';
import '../../../test_support/features/library/library_test_builder.dart';

void main() {
  group('Audiobook library presentation', () {
    late FakeLibraryBooks books;
    late LibraryCubit sut;

    setUp(() {
      books = FakeLibraryBooks();
      sut = _createCubit(books);
    });

    tearDown(() => sut.close());

    testWidgets(
      'Given the audiobook library presentation, When an empty library is shown in light English, Then it matches the approved golden',
      (tester) async {
        // WHEN
        await sut.load();
        await _pumpLibrary(tester, sut);

        // THEN
        await expectLater(
          find.byType(LibraryScreen),
          matchesGoldenFile('goldens/library_empty_light_en.png'),
        );
      },
    );

    testWidgets(
      'Given the audiobook library presentation, When a populated library is shown in dark Slovak, Then it matches the approved golden',
      (tester) async {
        // GIVEN
        books.books = [
          audiobookFixture().copyWith(
            title: 'Ľavá ruka tmy',
            author: 'Ursula K. Le Guin',
            positionMs: 900000,
            isFavorite: true,
          ),
          audiobookFixture(id: 'book-2', metadataId: 'metadata-2').copyWith(
            title: 'Solaris',
            author: 'Stanisław Lem',
            addedAt: fixtureTime.subtract(const Duration(days: 2)),
          ),
        ];

        // WHEN
        await sut.load();
        await _pumpLibrary(
          tester,
          sut,
          themeMode: ThemeMode.dark,
          locale: const Locale('sk'),
        );

        // THEN
        await expectLater(
          find.byType(LibraryScreen),
          matchesGoldenFile('goldens/library_populated_dark_sk.png'),
        );
      },
    );
  });
}

LibraryCubit _createCubit(FakeLibraryBooks books) {
  return createLibraryCubit(
    books: books,
    settings: FakeLibrarySettings(),
    artwork: FakeLibraryArtwork(),
    files: FakeLibraryFiles(),
  );
}

Future<void> _pumpLibrary(
  WidgetTester tester,
  LibraryCubit cubit, {
  ThemeMode themeMode = ThemeMode.light,
  Locale locale = const Locale('en'),
}) => tester.pumpBookishApp(
  display: (
    themeMode: themeMode,
    locale: locale,
    viewport: const Size(390, 844),
    textScale: 1,
  ),
  blocProviders: [(child) => BlocProvider.value(value: cubit, child: child)],
  child: LibraryScreen(
    state: cubit.state,
    intents: (
      importBooks: () {},
      openNotes: () {},
      openSettings: () {},
      queryChanged: cubit.setQuery,
      openView: () {},
      openBook: (_) {},
      removeBook: (_) {},
      bookAction: (_, BookAction _) {},
    ),
  ),
);
