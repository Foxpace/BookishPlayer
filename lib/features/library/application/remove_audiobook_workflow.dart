import '../../importing/domain/file_import_repository.dart';
import '../domain/audiobook.dart';
import '../domain/audiobook_catalog_repository.dart';

class RemoveAudiobookWorkflow {
  RemoveAudiobookWorkflow(this._books, this._files);

  final AudiobookCatalogRepository _books;
  final FileImportRepository _files;

  Future<void> run(Audiobook book) async {
    await _books.deleteBook(book.id);
    final paths = book.playableTracks.map((track) => track.filePath).toSet();
    for (final path in paths) {
      await _files.deleteImportedFile(path);
    }
    final artworkPath = book.artworkPath;
    if (artworkPath != null) {
      await _files.deleteImportedFile(artworkPath);
    }
  }
}
