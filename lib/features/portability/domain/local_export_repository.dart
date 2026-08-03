import '../../library/domain/audiobook.dart';
import '../../player/domain/book_note.dart';
import 'bookish_backup.dart';

abstract interface class LocalExportRepository {
  Future<bool> exportNotes(Audiobook book, List<BookNote> notes);
  Future<bool> exportBackup(BookishBackup backup);
  Future<BookishBackup?> pickBackup();
}
