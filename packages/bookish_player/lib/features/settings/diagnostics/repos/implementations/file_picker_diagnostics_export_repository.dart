import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';

import '../diagnostics_export_repository.dart';

@LazySingleton(as: DiagnosticsExportRepository)
class FilePickerDiagnosticsExportRepository
    implements DiagnosticsExportRepository {
  @override
  Future<bool> export(String sourcePath) async {
    final source = File(sourcePath);
    if (!source.existsSync()) {
      return false;
    }
    final path = await FilePicker.platform.saveFile(
      fileName: 'bookish-diagnostics.jsonl',
      type: FileType.custom,
      allowedExtensions: const ['jsonl'],
      bytes: source.readAsBytesSync(),
    );
    return path != null;
  }
}
