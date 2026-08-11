import '../../library/models/library_models.dart';
import '../models/storage_report.dart';

abstract interface class LibraryStorageRepository {
  Future<StorageReport> inspect(List<Audiobook> books);
  Future<void> deleteOrphans(List<String> paths);
}
