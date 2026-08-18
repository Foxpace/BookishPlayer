import 'package:injectable/injectable.dart';

import '../../library/models/library_models.dart';
import '../../library/repos/book_metadata_repository.dart';
import '../models/book_note.dart';
import '../repos/book_note_repository.dart';
import 'update_gallery_note_use_case.dart';

part 'load_note_gallery_use_case.dart';

typedef NoteGalleryContent = ({
  List<BookMetadata> metadata,
  List<BookNote> notes,
});

@injectable
class NoteGalleryUseCases {
  const NoteGalleryUseCases({
    required this.loadGallery,
    required this.updateNote,
  });

  final LoadNoteGalleryUseCase loadGallery;
  final UpdateGalleryNoteUseCase updateNote;
}
