import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/presentation/diagnostic_failure.dart';
import '../../library/domain/book_note_repository.dart';
import '../../library/domain/book_metadata_repository.dart';
import '../../player/domain/book_note.dart';
import 'note_gallery_state.dart';

@injectable
class NoteGalleryCubit extends Cubit<NoteGalleryState> {
  NoteGalleryCubit(this._notes, this._metadata)
    : super(const NoteGalleryState());

  final BookNoteRepository _notes;
  final BookMetadataRepository _metadata;

  Future<void> load() async {
    emit(const NoteGalleryState());
    try {
      final metadata = await _metadata.getBookMetadata();
      final notes = await _notes.getAllNotes();
      emit(
        NoteGalleryState(
          status: NoteGalleryStatus.ready,
          metadata: metadata,
          notes: notes,
        ),
      );
    } catch (error) {
      emit(
        NoteGalleryState(
          status: NoteGalleryStatus.failure,
          message: diagnosticFailureMessage(
            'Your notes could not be loaded.',
            error,
          ),
        ),
      );
    }
  }

  Future<void> updateNote(
    BookNote note, {
    required String? title,
    required String text,
  }) async {
    final cleanText = text.trim();
    if (cleanText.isEmpty) {
      return;
    }
    final cleanTitle = title?.trim();
    final updated = note.copyWith(
      title: cleanTitle == null || cleanTitle.isEmpty ? null : cleanTitle,
      text: cleanText,
    );
    await _notes.saveNote(updated);
    emit(
      state.copyWith(
        notes: [
          for (final current in state.notes)
            if (current.id == note.id) updated else current,
        ],
      ),
    );
  }
}
