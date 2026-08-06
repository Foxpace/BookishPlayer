import 'package:bookish_player/features/library/domain/book_metadata.dart';
import 'package:bookish_player/features/library/domain/book_metadata_repository.dart';
import 'package:bookish_player/features/library/domain/book_note_repository.dart';
import 'package:bookish_player/features/notes/presentation/note_gallery_cubit.dart';
import 'package:bookish_player/features/notes/presentation/note_gallery_screen.dart';
import 'package:bookish_player/features/player/domain/book_note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('opens a book note list and edits the selected note', (
    tester,
  ) async {
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
    final cubit = NoteGalleryCubit(notes, _FakeMetadata(metadata));
    addTearDown(cubit.close);
    await cubit.load();

    await tester.pumpWidget(
      BlocProvider.value(
        value: cubit,
        child: const MaterialApp(home: NoteGalleryScreen()),
      ),
    );

    expect(find.text('2 notes across 1 book'), findsOneWidget);
    expect(find.text('2 notes'), findsOneWidget);

    await tester.tap(find.text('The Test Book'));
    await tester.pumpAndSettle();

    expect(find.text('First note'), findsOneWidget);
    expect(find.text('Second note'), findsOneWidget);

    await tester.tap(find.text('First note'));
    await tester.pumpAndSettle();

    expect(find.widgetWithText(AppBar, 'Note'), findsOneWidget);
    expect(find.text('Title (optional)'), findsOneWidget);
    await tester.enterText(find.byType(TextField).last, 'Edited note');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(notes.saved?.text, 'Edited note');
    expect(find.text('Edited note'), findsOneWidget);
  });
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
