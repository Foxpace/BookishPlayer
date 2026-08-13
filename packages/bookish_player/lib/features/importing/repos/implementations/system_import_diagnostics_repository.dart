import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

import '../import_diagnostics_repository.dart';

@LazySingleton(as: ImportDiagnosticsRepository)
class SystemImportDiagnosticsRepository implements ImportDiagnosticsRepository {
  @override
  Future<void> copy(String diagnostics) =>
      Clipboard.setData(ClipboardData(text: diagnostics));
}
