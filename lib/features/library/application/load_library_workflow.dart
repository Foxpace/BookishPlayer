import '../../importing/domain/audiobook_artwork_extractor.dart';
import '../../settings/domain/settings_repository.dart';
import '../domain/audiobook.dart';
import '../domain/audiobook_catalog_repository.dart';
import 'library_load_result.dart';

class LoadLibraryWorkflow {
  LoadLibraryWorkflow(this._books, this._artwork, this._settings);

  final AudiobookCatalogRepository _books;
  final AudiobookArtworkExtractor _artwork;
  final SettingsRepository _settings;

  Future<LibraryLoadResult> run() async {
    final savedBooks = await _books.getBooks();
    final books = <Audiobook>[];
    for (final book in savedBooks) {
      if (book.artworkScanned) {
        books.add(book);
        continue;
      }
      final updated = book.copyWith(
        artworkPath: await _artwork.extract(book.filePath),
        artworkScanned: true,
      );
      await _books.saveBook(updated);
      books.add(updated);
    }
    return LibraryLoadResult(
      books: books,
      layout: await _settings.getLibraryLayout() ?? 'list',
    );
  }
}
