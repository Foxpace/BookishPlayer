import 'package:bookish_player/features/portability/models/bookish_backup.dart';
import 'package:bookish_player/features/portability/repos/local_export_repository.dart';
import 'player_test_support.dart';

class FakeExports implements LocalExportRepository {
  @override
  Future<bool> exportBackup(BookishBackup backup) async => true;
  @override
  Future<bool> exportNotes(Audiobook book, List<BookNote> notes) async => true;
  @override
  Future<BookishBackup?> pickBackup() async => null;
}
