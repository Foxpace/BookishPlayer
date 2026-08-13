import 'dart:async';

import 'package:injectable/injectable.dart';

import '../../library/models/library_models.dart';
import '../../library/repos/audiobook_catalog_repository.dart';
import '../../settings/repos/settings_repository.dart';
import '../repos/audio_player_repository.dart';
import '../models/playback_open_result.dart';

part 'playback_book_request_completion.dart';

typedef PlaybackBookRequest = ({String bookId, Completer<void> completion});

@lazySingleton
class PlaybackCommandService {
  PlaybackCommandService(this._audio, this._books, this._settings);

  final AudioPlayerRepository _audio;
  final AudiobookCatalogRepository _books;
  final SettingsRepository _settings;
  final _playRequests = StreamController<PlaybackBookRequest>();

  Stream<PlaybackBookRequest> get playRequests => _playRequests.stream;

  Future<PlaybackOpenResult> openById(String bookId) async {
    final book = await _books.getBook(bookId);
    if (book == null) {
      throw StateError('Audiobook $bookId is no longer in the library.');
    }
    return open(book);
  }

  Future<PlaybackOpenResult> open(
    Audiobook book, {
    Audiobook? previousBook,
  }) async {
    if (previousBook != null) {
      if (previousBook.id != book.id) {
        await _audio.pause();
      }
      if (previousBook.isFinished == false) {
        await _books.updateProgress(previousBook.id, _audio.position);
      }
    }

    final preferences = await _settings.getPlaybackPreferences();
    await _audio.load(book);
    await _audio.setSpeed(book.playbackSpeed);
    await _audio.setSkipIntervals(
      Duration(seconds: preferences.rewindSeconds),
      Duration(seconds: preferences.forwardSeconds),
    );
    await _audio.setShortenSilence(enabled: preferences.shortenSilence);
    await _audio.setVoiceBoost(enabled: preferences.voiceBoost);

    return PlaybackOpenResult(book: book, preferences: preferences);
  }

  Future<void> playBook(String bookId) {
    final completion = Completer<void>();
    _playRequests.add((bookId: bookId, completion: completion));
    return completion.future;
  }

  Future<void> removeCurrentBook() => _audio.pause();

  Future<void> reset() => _audio.clear();

  Future<void> toggle() => _audio.isPlaying ? _audio.pause() : _audio.play();
}
