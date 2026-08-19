import '../../../core/foundation/result.dart';
import '../../importing/repos/audiobook_artwork_extractor.dart';
import '../../importing/repos/file_import_repository.dart';
import '../../settings/repos/settings_repository.dart';
import '../models/audiobook_removal_mode.dart';
import '../models/library_load_result.dart';
import '../models/library_failure.dart';
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

  Future<Result<LibraryLoadResult, LibraryFailure>> load() async {
    try {
      final (savedBooks, layout) = await (
        _books.getBooks(),
        _settings.getLibraryLayout(),
      ).wait;
      final books = await [
        for (final book in savedBooks) _scanArtwork(book),
      ].wait;
      return Result.success(
        LibraryLoadResult(books: books, layout: layout ?? 'list'),
      );
    } catch (_) {
      return const Result.failure(LibraryFailure.load);
    }
  }

  Future<Result<bool, LibraryFailure>> setLayout(String layout) async {
    try {
      await _settings.setLibraryLayout(layout);
      return const Result.success(true);
    } catch (_) {
      return const Result.failure(LibraryFailure.save);
    }
  }

  Future<Result<Audiobook, LibraryFailure>> saveBook(Audiobook book) async {
    try {
      await _books.saveBook(book);
      return Result.success(book);
    } catch (_) {
      return const Result.failure(LibraryFailure.save);
    }
  }

  Future<Result<bool, LibraryFailure>> removeBook(
    Audiobook book,
    AudiobookRemovalMode mode,
  ) async {
    try {
      await _prepareBookRemoval(book.id);
      await _books.deleteBook(book.id, mode: mode);

      final artworkPath = book.artworkPath;
      final paths = {
        ...book.playableTracks.map((track) => track.filePath),
        if (artworkPath != null && mode == AudiobookRemovalMode.deleteAllData)
          artworkPath,
      };
      await [for (final path in paths) _files.deleteImportedFile(path)].wait;
      return const Result.success(true);
    } catch (_) {
      return const Result.failure(LibraryFailure.removal);
    }
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
