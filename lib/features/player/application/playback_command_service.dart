import 'dart:async';

import 'package:injectable/injectable.dart';

import '../../library/domain/audiobook.dart';
import '../../library/domain/audiobook_catalog_repository.dart';
import '../../settings/domain/settings_repository.dart';
import '../domain/audio_player_repository.dart';
import 'playback_open_result.dart';

@lazySingleton
class PlaybackCommandService {
  PlaybackCommandService(this._audio, this._books, this._settings);

  final AudioPlayerRepository _audio;
  final AudiobookCatalogRepository _books;
  final SettingsRepository _settings;
  final _opened = StreamController<PlaybackOpenResult>.broadcast();
  Audiobook? _currentBook;

  Stream<PlaybackOpenResult> get opened => _opened.stream;

  Future<PlaybackOpenResult> openById(String bookId) async {
    final book = await _books.getBook(bookId);
    if (book == null) {
      throw StateError('Audiobook $bookId is no longer in the library.');
    }
    return open(book);
  }

  Future<PlaybackOpenResult> open(Audiobook book) async {
    final previous = _currentBook;
    if (previous != null) {
      if (previous.id != book.id) {
        await _audio.pause();
      }
      if (!previous.isFinished) {
        await _books.updateProgress(previous.id, _audio.position);
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
    _currentBook = book;
    final result = PlaybackOpenResult(book: book, preferences: preferences);
    _opened.add(result);
    return result;
  }

  Future<void> playBook(String bookId) async {
    if (_currentBook?.id != bookId) {
      await openById(bookId);
    }
    if (!_audio.isPlaying) {
      await _audio.play();
    }
  }

  Future<void> removeBook(String bookId) async {
    if (_currentBook?.id != bookId) {
      return;
    }
    await _audio.pause();
    _currentBook = null;
  }

  void markCompleted(Audiobook book) {
    if (_currentBook?.id == book.id) {
      _currentBook = book;
    }
  }

  Future<void> toggle() => _audio.isPlaying ? _audio.pause() : _audio.play();
}
