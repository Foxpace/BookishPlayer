import 'package:bookish_player/features/library/models/library_models.dart';
import 'package:bookish_player/features/library/models/audiobook_removal_mode.dart';
import 'package:bookish_player/features/library/repos/audiobook_catalog_repository.dart';
import 'package:bookish_player/features/library/repos/book_metadata_repository.dart';

class FakeImportBooks
    implements AudiobookCatalogRepository, BookMetadataRepository {
  FakeImportBooks(this.events);
  final List<String> events;
  final saved = <Audiobook>[];

  @override
  Future<void> deleteBook(
    String id, {
    AudiobookRemovalMode mode = AudiobookRemovalMode.keepUserData,
  }) async {}
  @override
  Future<BookMetadata?> findBookMetadata(String fingerprint) async => null;
  @override
  Future<Audiobook?> getBook(String id) async => saved
      .cast<Audiobook?>()
      .firstWhere((book) => book?.id == id, orElse: () => null);
  @override
  Future<List<BookMetadata>> getBookMetadata() async => const [];
  @override
  Future<List<Audiobook>> getBooks() async => saved;
  @override
  Future<void> saveBook(Audiobook book) async {
    saved.add(book);
    events.add('save');
  }

  @override
  Future<void> updatePlaybackSpeed(String id, double speed) async {}
  @override
  Future<void> updateProgress(String id, Duration position) async {}
}
