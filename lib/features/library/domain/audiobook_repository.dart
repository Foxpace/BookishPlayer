import '../../player/domain/book_note.dart';
import 'audiobook.dart';
import 'audiobook_catalog_repository.dart';
import 'book_note_repository.dart';
import 'listening_history_repository.dart';
import 'listening_session.dart';

abstract interface class AudiobookRepository
    implements
        AudiobookCatalogRepository,
        BookNoteRepository,
        ListeningHistoryRepository {
  Future<void> replaceListeningSessions(List<ListeningSession> sessions);
  Future<void> replaceLibrary(List<Audiobook> books, List<BookNote> notes);
}
