import 'package:bookish_player/core/localization/generated/l10n.dart';
import 'package:bookish_player/core/navigation/app_router.dart';
import 'package:bookish_player/core/navigation/focus_navigation.dart';
import 'package:bookish_player/features/library/cubits/library_intents.dart';
import 'package:bookish_player/features/library/models/library_models.dart';
import 'package:bookish_player/features/library/cubits/library_cubit.dart';
import 'package:bookish_player/features/library/ui/library_screen.dart';
import 'package:bookish_player/features/library/cubits/library_cubits.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../test_support/support/fakes/fake_library_test_support.dart';
import '../../../test_support/features/library/library_screen_robot.dart';
import '../../../test_support/features/library/library_test_builder.dart';

void main() {
  group('Library cubit', () {
    late FakeLibrarySettings settings;
    late FakeLibraryBooks books;
    late LibraryCubit sut;

    setUp(() {
      settings = FakeLibrarySettings();
      books = FakeLibraryBooks();
      sut = _createLibraryCubit(books, settings);
    });

    tearDown(() => sut.close());

    test(
      'Given the library cubit, When its behavior is exercised, Then library layout is an intent-backed persisted state value',
      () async {
        // WHEN
        await sut.setLayout(LibraryLayout.grid);

        // THEN
        expect(sut.state.layout, LibraryLayout.grid);
        expect(settings.layout, 'grid');
      },
    );

    test(
      'Given the library cubit, When its behavior is exercised, Then search, filters, sorting, favorites, and shelf status compose',
      () async {
        // GIVEN
        books.books = _searchableBooks();
        final [alpha, beta] = books.books;
        await sut.load();

        // WHEN
        sut.setQuery('writer');
        // THEN
        expect(sut.state.sections.single.books.single.id, 'a');
        sut.setQuery('');
        await sut.toggleFavorite(beta);
        sut.setFilter(LibraryFilter.favorites);
        expect(sut.state.sections.single.books.single.id, 'b');
        await sut.setListeningStatus(beta, ListeningStatus.wantToListen);
        sut.setFilter(LibraryFilter.wantToListen);
        expect(sut.state.sections.single.books.single.id, 'b');
        sut.setFilter(LibraryFilter.all);
        sut.setSort(LibrarySort.title);
        expect(sut.state.sections.single.books.map((book) => book.id), [
          'a',
          'b',
        ]);
      },
    );

    testWidgets(
      'Given the library cubit, When its behavior is exercised, Then finished books are labelled in the library',
      (tester) async {
        final robot = LibraryScreenRobot(tester);

        // GIVEN
        books.books = [
          _book(
            id: 'finished',
            title: 'Done',
            progress: (
              durationMs: 60000,
              positionMs: 0,
              isFinished: true,
              addedAt: null,
            ),
          ),
        ];
        await sut.load();

        // WHEN
        await tester.pumpWidget(
          BlocProvider.value(
            value: sut,
            child: MaterialApp(
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              home: _libraryScreen(sut),
            ),
          ),
        );

        // THEN
        robot.expectFinishedBook(
          finishedLabel: 'Finished book',
          remainingText: 'left',
        );
      },
    );

    testWidgets(
      'Given the library cubit, When its behavior is exercised, Then search stays unfocused after returning from the player',
      (tester) async {
        final robot = LibraryScreenRobot(tester);

        // GIVEN
        books.books = [_book(id: 'focused-search', title: 'Focus test')];
        await sut.load();
        final router = _focusRouter(sut);
        addTearDown(router.dispose);

        await tester.pumpWidget(
          BlocProvider.value(
            value: sut,
            child: MaterialApp.router(
              routerConfig: router,
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
            ),
          ),
        );

        // WHEN
        await robot.search('Focus');
        // THEN
        robot.expectSearchFocused();

        await robot.openBook('Focus test');
        router.pop();
        await tester.pumpAndSettle();

        robot.expectSearchUnfocused();
      },
    );
  });
}

List<Audiobook> _searchableBooks() => [
  _book(
    id: 'a',
    title: 'Alpha',
    author: 'Writer',
    progress: (
      durationMs: 100,
      positionMs: 50,
      isFinished: false,
      addedAt: DateTime(2026),
    ),
  ),
  _book(
    id: 'b',
    title: 'Beta',
    author: 'Other',
    progress: (
      durationMs: 200,
      positionMs: 0,
      isFinished: false,
      addedAt: DateTime(2025),
    ),
  ),
];

Audiobook _book({
  required String id,
  required String title,
  String author = '',
  ({int durationMs, int positionMs, bool isFinished, DateTime? addedAt})
  progress = const (
    durationMs: 60000,
    positionMs: 0,
    isFinished: false,
    addedAt: null,
  ),
}) => Audiobook(
  id: id,
  title: title,
  author: author,
  filePath: '/$id.mp3',
  durationMs: progress.durationMs,
  positionMs: progress.isFinished ? progress.durationMs : progress.positionMs,
  artworkScanned: true,
  addedAt: progress.addedAt ?? DateTime(2026),
);

GoRouter _focusRouter(LibraryCubit sut) => GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, _) => _libraryScreen(
        sut,
        onOpenBook: (book) async {
          await context.pushNamed<void>(
            AppRoutes.player,
            pathParameters: {'bookId': book.id},
          );
          dismissRestoredRouteFocus();
        },
      ),
    ),
    GoRoute(
      path: '/player/:bookId',
      name: AppRoutes.player,
      builder: (_, _) => const Scaffold(body: Text('Player')),
    ),
  ],
);

LibraryScreen _libraryScreen(
  LibraryCubit cubit, {
  ValueChanged<Audiobook>? onOpenBook,
}) {
  return LibraryScreen(
    state: cubit.state,
    intents: (
      importBooks: () {},
      openNotes: () {},
      openSettings: () {},
      queryChanged: cubit.setQuery,
      openView: () {},
      openBook: onOpenBook ?? (_) {},
      removeBook: (_) {},
      bookAction: (_, BookAction _) {},
    ),
  );
}

LibraryCubit _createLibraryCubit(
  FakeLibraryBooks books,
  FakeLibrarySettings settings,
) {
  final files = FakeLibraryFiles();
  final artwork = FakeLibraryArtwork();
  return createLibraryCubit(
    books: books,
    settings: settings,
    artwork: artwork,
    files: files,
  );
}
