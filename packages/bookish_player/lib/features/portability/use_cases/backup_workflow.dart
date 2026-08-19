import 'package:injectable/injectable.dart';

import '../../../core/foundation/result.dart';
import '../models/bookish_backup.dart';
import '../repos/backup_store_repository.dart';
import '../repos/local_export_repository.dart';
import 'bookish_backup_validator.dart';
import 'portability_failure.dart';

@injectable
class BackupWorkflow {
  BackupWorkflow(this._store, this._files, this._validator);

  final BackupStoreRepository _store;
  final LocalExportRepository _files;
  final BookishBackupValidator _validator;

  Future<Result<bool, PortabilityFailure>> export() async {
    try {
      return switch (await _store.snapshot()) {
        ResultSuccess(:final value) => Result.success(
          await _files.exportBackup(value),
        ),
        ResultFailure() => const Result.failure(
          PortabilityFailure.operationFailed,
        ),
      };
    } catch (_) {
      return const Result.failure(PortabilityFailure.operationFailed);
    }
  }

  Future<Result<bool, PortabilityFailure>> restore() async {
    try {
      return await _restorePickedBackup();
    } catch (_) {
      return const Result.failure(PortabilityFailure.operationFailed);
    }
  }

  Future<Result<bool, PortabilityFailure>> _restorePickedBackup() async {
    final backup = await _files.pickBackup();
    if (backup == null) {
      return const Result.success(false);
    }
    return switch (_validator.validate(backup)) {
      ResultSuccess(:final value) => _restoreValidatedBackup(value),
      ResultFailure() => const Result.failure(PortabilityFailure.invalidBackup),
    };
  }

  Future<Result<bool, PortabilityFailure>> _restoreValidatedBackup(
    BookishBackup backup,
  ) async => switch (await _store.restore(backup)) {
    ResultSuccess() => const Result.success(true),
    ResultFailure() => const Result.failure(PortabilityFailure.operationFailed),
  };
}
