import '../models/library_models.dart';

abstract interface class BookMetadataRepository {
  Future<List<BookMetadata>> getBookMetadata();
  Future<BookMetadata?> findBookMetadata(String fingerprint);
}
