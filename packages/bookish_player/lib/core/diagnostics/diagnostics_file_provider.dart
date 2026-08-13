import 'dart:io';

abstract interface class DiagnosticsFileProvider {
  Future<File> diagnosticsFile();
}
