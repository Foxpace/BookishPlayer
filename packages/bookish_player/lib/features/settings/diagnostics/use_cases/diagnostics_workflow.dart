import 'package:injectable/injectable.dart';

import '../../../../core/diagnostics/app_diagnostics.dart';
import '../repos/diagnostics_export_repository.dart';

@injectable
class DiagnosticsWorkflow {
  DiagnosticsWorkflow(this._diagnostics, this._exporter);

  final AppDiagnostics _diagnostics;
  final DiagnosticsExportRepository _exporter;

  Future<bool> export() async {
    final sourcePath = await _diagnostics.exportPath();
    if (sourcePath == null) {
      return false;
    }
    return _exporter.export(sourcePath);
  }

  Future<void> clear() => _diagnostics.clear();
}
