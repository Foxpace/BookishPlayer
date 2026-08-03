import 'audiobook.dart';
import 'audiobook_catalog_repository.dart';

abstract interface class ObservableAudiobookCatalogRepository
    implements AudiobookCatalogRepository {
  Stream<List<Audiobook>> watchBooks();
}
