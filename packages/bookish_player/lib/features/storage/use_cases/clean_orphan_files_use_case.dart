import 'package:injectable/injectable.dart';
import '../models/storage_report.dart';
import 'storage_assistant_workflow.dart';

@injectable
class CleanOrphanFilesUseCase {
  const CleanOrphanFilesUseCase(this._workflow);

  final StorageAssistantWorkflow _workflow;

  Future<void> call(StorageReport report) => _workflow.cleanOrphans(report);
}
