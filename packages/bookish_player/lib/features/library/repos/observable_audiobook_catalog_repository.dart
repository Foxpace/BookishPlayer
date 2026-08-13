import '../models/library_models.dart';
import 'audiobook_catalog_repository.dart';

abstract interface class ObservableAudiobookCatalogRepository
    implements AudiobookCatalogRepository {
  Stream<List<Audiobook>> watchBooks();
}
