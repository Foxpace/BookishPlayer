import 'package:injectable/injectable.dart';

import '../../../core/foundation/clock.dart';
import '../../../core/foundation/id_generator.dart';
import '../../library/models/library_models.dart';
import '../../library/repos/listening_history_repository.dart';
import '../../library/models/listening_session.dart';

@injectable
class ListeningSessionTracker {
  const ListeningSessionTracker(this._history, this._clock, this._ids);

  final ListeningHistoryRepository _history;
  final Clock _clock;
  final IdGenerator _ids;
  ({DateTime startedAt, Duration startPosition}) start(Duration position) =>
      (startedAt: _clock.now(), startPosition: position);

  Future<void> finish({
    required DateTime? startedAt,
    required Duration? startPosition,
    required Audiobook? book,
    required Duration position,
    required double speed,
  }) async {
    if (startedAt == null || startPosition == null || book == null) {
      return;
    }

    final endedAt = _clock.now();
    final listened = endedAt.difference(startedAt);
    if (listened < const Duration(seconds: 2)) {
      return;
    }

    await _history.saveListeningSession(
      _buildSession(
        book: book,
        timing: (startedAt: startedAt, endedAt: endedAt, listened: listened),
        playback: (
          startPosition: startPosition,
          endPosition: position,
          speed: speed,
        ),
      ),
    );
  }

  ListeningSession _buildSession({
    required Audiobook book,
    required ({DateTime startedAt, DateTime endedAt, Duration listened}) timing,
    required ({Duration startPosition, Duration endPosition, double speed})
    playback,
  }) => ListeningSession(
    id: _ids.generate(),
    metadataId: book.metadataId,
    startedAt: timing.startedAt,
    endedAt: timing.endedAt,
    listenedMs: timing.listened.inMilliseconds,
    startPositionMs: playback.startPosition.inMilliseconds,
    endPositionMs: playback.endPosition.inMilliseconds,
    speed: playback.speed,
  );
}
