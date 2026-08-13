import 'package:injectable/injectable.dart';

import '../repos/backup_store_repository.dart';
import '../repos/local_export_repository.dart';
import 'bookish_backup_validator.dart';

@injectable
class BackupWorkflow {
  BackupWorkflow(this._store, this._files, this._validator);

  final BackupStoreRepository _store;
  final LocalExportRepository _files;
  final BookishBackupValidator _validator;

  Future<bool> export() async => _files.exportBackup(await _store.snapshot());

  Future<bool> restore() async {
    final backup = await _files.pickBackup();
    if (backup == null) {
      return false;
    }
    _validator.validate(backup);
    await _store.restore(backup);
    return true;
  }
}
