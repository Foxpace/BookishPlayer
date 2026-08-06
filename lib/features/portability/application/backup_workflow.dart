import '../domain/backup_store_repository.dart';
import '../domain/local_export_repository.dart';

class BackupWorkflow {
  BackupWorkflow(this._store, this._files);

  final BackupStoreRepository _store;
  final LocalExportRepository _files;

  Future<bool> export() async => _files.exportBackup(await _store.snapshot());

  Future<bool> restore() async {
    final backup = await _files.pickBackup();
    if (backup == null) {
      return false;
    }
    if (backup.schemaVersion < 1 || backup.schemaVersion > 3) {
      throw const FormatException('Unsupported backup version');
    }
    await _store.restore(backup);
    return true;
  }
}
