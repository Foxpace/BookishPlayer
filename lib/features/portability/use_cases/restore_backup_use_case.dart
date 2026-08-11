import 'package:injectable/injectable.dart';
import 'backup_workflow.dart';

@injectable
class RestoreBackupUseCase {
  const RestoreBackupUseCase(this._workflow);
  final BackupWorkflow _workflow;
  Future<bool> call() => _workflow.restore();
}
