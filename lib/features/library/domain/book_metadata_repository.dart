import 'book_metadata.dart';

abstract interface class BookMetadataRepository {
  Future<List<BookMetadata>> getBookMetadata();
  Future<BookMetadata?> findBookMetadata(String fingerprint);
}
