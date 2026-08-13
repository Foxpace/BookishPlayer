import 'package:injectable/injectable.dart';
import '../../library/models/library_models.dart';
import '../repos/book_editing_repository.dart';

@injectable
class ChangeBookCoverUseCase {
  const ChangeBookCoverUseCase(this._books);

  final BookEditingRepository _books;

  Future<Audiobook> call(Audiobook book) async {
    final path = await _books.pickCover(book.id);
    if (path == null) {
      return book;
    }
    final updated = book.withScannedArtwork(path);
    await _books.saveBook(updated);

    final oldPath = book.artworkPath;
    if (oldPath != null && oldPath != path) {
      await _books.deleteImportedFile(oldPath);
    }

    return updated;
  }
}
