import 'package:injectable/injectable.dart';

import '../../library/models/library_models.dart';
import '../../library/repos/audiobook_catalog_repository.dart';
import '../repos/audio_player_repository.dart';
import 'chapter_navigation_policy.dart';
import 'playback_command_service.dart';

@lazySingleton
class PlayerTransportUseCases {
  const PlayerTransportUseCases(
    this._audio,
    this._books,
    this._commands,
    this._chapters,
  );

  final AudioPlayerRepository _audio;
  final AudiobookCatalogRepository _books;
  final PlaybackCommandService _commands;
  final ChapterNavigationPolicy _chapters;

  Future<void> pause() => _audio.pause();

  Future<void> toggle({
    required bool ready,
    required Audiobook? book,
    required Duration position,
    required Duration duration,
  }) async {
    if (!ready) {
      return;
    }
    if (_audio.isPlaying) {
      await _commands.toggle();
      return;
    }
    if (position >= duration && duration > Duration.zero) {
      await _audio.seek(Duration.zero);
    }
    await _commands.toggle();
  }

  Future<Duration> seek({
    required Audiobook? book,
    required Duration value,
    required Duration duration,
  }) async {
    final target = _clamp(value, duration);
    await _audio.seek(target);
    return target;
  }

  Future<Duration> seekWithinChapter({
    required Audiobook? book,
    required Duration value,
    required Duration duration,
    required Duration chapterStart,
    required Duration chapterDuration,
  }) {
    final maximum = chapterDuration > Duration.zero
        ? chapterDuration - const Duration(milliseconds: 1)
        : Duration.zero;
    return seek(
      book: book,
      value: chapterStart + _clamp(value, maximum),
      duration: duration,
    );
  }

  Future<Duration?> previousChapter({
    required Audiobook? book,
    required Duration duration,
    required int index,
    required Duration chapterPosition,
    required Duration chapterStart,
  }) {
    if (book == null || book.chapters.isEmpty) {
      return Future.value();
    }

    return seek(
      book: book,
      duration: duration,
      value: _chapters.selectPreviousChapter(
        book: book,
        index: index,
        chapterPosition: chapterPosition,
        chapterStart: chapterStart,
      ),
    );
  }

  Future<Duration?> nextChapter({
    required Audiobook? book,
    required Duration duration,
    required int index,
  }) {
    if (book == null || book.chapters.isEmpty) {
      return Future.value();
    }
    return seek(
      book: book,
      duration: duration,
      value: _chapters.selectNextChapter(book, index),
    );
  }

  Future<Audiobook?> changeSpeed(Audiobook? book, double speed) async {
    await _audio.setSpeed(speed);
    if (book == null) {
      return null;
    }
    await _books.updatePlaybackSpeed(book.id, speed);
    return book.copyWith(playbackSpeed: speed);
  }

  Duration _clamp(Duration value, Duration maximum) {
    if (value < Duration.zero) {
      return Duration.zero;
    }
    return maximum > Duration.zero && value > maximum ? maximum : value;
  }
}
