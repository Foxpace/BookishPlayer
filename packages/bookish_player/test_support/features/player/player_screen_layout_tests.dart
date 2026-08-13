import 'player_test_support.dart';
import '../../support/pump_bookish_app.dart';

void registerPlayerScreenLayoutTests() {
  group('Mini player progress', _registerMiniPlayerProgressTest);
  group('Portrait player', _registerPortraitPlayerGoldenTest);
  group('Compact landscape player', () {
    late PlayerCubitTestHarness harness;

    tearDown(() => harness.close());

    testWidgets(
      'Given a compact landscape viewport, When the player renders, Then artwork and controls stay fully visible',
      (tester) async {
        // GIVEN
        tester.view.physicalSize = const Size(844, 390);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        final book = Audiobook(
          id: 'landscape-book',
          title: 'A Long Audiobook Title That Needs Two Lines in the Player',
          filePath: '/landscape.mp3',
          durationMs: 60000,
          addedAt: DateTime(2026),
        );
        harness = await PlayerCubitTestHarness.opened(book);

        // WHEN
        await tester.pumpWidget(
          PlayerTestApp(
            home: MediaQuery(
              data: const MediaQueryData(
                size: Size(844, 390),
                padding: EdgeInsets.only(bottom: 24),
                textScaler: TextScaler.linear(1.3),
              ),
              child: PlayerTestScreenHarness(cubit: harness.sut),
            ),
          ),
        );
        await tester.pump();

        // THEN
        expect(tester.takeException(), isNull);
        expect(
          tester.getCenter(find.byType(BookCover)).dx,
          lessThan(tester.getCenter(find.byTooltip('Previous chapter')).dx),
        );
        for (final label in [
          'Output',
          '1.0×',
          'Quote',
          'Chapters',
          'Timer',
          'Notes',
        ]) {
          final bounds = tester.getRect(find.text(label));
          expect(bounds.top, greaterThanOrEqualTo(0));
          expect(bounds.bottom, lessThanOrEqualTo(390));
        }
        await expectLater(
          find.byType(PlayerScreen),
          matchesGoldenFile('goldens/player_landscape_light_en.png'),
        );
      },
    );
  });
}

void _registerPortraitPlayerGoldenTest() {
  late PlayerCubitTestHarness harness;

  tearDown(() => harness.close());

  testWidgets(
    'Given a chaptered book in dark Slovak, When the portrait player renders, Then it matches the approved golden',
    (tester) async {
      // GIVEN
      final book = Audiobook(
        id: 'portrait-book',
        title: 'The Left Hand of Darkness',
        author: 'Ursula K. Le Guin',
        filePath: '/portrait.mp3',
        durationMs: 120000,
        positionMs: 30000,
        addedAt: DateTime(2026),
        chapters: const [
          AudioChapter(title: 'Winter', startMs: 0),
          AudioChapter(title: 'The Place Inside the Blizzard', startMs: 60000),
        ],
      );
      harness = await PlayerCubitTestHarness.opened(book);

      // WHEN
      await tester.pumpBookishApp(
        display: const (
          themeMode: ThemeMode.dark,
          locale: Locale('sk'),
          viewport: Size(390, 844),
          textScale: 1,
        ),
        child: PlayerTestScreenHarness(cubit: harness.sut),
      );

      // THEN
      await expectLater(
        find.byType(PlayerScreen),
        matchesGoldenFile('goldens/player_portrait_dark_sk.png'),
      );
    },
  );
}

void _registerMiniPlayerProgressTest() {
  late PlayerCubitTestHarness harness;

  tearDown(() => harness.close());

  testWidgets(
    'Given playback in a later chapter, When the mini player renders, Then progress is chapter-relative',
    (tester) async {
      // GIVEN
      final book = Audiobook(
        id: 'chapter-progress',
        title: 'Chapter Progress',
        filePath: '/chapters.m4b',
        durationMs: 120000,
        positionMs: 90000,
        addedAt: DateTime(2026),
        chapters: const [
          AudioChapter(title: 'One', startMs: 0),
          AudioChapter(title: 'Two', startMs: 60000),
        ],
      );
      harness = await PlayerCubitTestHarness.opened(book);

      // WHEN
      await tester.pumpWidget(
        PlayerTestApp(home: PlayerTestNowPlayingShell(cubit: harness.sut)),
      );

      // THEN
      final progress = tester.widget<LinearProgressIndicator>(
        find.byType(LinearProgressIndicator),
      );
      expect(progress.value, .5);
    },
  );
}
