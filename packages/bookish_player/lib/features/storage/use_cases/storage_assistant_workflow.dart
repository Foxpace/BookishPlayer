import 'package:injectable/injectable.dart';

import '../../../core/foundation/result.dart';
import '../../library/models/library_models.dart';
import '../../library/repos/audiobook_catalog_repository.dart';
import '../repos/library_storage_repository.dart';
import '../models/storage_report.dart';

typedef StorageInspection = ({List<Audiobook> books, StorageReport report});

@injectable
class StorageAssistantWorkflow {
  StorageAssistantWorkflow(this._books, this._storage);

  final AudiobookCatalogRepository _books;
  final LibraryStorageRepository _storage;

  Future<Result<StorageInspection>> inspect() async {
    try {
      return await _inspect();
    } catch (error) {
      return Result.failure(
        AppFailure.operationFailed('storage.inspect', error: error),
      );
    }
  }

  Future<Result<StorageInspection>> _inspect() async {
    final books = await _books.getBooks();
    return Result.success((
      books: books,
      report: await _storage.inspect(books),
    ));
  }

  Future<Result<bool>> cleanOrphans(StorageReport report) async {
    try {
      return await _cleanOrphans(report);
    } catch (error) {
      return Result.failure(
        AppFailure.operationFailed('storage.cleanup', error: error),
      );
    }
  }

  Future<Result<bool>> _cleanOrphans(StorageReport report) async {
    await _storage.deleteOrphans(report.orphanPaths);
    return const Result.success(true);
  }

  Future<Result<bool>> removeMissingBook(String id) async {
    try {
      return await _removeMissingBook(id);
    } catch (error) {
      return Result.failure(
        AppFailure.operationFailed('storage.remove', error: error),
      );
    }
  }

  Future<Result<bool>> _removeMissingBook(String id) async {
    await _books.deleteBook(id);
    return const Result.success(true);
  }
}
