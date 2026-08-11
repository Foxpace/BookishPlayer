import '../../library/models/library_models.dart';

abstract interface class BookEditingRepository {
  Future<Audiobook?> loadBook(String id);

  Future<void> saveBook(Audiobook book);

  Future<String?> pickCover(String bookId);

  Future<void> deleteImportedFile(String path);
}
