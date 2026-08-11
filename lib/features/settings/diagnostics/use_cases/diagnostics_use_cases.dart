import 'package:injectable/injectable.dart';

import 'diagnostics_workflow.dart';
import 'delete_diagnostics_use_case.dart';

part 'export_diagnostics_use_case.dart';

@injectable
class DiagnosticsUseCases {
  const DiagnosticsUseCases(this.exportDiagnostics, this.deleteDiagnostics);
  final ExportDiagnosticsUseCase exportDiagnostics;
  final DeleteDiagnosticsUseCase deleteDiagnostics;
}
