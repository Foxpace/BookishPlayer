import 'package:bookish_player/features/library/models/library_models.dart';
import 'package:bookish_player/features/library/repos/book_metadata_repository.dart';
import 'package:bookish_player/features/notes/repos/book_note_repository.dart';
import 'package:bookish_player/features/notes/ui/note_gallery_screen.dart';
import 'package:bookish_player/features/notes/ui/book_notes_screen.dart';
import 'package:bookish_player/features/notes/ui/note_detail_screen.dart';
import 'package:bookish_player/features/notes/models/book_note.dart';
import 'package:bookish_player/features/notes/cubits/note_gallery_cubit.dart';
import 'package:bookish_player/features/notes/cubits/notes_cubits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_support/support/pump_bookish_app.dart';
import '../../../test_support/features/notes/note_gallery_robot.dart';
import '../../../test_support/features/notes/notes_test_builder.dart';

void main() {
  group('Note gallery screen', () {
    testWidgets(
      'Given the note gallery screen, When its behavior is exercised, Then opens a book note list and edits the selected note',
      (tester) async {
        final robot = NoteGalleryRobot(tester);

        // GIVEN
        final metadata = BookMetadata(
          id: 'archive',
          fingerprint: 'fingerprint',
          title: 'The Test Book',
          durationMs: 60000,
          createdAt: DateTime(2026),
          activeBookId: 'book',
        );
        final notes = _FakeNotes([
          BookNote(
            id: 'first',
            metadataId: 'archive',
            positionMs: 1000,
            text: 'First note',
            createdAt: DateTime(2026, 1, 2),
          ),
          BookNote(
            id: 'second',
            metadataId: 'archive',
            positionMs: 2000,
            text: 'Second note',
            createdAt: DateTime(2026, 1, 1),
          ),
        ]);
        final cubit = createNoteGalleryCubit(notes, _FakeMetadata(metadata));
        addTearDown(cubit.close);
        await cubit.load();

        // WHEN
        await tester.pumpBookishApp(child: _NoteGalleryHarness(cubit: cubit));

        // THEN
        robot.expectGallerySummary(const ['2 notes across 1 book', '2 notes']);
        final badgeFinder = find.byKey(const ValueKey('note-count-badge'));
        final badge = tester.widget<Container>(badgeFinder);
        final badgeContext = tester.element(badgeFinder);
        final colorScheme = Theme.of(badgeContext).colorScheme;
        expect(
          (badge.decoration as BoxDecoration).color,
          colorScheme.primaryContainer,
        );
        expect(
          tester.widget<Text>(find.text('2 notes')).style?.color,
          colorScheme.onPrimaryContainer,
        );

        await robot.openBook('The Test Book');

        robot.expectBookNotes(const ['First note', 'Second note']);

        await robot.openNote('First note');

        robot.expectNoteDetail(title: 'Note', titleHint: 'Title (optional)');
        await robot.replaceNoteText('Edited note');
        await robot.saveNote('Save');

        expect(notes.saved?.text, 'Edited note');
        robot.expectNoteText('Edited note');
      },
    );
  });
}

class _NoteGalleryHarness extends StatelessWidget {
  const _NoteGalleryHarness({required this.cubit});

  final NoteGalleryCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteGalleryCubit, NoteGalleryState>(
      bloc: cubit,
      builder: (context, state) => NoteGalleryScreen(
        state: state,
        onRetry: cubit.load,
        onOpenBookNotes: (metadata) => Navigator.of(context).push<void>(
          MaterialPageRoute(
            builder: (_) => BlocBuilder<NoteGalleryCubit, NoteGalleryState>(
              bloc: cubit,
              builder: (context, state) => BookNotesScreen(
                metadata: metadata,
                notes: state.notes,
                onOpenNote: (note) => _openNote(context, note),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _openNote(BuildContext context, BookNote note) {
    return Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (_) => NoteDetailScreen(
          note: note,
          onSave: ({required title, required text}) =>
              cubit.updateNote(note, title: title, text: text),
        ),
      ),
    );
  }
}

class _FakeNotes implements BookNoteRepository {
  _FakeNotes(this.notes);

  final List<BookNote> notes;
  BookNote? saved;

  @override
  Future<List<BookNote>> getAllNotes() async => notes;

  @override
  Future<List<BookNote>> getNotes(String bookId) async => notes;

  @override
  Future<void> saveNote(BookNote note) async => saved = note;

  @override
  Future<void> deleteNote(String id) async {}
}

class _FakeMetadata implements BookMetadataRepository {
  _FakeMetadata(this.metadata);

  final BookMetadata metadata;

  @override
  Future<List<BookMetadata>> getBookMetadata() async => [metadata];

  @override
  Future<BookMetadata?> findBookMetadata(String fingerprint) async => metadata;
}
