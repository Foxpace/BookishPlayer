import 'package:injectable/injectable.dart';
import '../repos/import_diagnostics_repository.dart';

@injectable
class CopyImportDiagnosticsUseCase {
  const CopyImportDiagnosticsUseCase(this._diagnostics);

  final ImportDiagnosticsRepository _diagnostics;

  Future<void> call(String diagnostics) => _diagnostics.copy(diagnostics);
}
