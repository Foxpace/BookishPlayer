import 'package:bookish_player/core/localization/generated/l10n.dart';
import 'package:bookish_player/core/navigation/app_router.dart';
import 'package:bookish_player/features/importing/domain/audiobook_artwork_extractor.dart';
import 'package:bookish_player/features/importing/domain/file_import_repository.dart';
import 'package:bookish_player/features/library/domain/audiobook_repository.dart';
import 'package:bookish_player/features/library/domain/audiobook.dart';
import 'package:bookish_player/features/library/presentation/library_cubit.dart';
import 'package:bookish_player/features/library/presentation/library_screen.dart';
import 'package:bookish_player/features/library/presentation/library_state.dart';
import 'package:bookish_player/features/settings/domain/settings_repository.dart';
import 'package:bookish_player/features/settings/domain/playback_preferences.dart';
import 'package:bookish_player/features/settings/domain/theme_preference.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

void main() {
  test('library layout is an intent-backed persisted state value', () async {
    final settings = _Settings();
    final cubit = LibraryCubit(_Books(), _Files(), _Artwork(), settings);
    addTearDown(cubit.close);

    await cubit.setLayout(LibraryLayout.grid);

    expect(cubit.state.layout, LibraryLayout.grid);
    expect(settings.layout, 'grid');
  });

  test(
    'search, filters, sorting, favorites, and shelf status compose',
    () async {
      final alpha = Audiobook(
        id: 'a',
        title: 'Alpha',
        author: 'Writer',
        filePath: '/alpha.mp3',
        durationMs: 100,
        positionMs: 50,
        artworkScanned: true,
        addedAt: DateTime(2026),
      );
      final beta = Audiobook(
        id: 'b',
        title: 'Beta',
        author: 'Other',
        filePath: '/beta.mp3',
        durationMs: 200,
        artworkScanned: true,
        addedAt: DateTime(2025),
      );
      final books = _Books([alpha, beta]);
      final cubit = LibraryCubit(books, _Files(), _Artwork(), _Settings());
      addTearDown(cubit.close);
      await cubit.load();

      cubit.setQuery('writer');
      expect(cubit.state.sections.single.books.single.id, 'a');
      cubit.setQuery('');
      await cubit.toggleFavorite(beta);
      cubit.setFilter(LibraryFilter.favorites);
      expect(cubit.state.sections.single.books.single.id, 'b');
      await cubit.setListeningStatus(beta, ListeningStatus.wantToListen);
      cubit.setFilter(LibraryFilter.wantToListen);
      expect(cubit.state.sections.single.books.single.id, 'b');
      cubit.setFilter(LibraryFilter.all);
      cubit.setSort(LibrarySort.title);
      expect(cubit.state.sections.single.books.map((book) => book.id), [
        'a',
        'b',
      ]);
    },
  );

  testWidgets('finished books are labelled in the library', (tester) async {
    final finished = Audiobook(
      id: 'finished',
      title: 'Done',
      filePath: '/done.mp3',
      durationMs: 60000,
      positionMs: 60000,
      artworkScanned: true,
      addedAt: DateTime(2026),
    );
    final cubit = LibraryCubit(
      _Books([finished]),
      _Files(),
      _Artwork(),
      _Settings(),
    );
    addTearDown(cubit.close);
    await cubit.load();

    await tester.pumpWidget(
      BlocProvider.value(
        value: cubit,
        child: MaterialApp(
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          home: const LibraryScreen(),
        ),
      ),
    );

    expect(find.text('Finished book'), findsOneWidget);
    expect(find.textContaining('left'), findsNothing);
  });

  testWidgets('search stays unfocused after returning from the player', (
    tester,
  ) async {
    final book = Audiobook(
      id: 'focused-search',
      title: 'Focus test',
      filePath: '/focus.mp3',
      durationMs: 60000,
      artworkScanned: true,
      addedAt: DateTime(2026),
    );
    final cubit = LibraryCubit(
      _Books([book]),
      _Files(),
      _Artwork(),
      _Settings(),
    );
    addTearDown(cubit.close);
    await cubit.load();

    final router = GoRouter(
      routes: [
        GoRoute(path: '/', builder: (_, _) => const LibraryScreen()),
        GoRoute(
          path: '/player/:bookId',
          name: AppRoutes.player,
          builder: (_, _) => const Scaffold(body: Text('Player')),
        ),
      ],
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      BlocProvider.value(
        value: cubit,
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

    await tester.enterText(find.byType(SearchBar), 'Focus');
    expect(
      tester.widget<EditableText>(find.byType(EditableText)).focusNode.hasFocus,
      isTrue,
    );

    await tester.tap(find.text('Focus test'));
    await tester.pumpAndSettle();
    router.pop();
    await tester.pumpAndSettle();

    expect(find.byType(SearchBar), findsOneWidget);
    expect(
      tester.widget<EditableText>(find.byType(EditableText)).focusNode.hasFocus,
      isFalse,
    );
  });
}

class _Settings implements SettingsRepository {
  String? layout;

  @override
  Future<String?> getLibraryLayout() async => layout;

  @override
  Future<void> setLibraryLayout(String layout) async {
    this.layout = layout;
  }

  @override
  Future<ThemePreference> getThemePreference() async => ThemePreference.system;

  @override
  Future<void> setThemePreference(ThemePreference preference) async {}

  @override
  Future<String?> getSpeechModel() async => null;

  @override
  Future<void> setSpeechModel(String model) async {}

  @override
  Future<PlaybackPreferences> getPlaybackPreferences() async =>
      const PlaybackPreferences();

  @override
  Future<void> setPlaybackPreferences(PlaybackPreferences preferences) async {}
}

class _Books implements AudiobookRepository {
  _Books([this.books = const []]);

  List<Audiobook> books;

  @override
  Future<List<Audiobook>> getBooks() async => books;

  @override
  Future<void> saveBook(Audiobook updated) async {
    books = [
      for (final book in books)
        if (book.id == updated.id) updated else book,
    ];
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Files implements FileImportRepository {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Artwork implements AudiobookArtworkExtractor {
  @override
  Future<String?> extract(String audioFilePath) async => null;
}
