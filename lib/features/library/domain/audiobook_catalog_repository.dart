import 'audiobook.dart';

abstract interface class AudiobookCatalogRepository {
  Future<List<Audiobook>> getBooks();
  Future<Audiobook?> getBook(String id);
  Future<void> saveBook(Audiobook book);
  Future<void> updateProgress(String id, Duration position);
  Future<void> updatePlaybackSpeed(String id, double speed);
  Future<void> deleteBook(String id);
}
