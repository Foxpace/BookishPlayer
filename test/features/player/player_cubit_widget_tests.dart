part of 'player_cubit_test.dart';

void registerPlayerCubitWidgetTests() {
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
