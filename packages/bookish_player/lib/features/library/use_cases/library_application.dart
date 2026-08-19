import '../../importing/repos/audiobook_artwork_extractor.dart';
import '../../importing/repos/file_import_repository.dart';
import '../../settings/repos/settings_repository.dart';
import '../models/audiobook_removal_mode.dart';
import '../models/library_load_result.dart';
import '../models/library_models.dart';
import '../repos/audiobook_catalog_repository.dart';

typedef PrepareBookRemoval = Future<void> Function(String bookId);

class LibraryApplication {
  LibraryApplication(
    this._books,
    this._artwork,
    this._files,
    this._settings,
    this._prepareBookRemoval,
  );

  final AudiobookCatalogRepository _books;
  final AudiobookArtworkExtractor _artwork;
  final FileImportRepository _files;
  final SettingsRepository _settings;
  final PrepareBookRemoval _prepareBookRemoval;

  Future<LibraryLoadResult> load() async {
    final (savedBooks, layout) = await (
      _books.getBooks(),
      _settings.getLibraryLayout(),
    ).wait;
    final books = await [
      for (final book in savedBooks) _scanArtwork(book),
    ].wait;
    return LibraryLoadResult(books: books, layout: layout ?? 'list');
  }

  Future<void> setLayout(String layout) => _settings.setLibraryLayout(layout);

  Future<void> saveBook(Audiobook book) => _books.saveBook(book);

  Future<void> removeBook(Audiobook book, AudiobookRemovalMode mode) async {
    await _prepareBookRemoval(book.id);
    await _books.deleteBook(book.id, mode: mode);

    final artworkPath = book.artworkPath;
    final paths = {
      ...book.playableTracks.map((track) => track.filePath),
      if (artworkPath != null && mode == AudiobookRemovalMode.deleteAllData)
        artworkPath,
    };
    await [for (final path in paths) _files.deleteImportedFile(path)].wait;
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
