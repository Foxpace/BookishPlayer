part of 'player_cubit_test.dart';

void registerPlayerCubitNoteTests() {
  _registerNoteWidgetTest();
  _registerNoteCubitTests();
}

void _registerNoteWidgetTest() {
  testWidgets('note preview opens an editable detail screen with sharing', (
    tester,
  ) async {
    final book = Audiobook(
      id: 'book',
      title: 'Book title',
      filePath: '/book.mp3',
      durationMs: 60000,
      addedAt: DateTime(2026),
    );
    final audio = _FakeAudioPlayer();
    final books = _FakeBooks(book);
    final sharing = _FakeSharing();
    final cubit = _createPlayerCubit(
      audio,
      books,
      _FakeExports(),
      _FakeSettings(),
      sharing,
    );
    addTearDown(() async {
      await cubit.close();
      await audio.close();
    });
    await cubit.open(book);
    await cubit.addNote('A note long enough to preview in the notes list.');

    await tester.pumpWidget(
      BlocProvider.value(
        value: cubit,
        child: const MaterialApp(home: PlayerScreen()),
      ),
    );
    await tester.tap(find.byTooltip('Notes and bookmarks'));
    await tester.pumpAndSettle();

    final preview = tester.widget<Text>(
      find.text('A note long enough to preview in the notes list.'),
    );
    expect(preview.maxLines, 2);
    expect(preview.overflow, TextOverflow.ellipsis);

    await tester.tap(find.text(preview.data!));
    await tester.pumpAndSettle();
    expect(find.byTooltip('Share note'), findsOneWidget);
    expect(find.text('Title (optional)'), findsOneWidget);
    expect(tester.testTextInput.isVisible, isFalse);
    expect(
      tester
          .widgetList<TextField>(find.byType(TextField))
          .every((field) => field.focusNode?.hasFocus != true),
      isTrue,
    );

    await tester.enterText(find.byType(TextField).first, 'Key idea');
    await tester.enterText(find.byType(TextField).last, 'Edited note');
    await tester.tap(find.byTooltip('Share note'));
    await tester.pump();
    expect(sharing.text, 'Key idea\n\nEdited note');

    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(cubit.state.notes.single.title, 'Key idea');
    expect(cubit.state.notes.single.text, 'Edited note');
  });
}

void _registerNoteCubitTests() {
  test('stores quote chapter and range metadata', () async {
    final book = Audiobook(
      id: 'book',
      title: 'Book',
      filePath: '/book.mp3',
      durationMs: 120000,
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
    await cubit.addNoteAt(
      'A transcribed quote',
      const Duration(seconds: 35),
      chapterTitle: 'Chapter two',
      endPosition: const Duration(seconds: 52),
    );

    expect(books.savedNote?.text, 'A transcribed quote');
    expect(books.savedNote?.positionMs, 35000);
    expect(books.savedNote?.endPositionMs, 52000);
    expect(books.savedNote?.chapterTitle, 'Chapter two');

    await cubit.addBookmark();
    expect(books.savedNote?.kind, BookNoteKind.bookmark);
    await cubit.addVoiceNote('Remember this idea');
    expect(books.savedNote?.kind, BookNoteKind.voice);
    expect(books.savedNote?.text, 'Remember this idea');
  });

  test('updates and shares a note with its optional title', () async {
    final book = Audiobook(
      id: 'book',
      title: 'Book title',
      filePath: '/book.mp3',
      durationMs: 60000,
      addedAt: DateTime(2026),
    );
    final audio = _FakeAudioPlayer();
    final books = _FakeBooks(book);
    final sharing = _FakeSharing();
    final cubit = _createPlayerCubit(
      audio,
      books,
      _FakeExports(),
      _FakeSettings(),
      sharing,
    );
    addTearDown(() async {
      await cubit.close();
      await audio.close();
    });

    await cubit.open(book);
    await cubit.addNote('Original note');
    final note = cubit.state.notes.single;
    await cubit.updateNote(note, title: 'Key idea', text: 'Edited note');

    expect(books.savedNote?.title, 'Key idea');
    expect(books.savedNote?.text, 'Edited note');
    expect(cubit.state.notes.single.title, 'Key idea');

    await cubit.shareNote(cubit.state.notes.single);
    expect(sharing.subject, 'Note from Book title');
    expect(sharing.text, 'Key idea\n\nEdited note');
  });
}
