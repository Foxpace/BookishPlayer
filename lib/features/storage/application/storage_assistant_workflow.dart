import '../../library/domain/audiobook.dart';
import '../../library/domain/audiobook_catalog_repository.dart';
import '../domain/library_storage_repository.dart';
import '../domain/app_data_reset_repository.dart';
import '../domain/storage_report.dart';
import '../../transcription/domain/transcription_repository.dart';

class StorageAssistantWorkflow {
  StorageAssistantWorkflow(
    this._books,
    this._storage,
    this._appData,
    this._transcription,
  );

  final AudiobookCatalogRepository _books;
  final LibraryStorageRepository _storage;
  final AppDataResetRepository _appData;
  final TranscriptionRepository _transcription;

  Future<({List<Audiobook> books, StorageReport report})> inspect() async {
    final books = await _books.getBooks();
    return (books: books, report: await _storage.inspect(books));
  }

  Future<void> cleanOrphans(StorageReport report) =>
      _storage.deleteOrphans(report.orphanPaths);

  Future<void> removeMissingBook(String id) => _books.deleteBook(id);

  Future<void> clearAll() async {
    await _transcription.reset();
    await _appData.clearAll();
  }
}
