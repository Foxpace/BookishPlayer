import '../../library/models/library_models.dart';
import '../../library/models/listening_session.dart';

abstract interface class ListeningInsightsRepository {
  Future<List<BookMetadata>> loadMetadata();

  Future<List<ListeningSession>> loadSessions();
}
