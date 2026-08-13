import 'package:injectable/injectable.dart';
import 'storage_assistant_workflow.dart';

@injectable
class ClearBookishDataUseCase {
  const ClearBookishDataUseCase(this._workflow);

  final StorageAssistantWorkflow _workflow;

  Future<void> call() => _workflow.clearAll();
}
