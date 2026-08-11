import 'package:bookish_player/features/importing/repos/import_diagnostics_repository.dart';

class FakeImportDiagnostics implements ImportDiagnosticsRepository {
  @override
  Future<void> copy(String diagnostics) async {}
}
