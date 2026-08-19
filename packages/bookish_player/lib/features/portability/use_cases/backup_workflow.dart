import 'package:injectable/injectable.dart';

import '../../../core/foundation/result.dart';
import '../models/bookish_backup.dart';
import '../repos/backup_store_repository.dart';
import '../repos/local_export_repository.dart';
import 'bookish_backup_validator.dart';

@injectable
class BackupWorkflow {
  BackupWorkflow(this._store, this._files, this._validator);

  final BackupStoreRepository _store;
  final LocalExportRepository _files;
  final BookishBackupValidator _validator;

  Future<Result<bool>> export() async {
    try {
      return switch (await _store.snapshot()) {
        ResultSuccess(:final value) => Result.success(
          await _files.exportBackup(value),
        ),
        ResultFailure(:final failure) => Result.failure(failure),
      };
    } catch (error) {
      return Result.failure(
        AppFailure.operationFailed('backup.export', error: error),
      );
    }
  }

  Future<Result<bool>> restore() async {
    try {
      return await _restorePickedBackup();
    } catch (error) {
      return Result.failure(
        AppFailure.operationFailed('backup.restore', error: error),
      );
    }
  }

  Future<Result<bool>> _restorePickedBackup() async {
    final backup = await _files.pickBackup();
    if (backup == null) {
      return const Result.success(false);
    }
    return switch (_validator.validate(backup)) {
      ResultSuccess(:final value) => _restoreValidatedBackup(value),
      ResultFailure(:final failure) => Result.failure(failure),
    };
  }

  Future<Result<bool>> _restoreValidatedBackup(BookishBackup backup) async =>
      switch (await _store.restore(backup)) {
        ResultSuccess() => const Result.success(true),
        ResultFailure(:final failure) => Result.failure(failure),
      };
}
