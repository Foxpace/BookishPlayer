import 'package:injectable/injectable.dart';
import 'package:sembast/sembast.dart';

import '../../../../core/database/bookish_database.dart';
import '../listening_history_repository.dart';
import '../../models/listening_session.dart';
import 'book_storage_codec.dart';

@LazySingleton(as: ListeningHistoryRepository)
class ListeningHistoryDao implements ListeningHistoryRepository {
  ListeningHistoryDao(BookishDatabase database) : _database = database.database;

  final Database _database;
  final _sessions = stringMapStoreFactory.store('listening_sessions');

  @override
  Future<List<ListeningSession>> getListeningSessions() async {
    final records = await _sessions.find(
      _database,
      finder: Finder(sortOrders: [SortOrder('startedAt', false)]),
    );
    return [
      for (final record in records)
        _parseSession(record.key, Map<String, dynamic>.from(record.value)),
    ];
  }

  @override
  Future<void> saveListeningSession(ListeningSession session) async {
    final metadataId = session.metadataId;
    if (metadataId.isEmpty) {
      throw StateError('Listening sessions require a metadata identity.');
    }
    await _sessions
        .record(session.id)
        .put(_database, listeningSessionStorageJson(session, metadataId));
  }

  ListeningSession _parseSession(String id, Map<String, dynamic> value) {
    try {
      return ListeningSession.fromJson(value);
    } catch (error) {
      throw FormatException(
        'Could not parse listening session record "$id": $error',
      );
    }
  }
}
