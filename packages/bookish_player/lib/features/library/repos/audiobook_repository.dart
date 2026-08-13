import '../../notes/models/note_models.dart';
import '../../notes/repos/book_note_repository.dart';
import '../models/library_models.dart';
import 'audiobook_catalog_repository.dart';
import 'book_metadata_repository.dart';

abstract interface class AudiobookRepository
    implements
        AudiobookCatalogRepository,
        BookNoteRepository,
        BookMetadataRepository {
  Future<void> replaceLibrary(List<Audiobook> books, List<BookNote> notes);
}
