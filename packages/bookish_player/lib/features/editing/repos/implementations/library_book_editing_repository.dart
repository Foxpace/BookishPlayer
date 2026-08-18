import 'package:injectable/injectable.dart';

import '../../../importing/repos/file_import_repository.dart';

import '../../../library/models/library_models.dart';
import '../../../library/repos/audiobook_catalog_repository.dart';
import '../book_editing_repository.dart';

@LazySingleton(as: BookEditingRepository)
class LibraryBookEditingRepository implements BookEditingRepository {
  const LibraryBookEditingRepository(this._books, this._files);

  final AudiobookCatalogRepository _books;
  final FileImportRepository _files;

  @override
  Future<Audiobook?> loadBook(String id) => _books.getBook(id);

  @override
  Future<void> saveBook(Audiobook book) => _books.saveBook(book);

  @override
  Future<String?> pickCover(String bookId) => _files.pickAndImportCover(bookId);

  @override
  Future<void> deleteImportedFile(String path) =>
      _files.deleteImportedFile(path);
}
