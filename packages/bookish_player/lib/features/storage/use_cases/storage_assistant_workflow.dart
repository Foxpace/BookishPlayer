import 'package:injectable/injectable.dart';

import '../../../core/foundation/result.dart';
import '../../library/models/library_models.dart';
import '../../library/repos/audiobook_catalog_repository.dart';
import '../repos/library_storage_repository.dart';
import '../models/storage_report.dart';
import '../models/storage_failure.dart';

typedef StorageInspection = ({List<Audiobook> books, StorageReport report});

@injectable
class StorageAssistantWorkflow {
  StorageAssistantWorkflow(this._books, this._storage);

  final AudiobookCatalogRepository _books;
  final LibraryStorageRepository _storage;

  Future<Result<StorageInspection, StorageFailure>> inspect() async {
    try {
      final books = await _books.getBooks();
      return Result.success((
        books: books,
        report: await _storage.inspect(books),
      ));
    } catch (_) {
      return const Result.failure(StorageFailure.inspect);
    }
  }

  Future<Result<bool, StorageFailure>> cleanOrphans(
    StorageReport report,
  ) async {
    try {
      await _storage.deleteOrphans(report.orphanPaths);
      return const Result.success(true);
    } catch (_) {
      return const Result.failure(StorageFailure.cleanup);
    }
  }

  Future<Result<bool, StorageFailure>> removeMissingBook(String id) async {
    try {
      await _books.deleteBook(id);
      return const Result.success(true);
    } catch (_) {
      return const Result.failure(StorageFailure.removal);
    }
  }
}
