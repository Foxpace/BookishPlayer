import 'package:injectable/injectable.dart';
import '../models/book_note.dart';
import '../repos/book_note_repository.dart';

@injectable
class UpdateGalleryNoteUseCase {
  const UpdateGalleryNoteUseCase(this._notes);

  final BookNoteRepository _notes;

  Future<BookNote?> call(
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
