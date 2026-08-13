abstract interface class DiagnosticsExportRepository {
  Future<bool> export(String sourcePath);
}
