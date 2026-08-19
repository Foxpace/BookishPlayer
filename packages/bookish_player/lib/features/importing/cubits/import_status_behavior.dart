import 'import_status.dart';

extension ImportStatusBehavior on ImportStatus {
  bool get isActive => this == ImportStatus.importing;
}
