abstract interface class AppDiagnostics {
  Future<void> record(
    Object error,
    StackTrace stackTrace, {
    required String operation,
  });

  Future<String?> exportPath();

  Future<void> clear();
}
