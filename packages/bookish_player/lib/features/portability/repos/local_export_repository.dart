import '../../library/models/library_models.dart';
import '../../notes/models/book_note.dart';
import '../models/bookish_backup.dart';

abstract interface class LocalExportRepository {
  Future<bool> exportNotes(Audiobook book, List<BookNote> notes);
  Future<bool> exportBackup(BookishBackup backup);
  Future<BookishBackup?> pickBackup();
}
