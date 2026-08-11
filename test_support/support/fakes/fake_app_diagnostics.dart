import 'package:bookish_player/core/diagnostics/app_diagnostics.dart';

class FakeAppDiagnostics implements AppDiagnostics {
  String? path;
  var clearCalls = 0;
  final operations = <String>[];

  @override
  Future<void> clear() async {
    clearCalls++;
  }

  @override
  Future<String?> exportPath() async => path;

  @override
  Future<void> record(
    Object error,
    StackTrace stackTrace, {
    required String operation,
  }) async {
    operations.add(operation);
  }
}
