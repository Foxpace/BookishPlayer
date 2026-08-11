import '../models/bookish_backup.dart';

abstract interface class BackupStoreRepository {
  Future<BookishBackup> snapshot();
  Future<void> restore(BookishBackup backup);
}
