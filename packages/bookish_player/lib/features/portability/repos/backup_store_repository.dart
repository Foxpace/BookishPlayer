import '../../../core/foundation/result.dart';
import '../models/bookish_backup.dart';
import 'backup_store_failure.dart';

abstract interface class BackupStoreRepository {
  Future<Result<BookishBackup, BackupStoreFailure>> snapshot();
  Future<Result<bool, BackupStoreFailure>> restore(BookishBackup backup);
}
