import '../models/listening_session.dart';

abstract interface class ListeningHistoryRepository {
  Future<List<ListeningSession>> getListeningSessions();
  Future<void> saveListeningSession(ListeningSession session);
}
