import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'diagnostics_file_provider.dart';

@LazySingleton(as: DiagnosticsFileProvider)
class AppSupportDiagnosticsFileProvider implements DiagnosticsFileProvider {
  @override
  Future<File> diagnosticsFile() async {
    final directory = await getApplicationSupportDirectory();
    return File(p.join(directory.path, 'bookish-diagnostics.jsonl'));
  }
}
