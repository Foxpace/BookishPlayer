import 'package:injectable/injectable.dart';
import 'diagnostics_workflow.dart';

@injectable
class DeleteDiagnosticsUseCase {
  const DeleteDiagnosticsUseCase(this._workflow);
  final DiagnosticsWorkflow _workflow;
  Future<void> call() => _workflow.clear();
}
