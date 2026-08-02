import '../../library/domain/audiobook.dart';
import '../../player/domain/book_note.dart';

abstract interface class LocalExportRepository {
  Future<bool> exportNotes(Audiobook book, List<BookNote> notes);
  Future<bool> exportBackup(Map<String, dynamic> backup);
  Future<Map<String, dynamic>?> pickBackup();
}
