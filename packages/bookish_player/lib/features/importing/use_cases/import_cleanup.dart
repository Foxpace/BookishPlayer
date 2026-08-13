import 'package:injectable/injectable.dart';

import '../../../core/diagnostics/app_diagnostics.dart';
import '../repos/import_repositories.dart';

@injectable
class ImportCleanup {
  ImportCleanup(this._files, this._diagnostics);

  final FileImportRepository _files;
  final AppDiagnostics _diagnostics;

  Future<void> deletePendingFiles(Set<String> paths) async {
    for (final path in paths.toList()) {
      try {
        await _files.deleteImportedFile(path);
      } catch (error, stackTrace) {
        await _diagnostics.record(
          error,
          stackTrace,
          operation: 'import.cleanup.pending_file',
        );
      }
    }
    paths.clear();
  }

  Future<void> clearPickerCache() async {
    try {
      await _files.clearTemporaryFiles();
    } catch (error, stackTrace) {
      await _diagnostics.record(
        error,
        stackTrace,
        operation: 'import.cleanup.picker_cache',
      );
    }
  }
}
