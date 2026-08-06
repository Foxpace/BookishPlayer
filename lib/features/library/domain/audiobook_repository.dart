import '../../player/domain/book_note.dart';
import 'audiobook.dart';
import 'audiobook_catalog_repository.dart';
import 'book_note_repository.dart';
import 'book_metadata_repository.dart';

abstract interface class AudiobookRepository
    implements
        AudiobookCatalogRepository,
        BookNoteRepository,
        BookMetadataRepository {
  Future<void> replaceLibrary(List<Audiobook> books, List<BookNote> notes);
}
