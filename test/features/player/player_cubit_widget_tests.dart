part of 'player_cubit_test.dart';

void registerPlayerCubitWidgetTests() {
  _registerNowPlayingWidgetTests();
  _registerPlayerBackNavigationWidgetTests();
  _registerPlayerControlWidgetTests();
  _registerChapterSheetWidgetTests();
}

void _registerNowPlayingWidgetTests() {
  testWidgets('shows and controls the current book outside the player', (
    tester,
  ) async {
    final book = Audiobook(
      id: 'book',
      title: 'Visible Book',
      filePath: '/book.mp3',
      durationMs: 60000,
      addedAt: DateTime(2026),
    );
    final audio = _FakeAudioPlayer();
    final cubit = _createPlayerCubit(
      audio,
      _FakeBooks(book),
      _FakeExports(),
      _FakeSettings(),
    );
    addTearDown(() async {
      await cubit.close();
      await audio.close();
    });
    await cubit.open(book);

    await tester.pumpWidget(
      BlocProvider.value(
        value: cubit,
        child: const MaterialApp(
          home: NowPlayingShell(showMiniPlayer: true, child: SizedBox.expand()),
        ),
      ),
    );

    expect(find.text('Visible Book'), findsOneWidget);
    expect(find.text('Paused'), findsOneWidget);
    await tester.tap(find.byTooltip('Play'));
    await tester.pump();
    expect(find.byTooltip('Pause'), findsOneWidget);
    expect(find.text('Playing'), findsOneWidget);
  });

  testWidgets('removing the current book hides the bottom player', (
    tester,
  ) async {
    final book = Audiobook(
      id: 'finished',
      title: 'Finished Book',
      filePath: '/finished.mp3',
      durationMs: 60000,
      positionMs: 60000,
      addedAt: DateTime(2026),
    );
    final audio = _FakeAudioPlayer();
    final cubit = _createPlayerCubit(
      audio,
      _FakeBooks(book),
      _FakeExports(),
      _FakeSettings(),
    );
    addTearDown(() async {
      await cubit.close();
      await audio.close();
    });
    await cubit.open(book);

    await tester.pumpWidget(
      BlocProvider.value(
        value: cubit,
        child: const MaterialApp(
          home: NowPlayingShell(showMiniPlayer: true, child: SizedBox.expand()),
        ),
      ),
    );
    expect(find.text('Finished Book'), findsOneWidget);

    await cubit.removeBook(book.id);
    await tester.pump();

    expect(find.text('Finished Book'), findsNothing);
    expect(cubit.state.book, isNull);
    expect(audio.pauseCount, 1);
  });
}

void _registerPlayerBackNavigationWidgetTests() {
  testWidgets('system and toolbar back use the same committed pop', (
    tester,
  ) async {
    final book = Audiobook(
      id: 'book',
      title: 'Book',
      filePath: '/book.mp3',
      durationMs: 60000,
      addedAt: DateTime(2026),
    );
    final audio = _FakeAudioPlayer();
    final books = _FakeBooks(book);
    final cubit = _createPlayerCubit(
      audio,
      books,
      _FakeExports(),
      _FakeSettings(),
    );
    addTearDown(() async {
      await cubit.close();
      await audio.close();
    });
    await cubit.open(book);

    final navigatorKey = GlobalKey<NavigatorState>();
    await tester.pumpWidget(
      BlocProvider.value(
        value: cubit,
        child: MaterialApp(
          navigatorKey: navigatorKey,
          home: const Scaffold(body: Text('Library')),
        ),
      ),
    );

    Future<void> openPlayer() async {
      unawaited(
        navigatorKey.currentState!.push<void>(
          MaterialPageRoute<void>(builder: (_) => const PlayerScreen()),
        ),
      );
      await tester.pumpAndSettle();
    }

    await openPlayer();
    final popScope = find.byWidgetPredicate(
      (widget) => widget is PopScope<void>,
    );
    expect(tester.widget<PopScope<void>>(popScope).canPop, isFalse);
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(find.text('Library'), findsOneWidget);

    await openPlayer();
    await tester.tap(find.byTooltip('Back to library'));
    await tester.pumpAndSettle();
    expect(find.text('Library'), findsOneWidget);
  });
}

void _registerPlayerControlWidgetTests() {
  testWidgets('skip labels stay centered and readable inside replay icons', (
    tester,
  ) async {
    final book = Audiobook(
      id: 'book',
      title: 'Book',
      filePath: '/book.mp3',
      durationMs: 60000,
      addedAt: DateTime(2026),
    );
    final audio = _FakeAudioPlayer();
    final cubit = _createPlayerCubit(
      audio,
      _FakeBooks(book),
      _FakeExports(),
      _FakeSettings(),
    );
    addTearDown(() async {
      await cubit.close();
      await audio.close();
    });
    await cubit.open(book);

    await tester.pumpWidget(
      BlocProvider.value(
        value: cubit,
        child: const MaterialApp(home: PlayerScreen()),
      ),
    );

    final labels = tester.widgetList<Text>(find.text('15'));
    expect(labels, hasLength(2));
    expect(
      labels.map((label) => label.textScaler),
      everyElement(TextScaler.noScaling),
    );
    expect(labels.map((label) => label.style?.fontSize), everyElement(10));
    final replayIcons = tester.widgetList<Icon>(
      find.byIcon(Icons.replay_rounded),
    );
    expect(replayIcons, hasLength(2));
    expect(replayIcons.map((icon) => icon.size), everyElement(50));
    final rewindLabel = tester.widget<Transform>(
      find.byKey(const ValueKey('rewind-skip-label')),
    );
    final forwardLabel = tester.widget<Transform>(
      find.byKey(const ValueKey('forward-skip-label')),
    );
    expect(rewindLabel.transform.getTranslation().x, 0.5);
    expect(forwardLabel.transform.getTranslation().x, -0.5);
    expect(rewindLabel.transform.getTranslation().y, 3.5);
    expect(forwardLabel.transform.getTranslation().y, 3.5);
  });
}

void _registerChapterSheetWidgetTests() {
  testWidgets('chapters open scrolled to the active chapter', (tester) async {
    final chapters = [
      for (var index = 0; index < 14; index++)
        AudioChapter(title: 'Chapter ${index + 1}', startMs: index * 60000),
    ];
    final book = Audiobook(
      id: 'chapters',
      title: 'Chaptered Book',
      filePath: '/chapters.m4b',
      durationMs: chapters.length * 60000,
      positionMs: 10 * 60000 + 1000,
      addedAt: DateTime(2026),
      chapters: chapters,
    );
    final audio = _FakeAudioPlayer();
    final cubit = _createPlayerCubit(
      audio,
      _FakeBooks(book),
      _FakeExports(),
      _FakeSettings(),
    );
    addTearDown(() async {
      await cubit.close();
      await audio.close();
    });
    await cubit.open(book);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BlocProvider.value(
            value: cubit,
            child: ChaptersSheet(
              chapters: cubit.state.chapterTimeline,
              activeIndex: cubit.state.currentChapterIndex,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.textContaining('currently on 11'), findsOneWidget);
    expect(find.text('Chapter 11'), findsOneWidget);
  });
}
