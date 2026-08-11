import 'package:injectable/injectable.dart';

import '../../library/models/library_models.dart';
import '../../library/repos/audiobook_catalog_repository.dart';
import '../repos/library_storage_repository.dart';
import '../repos/app_data_reset_repository.dart';
import '../models/storage_report.dart';
import '../../transcription/repos/transcription_repositories.dart';

typedef StorageInspection = ({List<Audiobook> books, StorageReport report});

@injectable
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

  Future<StorageInspection> inspect() async {
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
