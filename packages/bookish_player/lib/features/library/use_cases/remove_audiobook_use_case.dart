import 'package:injectable/injectable.dart';

import '../../importing/repos/file_import_repository.dart';

import '../models/library_models.dart';
import '../repos/audiobook_catalog_repository.dart';
import '../models/audiobook_removal_mode.dart';

@injectable
class RemoveAudiobookUseCase {
  RemoveAudiobookUseCase(this._books, this._files);

  final AudiobookCatalogRepository _books;
  final FileImportRepository _files;

  Future<void> call(Audiobook book, AudiobookRemovalMode mode) async {
    await _books.deleteBook(book.id, mode: mode);
    final artworkPath = book.artworkPath;
    final paths = {
      ...book.playableTracks.map((track) => track.filePath),
      if (artworkPath != null && mode == AudiobookRemovalMode.deleteAllData)
        artworkPath,
    };

    await [for (final path in paths) _files.deleteImportedFile(path)].wait;
  }
}
