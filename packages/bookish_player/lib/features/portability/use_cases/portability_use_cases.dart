import 'package:injectable/injectable.dart';

import 'backup_workflow.dart';
import 'restore_backup_use_case.dart';

part 'export_backup_use_case.dart';

@injectable
class PortabilityUseCases {
  const PortabilityUseCases(this.exportBackup, this.restoreBackup);
  final ExportBackupUseCase exportBackup;
  final RestoreBackupUseCase restoreBackup;
}
