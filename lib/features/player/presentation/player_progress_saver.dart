import '../../library/domain/audiobook.dart';
import '../../library/domain/audiobook_repository.dart';
import '../domain/audio_player_repository.dart';

class PlayerProgressSaver {
  PlayerProgressSaver(this._audio, this._books);

  final AudioPlayerRepository _audio;
  final AudiobookRepository _books;
  var _lastSavedAt = DateTime.fromMillisecondsSinceEpoch(0);
  var _writeInFlight = false;
  ({String bookId, Duration position})? _pending;

  bool get checkpointDue =>
      DateTime.now().difference(_lastSavedAt) >=
      const Duration(milliseconds: 250);

  Future<void> save(Audiobook? book) async {
    if (book == null) {
      return;
    }
    _pending = (bookId: book.id, position: _audio.position);
    if (_writeInFlight) {
      return;
    }
    _writeInFlight = true;
    try {
      while (true) {
        final pending = _pending;
        if (pending == null) {
          break;
        }
        _pending = null;
        await _books.updateProgress(pending.bookId, pending.position);
        _lastSavedAt = DateTime.now();
      }
    } finally {
      _writeInFlight = false;
    }
  }
}
