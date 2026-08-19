import 'package:injectable/injectable.dart';

import '../../library/models/library_models.dart';
import '../../library/repos/book_metadata_repository.dart';
import '../models/book_note.dart';
import '../repos/book_note_repository.dart';

typedef NoteGalleryContent = ({
  List<BookMetadata> metadata,
  List<BookNote> notes,
});

@injectable
class NoteGalleryApplication {
  const NoteGalleryApplication(this._notes, this._metadata);

  final BookNoteRepository _notes;
  final BookMetadataRepository _metadata;

  Future<NoteGalleryContent> load() async {
    final (metadata, notes) = await (
      _metadata.getBookMetadata(),
      _notes.getAllNotes(),
    ).wait;
    return (metadata: metadata, notes: notes);
  }

  Future<BookNote?> update(
    BookNote note, {
    required String? title,
    required String text,
  }) async {
    final cleanText = text.trim();
    if (cleanText.isEmpty) {
      return null;
    }
    final cleanTitle = title?.trim();
    final updated = note.copyWith(
      title: cleanTitle == null || cleanTitle.isEmpty ? null : cleanTitle,
      text: cleanText,
    );
    await _notes.saveNote(updated);
    return updated;
  }
}
