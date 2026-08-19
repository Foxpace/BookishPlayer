import 'dart:io';
import 'dart:ui' as ui;

import 'package:bookish_player/features/library/cubits/library_cubit.dart';
import 'package:bookish_player/features/library/cubits/library_intents.dart';
import 'package:bookish_player/features/library/ui/library_screen.dart';
import 'package:bookish_player/features/settings/cubits/settings_cubit.dart';
import 'package:bookish_player/features/settings/ui/settings_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../test_support/features/library/library_test_builder.dart';
import '../test_support/features/player/player_test_support.dart';
import '../test_support/features/settings/settings_test_application.dart';
import '../test_support/support/fakes/fake_library_test_support.dart';
import '../test_support/support/pump_bookish_app.dart';

const _goldenDirectory = '../../../docs/screenshots';
const _display = (
  themeMode: ThemeMode.dark,
  locale: Locale('en'),
  viewport: Size(390, 844),
  textScale: 1.0,
);

final _alice = Audiobook(
  id: 'alice-in-wonderland',
  title: "Alice's Adventures in Wonderland",
  author: 'Lewis Carroll',
  filePath: '/demo/alice.m4b',
  artworkPath: 'test/assets/alice_in_wonderland_cover.png',
  artworkScanned: true,
  durationMs: 9087000,
  positionMs: 0,
  addedAt: DateTime.utc(2026, 8, 1),
  chapters: const [
    AudioChapter(title: 'Down the Rabbit-Hole', startMs: 0),
    AudioChapter(title: 'The Pool of Tears', startMs: 728000),
    AudioChapter(title: 'A Caucus-Race and a Long Tale', startMs: 1473000),
    AudioChapter(title: 'The Rabbit Sends in a Little Bill', startMs: 2201000),
    AudioChapter(title: 'Advice from a Caterpillar', startMs: 2970000),
    AudioChapter(title: 'Pig and Pepper', startMs: 3703000),
    AudioChapter(title: 'A Mad Tea-Party', startMs: 4455000),
    AudioChapter(title: "The Queen's Croquet-Ground", startMs: 5192000),
    AudioChapter(title: "The Mock Turtle's Story", startMs: 5954000),
    AudioChapter(title: 'The Lobster Quadrille', startMs: 6705000),
    AudioChapter(title: 'Who Stole the Tarts?', startMs: 7441000),
    AudioChapter(title: "Alice's Evidence", startMs: 8194000),
  ],
);

void main() {
  setUpAll(() async {
    await _loadScreenshotFonts();
    await _cacheArtwork();
  });

  testWidgets(
    'Given a documented audiobook, When the library is rendered, Then it generates the README screenshot',
    (tester) async {
      // GIVEN
      final books = FakeLibraryBooks()..books = [_alice];
      final cubit = createLibraryCubit(
        books: books,
        settings: FakeLibrarySettings(),
        artwork: FakeLibraryArtwork(),
        files: FakeLibraryFiles(),
      );
      addTearDown(cubit.close);
      await cubit.load();

      // WHEN
      debugDisableShadows = false;
      await tester.pumpBookishApp(
        display: _display,
        blocProviders: [
          (child) =>
              BlocProvider<LibraryCubit>.value(value: cubit, child: child),
        ],
        child: LibraryScreen(
          state: cubit.state,
          intents: (
            importBooks: _ignore,
            openNotes: _ignore,
            openSettings: _ignore,
            queryChanged: cubit.setQuery,
            openView: _ignore,
            openBook: _ignoreValue,
            removeBook: _ignoreValue,
            bookAction: _ignoreBookAction,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // THEN
      await expectLater(
        find.byType(LibraryScreen),
        matchesGoldenFile('$_goldenDirectory/library.png'),
      );
      debugDisableShadows = true;
    },
  );

  testWidgets(
    'Given a documented audiobook, When the player is rendered, Then it generates the README screenshot',
    (tester) async {
      // GIVEN
      final harness = await PlayerCubitTestHarness.opened(_alice);
      addTearDown(harness.close);

      // WHEN
      debugDisableShadows = false;
      await tester.pumpBookishApp(
        display: _display,
        child: PlayerTestScreenHarness(cubit: harness.sut),
      );
      await tester.pumpAndSettle();

      // THEN
      await expectLater(
        find.byType(PlayerScreen),
        matchesGoldenFile('$_goldenDirectory/player.png'),
      );
      debugDisableShadows = true;
    },
  );

  testWidgets(
    'Given deterministic preferences, When settings are rendered, Then it generates the README screenshot',
    (tester) async {
      // GIVEN
      final cubit = SettingsCubit(
        buildSettingsApplication(FakeLibrarySettings()),
      );
      addTearDown(cubit.close);
      await cubit.load();

      // WHEN
      debugDisableShadows = false;
      await tester.pumpBookishApp(
        display: _display,
        child: SettingsScreen(
          state: cubit.state,
          actions: (
            onThemeChanged: cubit.setThemePreference,
            onPlaybackChanged: cubit.setPlaybackPreferences,
            onNavigate: _ignoreValue,
          ),
          sections: (transcription: null, localData: const SizedBox.shrink()),
        ),
      );
      await tester.pumpAndSettle();

      // THEN
      await expectLater(
        find.byType(SettingsScreen),
        matchesGoldenFile('$_goldenDirectory/settings.png'),
      );
      debugDisableShadows = true;
    },
  );
}

void _ignore() {}

void _ignoreValue(Object? _) {}

void _ignoreBookAction(Audiobook _, BookAction _) {}

Future<void> _loadScreenshotFonts() async {
  final serifFont = File(
    'test/assets/fonts/Merriweather-Regular.ttf',
  ).readAsBytes().then(ByteData.sublistView);
  await (FontLoader('serif')..addFont(serifFont)).load();
  await (FontLoader(
    'MaterialIcons',
  )..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'))).load();
}

Future<void> _cacheArtwork() async {
  final artworkPath = _alice.artworkPath;
  if (artworkPath == null) {
    throw StateError('The README audiobook fixture requires cover art.');
  }
  final file = File(artworkPath);
  final codec = await ui.instantiateImageCodec(file.readAsBytesSync());
  final frame = await codec.getNextFrame();
  PaintingBinding.instance.imageCache.putIfAbsent(
    FileImage(file),
    () => OneFrameImageStreamCompleter(
      SynchronousFuture(ImageInfo(image: frame.image)),
    ),
  );
}
