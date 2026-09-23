import 'package:bookish_player/features/library/models/library_models.dart';
import 'package:bookish_player/features/notes/models/book_note.dart';
import 'package:bookish_player/features/notes/repos/book_note_repository.dart';
import 'package:bookish_player/features/notes/use_cases/player_notes_service.dart';
import 'package:bookish_player/features/player/models/share_origin.dart';
import 'package:bookish_player/features/player/repos/quote_share_repository.dart';
import 'package:bookish_player/features/portability/models/bookish_backup.dart';
import 'package:bookish_player/features/portability/repos/local_export_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_support/support/fakes/fake_clock.dart';
import '../../../test_support/support/fakes/fake_id_generator.dart';

void main() {
  late _Sharing sharing;
  late PlayerNotesService service;

  setUp(() {
    sharing = _Sharing();
    service = PlayerNotesService(
      _Notes(),
      _Exports(),
      sharing,
      FakeClock(),
      FakeIdGenerator(),
    );
  });

  test('Given a saved transcription note, When sharing from Notes, Then the quote includes its chapter range and book', () async {
    // GIVEN
    final book = _book(
      chapters: const [
        AudioChapter(title: 'First', startMs: 0),
        AudioChapter(title: 'Second', startMs: 60_000),
      ],
    );
    final note = _note(
      positionMs: 70_000,
      endPositionMs: 75_000,
      chapterTitle: 'Second',
      title: 'Favorite passage',
    );

    // WHEN
    await service.share(book, note);

    // THEN
    expect(
      sharing.text,
      'Favorite passage\n\nA quote\n\nSecond · 00:10–00:15\n— Book — Author',
    );
  });

  test('Given a note without chapters, When sharing from Notes, Then the book and single timestamp remain', () async {
    // GIVEN
    final book = _book();
    final note = _note(positionMs: 90_000);

    // WHEN
    await service.share(book, note);

    // THEN
    expect(sharing.text, 'A quote\n\n01:30\n— Book — Author');
  });
}

Audiobook _book({List<AudioChapter> chapters = const []}) => Audiobook(
  id: 'book',
  title: 'Book',
  author: 'Author',
  filePath: '/book.mp3',
  durationMs: 120_000,
  addedAt: DateTime(2026),
  chapters: chapters,
);

BookNote _note({
  required int positionMs,
  int? endPositionMs,
  String? chapterTitle,
  String? title,
}) => BookNote(
  id: 'note',
  metadataId: 'metadata',
  positionMs: positionMs,
  endPositionMs: endPositionMs,
  chapterTitle: chapterTitle,
  title: title,
  text: 'A quote',
  createdAt: DateTime(2026),
);

class _Notes implements BookNoteRepository {
  @override
  Future<void> deleteNote(String id) async {}

  @override
  Future<List<BookNote>> getAllNotes() async => [];

  @override
  Future<List<BookNote>> getNotes(String bookId) async => [];

  @override
  Future<void> saveNote(BookNote note) async {}
}

class _Exports implements LocalExportRepository {
  @override
  Future<bool> exportBackup(BookishBackup backup) async => true;

  @override
  Future<bool> exportNotes(Audiobook book, List<BookNote> notes) async => true;

  @override
  Future<BookishBackup?> pickBackup() async => null;
}

class _Sharing implements QuoteShareRepository {
  String? text;

  @override
  Future<void> share({
    required String text,
    required String subject,
    ShareOrigin? origin,
  }) async {
    this.text = text;
  }
}
