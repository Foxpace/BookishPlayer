part of 'storage_use_cases.dart';

@injectable
class InspectStorageUseCase {
  const InspectStorageUseCase(this._workflow);

  final StorageAssistantWorkflow _workflow;

  Future<StorageInspection> call() => _workflow.inspect();
}
