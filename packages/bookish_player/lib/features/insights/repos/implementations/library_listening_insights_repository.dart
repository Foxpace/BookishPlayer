import 'package:injectable/injectable.dart';

import '../../../library/models/library_models.dart';
import '../../../library/repos/book_metadata_repository.dart';
import '../../../library/repos/listening_history_repository.dart';
import '../../../library/models/listening_session.dart';
import '../listening_insights_repository.dart';

@LazySingleton(as: ListeningInsightsRepository)
class LibraryListeningInsightsRepository
    implements ListeningInsightsRepository {
  const LibraryListeningInsightsRepository(this._metadata, this._history);

  final BookMetadataRepository _metadata;
  final ListeningHistoryRepository _history;

  @override
  Future<List<BookMetadata>> loadMetadata() => _metadata.getBookMetadata();

  @override
  Future<List<ListeningSession>> loadSessions() =>
      _history.getListeningSessions();
}
