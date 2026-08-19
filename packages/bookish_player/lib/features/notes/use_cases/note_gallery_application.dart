import 'package:injectable/injectable.dart';

import '../../../core/foundation/result.dart';
import '../../library/models/library_models.dart';
import '../../library/repos/book_metadata_repository.dart';
import '../models/book_note.dart';
import '../models/note_gallery_failure.dart';
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

  Future<Result<NoteGalleryContent, NoteGalleryFailure>> load() async {
    try {
      final (metadata, notes) = await (
        _metadata.getBookMetadata(),
        _notes.getAllNotes(),
      ).wait;
      return Result.success((metadata: metadata, notes: notes));
    } catch (_) {
      return const Result.failure(NoteGalleryFailure.load);
    }
  }

  Future<Result<BookNote?, NoteGalleryFailure>> update(
    BookNote note, {
    required String? title,
    required String text,
  }) async {
    final updated = _updatedNote(note, title, text);
    if (updated == null) {
      return const Result.success(null);
    }
    return _save(updated);
  }

  BookNote? _updatedNote(BookNote note, String? title, String text) {
    final cleanText = text.trim();
    if (cleanText.isEmpty) {
      return null;
    }
    final cleanTitle = title?.trim();
    return note.copyWith(
      title: cleanTitle == null || cleanTitle.isEmpty ? null : cleanTitle,
      text: cleanText,
    );
  }

  Future<Result<BookNote?, NoteGalleryFailure>> _save(BookNote updated) async {
    try {
      await _notes.saveNote(updated);
      return Result.success(updated);
    } catch (_) {
      return const Result.failure(NoteGalleryFailure.save);
    }
  }
}
