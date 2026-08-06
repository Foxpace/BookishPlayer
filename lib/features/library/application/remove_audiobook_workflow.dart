import '../../importing/domain/file_import_repository.dart';
import '../domain/audiobook.dart';
import '../domain/audiobook_catalog_repository.dart';
import '../domain/book_note_repository.dart';
import '../domain/listening_history_repository.dart';

class RemoveAudiobookWorkflow {
  RemoveAudiobookWorkflow(this._books, this._notes, this._history, this._files);

  final AudiobookCatalogRepository _books;
  final BookNoteRepository _notes;
  final ListeningHistoryRepository _history;
  final FileImportRepository _files;

  Future<void> run(Audiobook book) async {
    final notes = await _notes.getNotes(book.id);
    final sessions = await _history.getListeningSessions();
    final preserveArtwork =
        notes.isNotEmpty ||
        book.completedAt != null ||
        sessions.any((session) => session.metadataId == book.metadataId);
    await _books.deleteBook(book.id);
    final paths = book.playableTracks.map((track) => track.filePath).toSet();
    for (final path in paths) {
      await _files.deleteImportedFile(path);
    }
    final artworkPath = book.artworkPath;
    if (artworkPath != null && !preserveArtwork) {
      await _files.deleteImportedFile(artworkPath);
    }
  }
}
