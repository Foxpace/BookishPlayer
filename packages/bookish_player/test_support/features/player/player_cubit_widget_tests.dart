import 'dart:async';

import 'player_test_support.dart';
import 'player_control_widget_tests.dart';
import 'player_screen_robot.dart';

void registerPlayerCubitWidgetTests() {
  group('Now playing mini player', _registerNowPlayingWidgetTests);
  group('Player back navigation', _registerPlayerBackNavigationWidgetTests);
  group('Player controls', registerPlayerControlWidgetTests);
  group('Chapter sheet', _registerChapterSheetWidgetTests);
}

void _registerNowPlayingWidgetTests() {
  late PlayerCubitTestHarness harness;

  tearDown(() => harness.close());

  testWidgets(
    'Given a current book, When the mini player is used, Then its playback state stays visible',
    (tester) async {
      final robot = PlayerScreenRobot(tester);

      // GIVEN
      final book = _book(id: 'book', title: 'Visible Book');
      harness = await PlayerCubitTestHarness.opened(book);

      // WHEN
      await tester.pumpWidget(
        PlayerTestApp(home: PlayerTestNowPlayingShell(cubit: harness.sut)),
      );

      // THEN
      robot.expectMiniPlayer(title: 'Visible Book', status: 'Paused');

      // WHEN
      await robot.togglePlayback('Play');

      // THEN
      robot.expectPlaying(pauseTooltip: 'Pause', status: 'Playing');
    },
  );

  testWidgets(
    'Given a visible finished book, When it is removed, Then the mini player is cleared',
    (tester) async {
      final robot = PlayerScreenRobot(tester);

      // GIVEN
      final book = _book(
        id: 'finished',
        title: 'Finished Book',
        positionMs: 60000,
      );
      harness = await PlayerCubitTestHarness.opened(book);

      // WHEN
      await tester.pumpWidget(
        PlayerTestApp(home: PlayerTestNowPlayingShell(cubit: harness.sut)),
      );

      // THEN
      robot.expectMiniPlayer(title: 'Finished Book', status: 'Paused');

      // WHEN
      await harness.sut.removeBook(book.id);
      await tester.pump();

      // THEN
      robot.expectBookHidden('Finished Book');
      expect(harness.sut.state.book, isNull);
      expect(harness.audio.pauseCount, 1);
    },
  );
}

void _registerPlayerBackNavigationWidgetTests() {
  late PlayerCubitTestHarness harness;

  tearDown(() => harness.close());

  testWidgets(
    'Given an open player route, When system and toolbar back are used, Then both commit the same pop',
    (tester) async {
      final robot = PlayerScreenRobot(tester);

      // GIVEN
      final book = _book(id: 'book', title: 'Book');
      harness = await PlayerCubitTestHarness.opened(book);

      final navigatorKey = GlobalKey<NavigatorState>();
      await tester.pumpWidget(
        BlocProvider.value(
          value: harness.sut,
          child: PlayerTestApp(
            navigatorKey: navigatorKey,
            home: const Scaffold(body: Text('Library')),
          ),
        ),
      );

      Future<void> openPlayer() async {
        final navigator = navigatorKey.currentState;
        if (navigator == null) {
          fail('The test navigator must be mounted.');
        }
        unawaited(
          navigator.push<void>(
            MaterialPageRoute<void>(
              builder: (_) => PlayerTestScreenHarness(cubit: harness.sut),
            ),
          ),
        );
        await tester.pumpAndSettle();
      }

      // WHEN
      await openPlayer();

      // THEN
      final popScope = find.byWidgetPredicate(
        (widget) => widget is PopScope<void>,
      );
      expect(tester.widget<PopScope<void>>(popScope).canPop, isTrue);

      // WHEN
      // This helper is compiled as support code but only runs from Flutter tests.
      // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();

      // THEN
      robot.expectLibrary('Library');

      // WHEN
      await openPlayer();
      await robot.goBackToLibrary('Back to library');

      // THEN
      robot.expectLibrary('Library');
    },
  );
}

void _registerChapterSheetWidgetTests() {
  late PlayerCubitTestHarness harness;

  tearDown(() => harness.close());

  testWidgets(
    'Given many chapters with an active chapter, When the sheet opens, Then it scrolls to the active chapter',
    (tester) async {
      final robot = PlayerScreenRobot(tester);

      // GIVEN
      final chapters = [
        for (var index = 0; index < 14; index++)
          AudioChapter(title: 'Chapter ${index + 1}', startMs: index * 60000),
      ];
      final book = _book(
        id: 'chapters',
        title: 'Chaptered Book',
        durationMs: chapters.length * 60000,
        positionMs: 10 * 60000 + 1000,
        chapters: chapters,
      );
      harness = await PlayerCubitTestHarness.opened(book);

      // WHEN
      await tester.pumpWidget(
        PlayerTestApp(
          home: Scaffold(
            body: ChaptersSheet(
              chapters: harness.sut.state.chapterTimeline,
              activeIndex: harness.sut.state.currentChapterIndex,
              state: harness.sut.state,
              onSelectChapter: (_) {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // THEN
      robot.expectActiveChapter(
        semantics: 'currently on 11',
        title: 'Chapter 11',
      );
    },
  );
}

Audiobook _book({
  required String id,
  required String title,
  int durationMs = 60000,
  int positionMs = 0,
  List<AudioChapter> chapters = const [],
}) => Audiobook(
  id: id,
  title: title,
  filePath: '/$id.mp3',
  durationMs: durationMs,
  positionMs: positionMs,
  addedAt: DateTime(2026),
  chapters: chapters,
);
