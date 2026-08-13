part of 'note_gallery_use_cases.dart';

@injectable
class LoadNoteGalleryUseCase {
  const LoadNoteGalleryUseCase(this._notes, this._metadata);

  final BookNoteRepository _notes;
  final BookMetadataRepository _metadata;

  Future<NoteGalleryContent> call() async {
    final (metadata, notes) = await (
      _metadata.getBookMetadata(),
      _notes.getAllNotes(),
    ).wait;

    return (metadata: metadata, notes: notes);
  }
}
