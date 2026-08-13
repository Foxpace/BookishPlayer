import 'player_test_support.dart';
import 'player_screen_robot.dart';

void registerPlayerCubitNoteTests() {
  group('Note detail screen', _registerNoteWidgetTest);
  group('Player note intents', _registerNoteCubitTests);
}

void _registerNoteWidgetTest() {
  late _NoteHarness harness;

  setUp(() async => harness = await _NoteHarness.opened(title: 'Book title'));
  tearDown(() => harness.close());

  testWidgets(
    'Given a saved note, When its preview is edited and shared, Then the detail screen persists the changes',
    (tester) async {
      final robot = PlayerScreenRobot(tester);

      // GIVEN
      await harness.sut.addNote(_previewText);

      // WHEN
      await tester.pumpWidget(
        PlayerTestApp(
          home: PlayerTestScreenHarness(
            cubit: harness.sut,
            onOpenNote: (context, note) => Navigator.of(context).push<void>(
              MaterialPageRoute(
                builder: (_) => NoteDetailScreen(
                  note: note,
                  onSave: ({required title, required text}) =>
                      harness.sut.updateNote(note, title: title, text: text),
                  onShare: (edited, {origin}) =>
                      harness.sut.shareNote(edited, origin: origin),
                ),
              ),
            ),
          ),
        ),
      );
      await robot.openNotes('Notes and bookmarks');

      // THEN
      final preview = robot.notePreview(_previewText);
      expect(preview.maxLines, 2);
      expect(preview.overflow, TextOverflow.ellipsis);

      final previewText = preview.data;
      if (previewText == null) {
        fail('The note preview must contain text.');
      }

      // WHEN
      await robot.openNote(previewText);

      // THEN
      robot.expectNoteDetailReady(
        shareTooltip: 'Share note',
        titleHint: 'Title (optional)',
      );

      await robot.editNote(title: 'Key idea', text: 'Edited note');
      await robot.shareNote('Share note');

      // THEN
      expect(harness.sharing.text, 'Key idea\n\nEdited note');

      // WHEN
      await robot.saveNote('Save');

      // THEN
      expect(harness.sut.state.notes.single.title, 'Key idea');
      expect(harness.sut.state.notes.single.text, 'Edited note');
    },
  );
}

void _registerNoteCubitTests() {
  late _NoteHarness harness;

  setUp(
    () async => harness = await _NoteHarness.opened(
      title: 'Book title',
      durationMs: 120000,
    ),
  );
  tearDown(() => harness.close());

  test(
    'Given an open book, When quote, bookmark, and voice notes are added, Then their typed metadata is stored',
    () async {
      // WHEN
      await harness.sut.addNoteAt(
        'A transcribed quote',
        const Duration(seconds: 35),
        chapterTitle: 'Chapter two',
        endPosition: const Duration(seconds: 52),
      );

      // THEN
      expect(harness.books.savedNote?.text, 'A transcribed quote');
      expect(harness.books.savedNote?.positionMs, 35000);
      expect(harness.books.savedNote?.endPositionMs, 52000);
      expect(harness.books.savedNote?.chapterTitle, 'Chapter two');

      // WHEN
      await harness.sut.addBookmark();

      // THEN
      expect(harness.books.savedNote?.kind, BookNoteKind.bookmark);

      // WHEN
      await harness.sut.addVoiceNote('Remember this idea');

      // THEN
      expect(harness.books.savedNote?.kind, BookNoteKind.voice);
      expect(harness.books.savedNote?.text, 'Remember this idea');
    },
  );

  test(
    'Given a saved note, When it is updated and shared, Then its optional title is persisted and exported',
    () async {
      // GIVEN
      await harness.sut.addNote('Original note');
      final note = harness.sut.state.notes.single;

      // WHEN
      await harness.sut.updateNote(
        note,
        title: 'Key idea',
        text: 'Edited note',
      );

      // THEN
      expect(harness.books.savedNote?.title, 'Key idea');
      expect(harness.books.savedNote?.text, 'Edited note');
      expect(harness.sut.state.notes.single.title, 'Key idea');

      // WHEN
      await harness.sut.shareNote(harness.sut.state.notes.single);

      // THEN
      expect(harness.sharing.subject, 'Note from Book title');
      expect(harness.sharing.text, 'Key idea\n\nEdited note');
    },
  );
}

final class _NoteHarness {
  _NoteHarness({required this.book})
    : audio = FakeAudioPlayer(),
      books = FakeBooks(book),
      sharing = FakeSharing() {
    sut = createPlayerCubit(
      audio,
      books,
      FakeExports(),
      FakeSettings(),
      sharing,
    );
  }

  static Future<_NoteHarness> opened({
    String title = 'Book',
    int durationMs = 60000,
  }) async {
    final harness = _NoteHarness(
      book: Audiobook(
        id: 'book',
        title: title,
        filePath: '/book.mp3',
        durationMs: durationMs,
        addedAt: DateTime(2026),
      ),
    );
    await harness.sut.open(harness.book);
    return harness;
  }

  final Audiobook book;
  final FakeAudioPlayer audio;
  final FakeBooks books;
  final FakeSharing sharing;
  late final PlayerCubit sut;

  Future<void> close() async {
    await sut.close();
    await audio.close();
  }
}

const _previewText = 'A note long enough to preview in the notes list.';
