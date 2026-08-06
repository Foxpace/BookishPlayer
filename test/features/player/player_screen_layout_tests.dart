part of 'player_cubit_test.dart';

void registerPlayerScreenLayoutTests() {
  _registerMiniPlayerProgressTest();

  testWidgets('landscape player keeps artwork and controls fully visible', (
    tester,
  ) async {
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
          home: MediaQuery(
            data: MediaQueryData(
              size: Size(844, 390),
              padding: EdgeInsets.only(bottom: 24),
              textScaler: TextScaler.linear(1.3),
            ),
            child: PlayerScreen(),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(
      tester.getCenter(find.byType(BookCover)).dx,
      lessThan(tester.getCenter(find.byTooltip('Previous chapter')).dx),
    );
    for (final label in ['1.0×', 'Quote', 'Chapters', 'Timer', 'Notes']) {
      final bounds = tester.getRect(find.text(label));
      expect(bounds.top, greaterThanOrEqualTo(0));
      expect(bounds.bottom, lessThanOrEqualTo(390));
    }
  });
}

void _registerMiniPlayerProgressTest() {
  testWidgets('mini player progress is relative to the current chapter', (
    tester,
  ) async {
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

    final progress = tester.widget<LinearProgressIndicator>(
      find.byType(LinearProgressIndicator),
    );
    expect(progress.value, .5);
  });
}
