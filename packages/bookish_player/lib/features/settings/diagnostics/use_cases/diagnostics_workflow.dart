import 'package:injectable/injectable.dart';

import '../../../../core/diagnostics/app_diagnostics.dart';
import '../../../../core/foundation/result.dart';
import '../models/diagnostics_failure.dart';
import '../repos/diagnostics_export_repository.dart';

@injectable
class DiagnosticsWorkflow {
  DiagnosticsWorkflow(this._diagnostics, this._exporter);

  final AppDiagnostics _diagnostics;
  final DiagnosticsExportRepository _exporter;

  Future<Result<bool, DiagnosticsFailure>> export() async {
    try {
      final sourcePath = await _diagnostics.exportPath();
      if (sourcePath == null) {
        return const Result.success(false);
      }
      return Result.success(await _exporter.export(sourcePath));
    } catch (_) {
      return const Result.failure(DiagnosticsFailure.export);
    }
  }

  Future<Result<bool, DiagnosticsFailure>> clear() async {
    try {
      await _diagnostics.clear();
      return const Result.success(true);
    } catch (_) {
      return const Result.failure(DiagnosticsFailure.clear);
    }
  }
}
