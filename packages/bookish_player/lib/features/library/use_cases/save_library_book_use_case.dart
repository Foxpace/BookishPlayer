import 'package:injectable/injectable.dart';
import '../models/library_models.dart';
import '../repos/audiobook_catalog_repository.dart';

@injectable
class SaveLibraryBookUseCase {
  const SaveLibraryBookUseCase(this._books);

  final AudiobookCatalogRepository _books;

  Future<void> call(Audiobook book) => _books.saveBook(book);
}
