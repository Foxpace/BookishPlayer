part of 'portability_use_cases.dart';

@injectable
class ExportBackupUseCase {
  const ExportBackupUseCase(this._workflow);
  final BackupWorkflow _workflow;
  Future<bool> call() => _workflow.export();
}
