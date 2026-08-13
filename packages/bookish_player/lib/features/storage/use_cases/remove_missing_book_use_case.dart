import 'package:injectable/injectable.dart';
import 'storage_assistant_workflow.dart';

@injectable
class RemoveMissingBookUseCase {
  const RemoveMissingBookUseCase(this._workflow);

  final StorageAssistantWorkflow _workflow;

  Future<void> call(String id) => _workflow.removeMissingBook(id);
}
