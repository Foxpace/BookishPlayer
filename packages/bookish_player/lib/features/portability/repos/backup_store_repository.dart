import '../../../core/foundation/result.dart';
import '../models/bookish_backup.dart';

abstract interface class BackupStoreRepository {
  Future<Result<BookishBackup>> snapshot();
  Future<Result<bool>> restore(BookishBackup backup);
}
