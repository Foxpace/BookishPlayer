import '../../library/domain/audiobook.dart';
import '../../library/domain/audiobook_catalog_repository.dart';
import '../domain/library_storage_repository.dart';
import '../domain/storage_report.dart';

class StorageAssistantWorkflow {
  StorageAssistantWorkflow(this._books, this._storage);

  final AudiobookCatalogRepository _books;
  final LibraryStorageRepository _storage;

  Future<({List<Audiobook> books, StorageReport report})> inspect() async {
    final books = await _books.getBooks();
    return (books: books, report: await _storage.inspect(books));
  }

  Future<void> cleanOrphans(StorageReport report) =>
      _storage.deleteOrphans(report.orphanPaths);

  Future<void> removeMissingBook(String id) => _books.deleteBook(id);
}
