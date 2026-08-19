import 'package:injectable/injectable.dart';

import '../../../../core/diagnostics/app_diagnostics.dart';
import '../../../../core/foundation/result.dart';
import '../repos/diagnostics_export_repository.dart';

@injectable
class DiagnosticsWorkflow {
  DiagnosticsWorkflow(this._diagnostics, this._exporter);

  final AppDiagnostics _diagnostics;
  final DiagnosticsExportRepository _exporter;

  Future<Result<bool>> export() async {
    try {
      return await _export();
    } catch (error) {
      return Result.failure(
        AppFailure.operationFailed('diagnostics.export', error: error),
      );
    }
  }

  Future<Result<bool>> _export() async {
    final sourcePath = await _diagnostics.exportPath();
    if (sourcePath == null) {
      return const Result.success(false);
    }
    return Result.success(await _exporter.export(sourcePath));
  }

  Future<Result<bool>> clear() async {
    try {
      return await _clear();
    } catch (error) {
      return Result.failure(
        AppFailure.operationFailed('diagnostics.clear', error: error),
      );
    }
  }

  Future<Result<bool>> _clear() async {
    await _diagnostics.clear();
    return const Result.success(true);
  }
}
