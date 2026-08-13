part of 'diagnostics_use_cases.dart';

@injectable
class ExportDiagnosticsUseCase {
  const ExportDiagnosticsUseCase(this._workflow);
  final DiagnosticsWorkflow _workflow;
  Future<bool> call() => _workflow.export();
}
