import 'package:uuid/uuid.dart';

import '../../library/domain/audiobook.dart';
import '../../library/domain/listening_history_repository.dart';
import '../../library/domain/listening_session.dart';

class ListeningSessionTracker {
  ListeningSessionTracker(this._history);

  final ListeningHistoryRepository _history;
  final _uuid = const Uuid();
  DateTime? _startedAt;
  Duration? _startPosition;

  void start(Duration position) {
    _startedAt ??= DateTime.now();
    _startPosition ??= position;
  }

  Future<void> finish({
    required Audiobook? book,
    required Duration position,
    required double speed,
  }) async {
    final startedAt = _startedAt;
    final startPosition = _startPosition;
    _startedAt = null;
    _startPosition = null;
    if (startedAt == null || startPosition == null || book == null) {
      return;
    }
    final endedAt = DateTime.now();
    final listened = endedAt.difference(startedAt);
    if (listened < const Duration(seconds: 2)) {
      return;
    }
    await _history.saveListeningSession(
      ListeningSession(
        id: _uuid.v4(),
        bookId: book.id,
        startedAt: startedAt,
        endedAt: endedAt,
        listenedMs: listened.inMilliseconds,
        startPositionMs: startPosition.inMilliseconds,
        endPositionMs: position.inMilliseconds,
        speed: speed,
      ),
    );
  }
}
