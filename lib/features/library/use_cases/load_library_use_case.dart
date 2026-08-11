import 'package:injectable/injectable.dart';

import '../../importing/repos/audiobook_artwork_extractor.dart';
import '../../settings/repos/settings_repository.dart';
import '../models/library_models.dart';
import '../repos/audiobook_catalog_repository.dart';
import '../models/library_load_result.dart';

@injectable
class LoadLibraryUseCase {
  LoadLibraryUseCase(this._books, this._artwork, this._settings);

  final AudiobookCatalogRepository _books;
  final AudiobookArtworkExtractor _artwork;
  final SettingsRepository _settings;

  Future<LibraryLoadResult> call() async {
    final (savedBooks, layout) = await (
      _books.getBooks(),
      _settings.getLibraryLayout(),
    ).wait;
    final books = await [
      for (final book in savedBooks) _scanArtwork(book),
    ].wait;

    return LibraryLoadResult(books: books, layout: layout ?? 'list');
  }

  Future<Audiobook> _scanArtwork(Audiobook book) async {
    if (book.artworkScanned) {
      return book;
    }

    final artworkPath = await _artwork.extract(book.filePath);
    final updated = book.withScannedArtwork(artworkPath);
    await _books.saveBook(updated);
    return updated;
  }
}
