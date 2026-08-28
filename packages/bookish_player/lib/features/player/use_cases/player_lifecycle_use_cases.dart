import 'package:injectable/injectable.dart';

import '../../library/models/library_models.dart';
import '../../library/repos/audiobook_catalog_repository.dart';
import '../../notes/use_cases/player_notes_service.dart';
import '../../notes/models/book_note.dart';
import '../repos/audio_player_repository.dart';
import 'player_lifecycle_policies.dart';
import 'playback_command_service.dart';
import '../models/playback_open_result.dart';
import 'playback_resume_policy.dart';

typedef PlayerCompletionResult = ({
  Audiobook finishedBook,
  Duration position,
  Audiobook? nextBook,
});
typedef PlayerPlayingResult = ({
  bool playing,
  Duration? position,
  bool shouldSave,
  DateTime? pausedAt,
  bool wasPlaying,
});

@lazySingleton
class PlayerLifecycleUseCases {
  const PlayerLifecycleUseCases(
    this._audio,
    this._books,
    this._commands,
    this._policies,
    this._notes,
  );

  final AudioPlayerRepository _audio;
  final AudiobookCatalogRepository _books;
  final PlaybackCommandService _commands;
  final PlayerLifecyclePolicies _policies;
  final PlayerNotesService _notes;

  /// Opens a selected audiobook and applies the complete playback setup.
  Future<PlaybackOpenResult> openBook(
    Audiobook book, {
    Audiobook? previousBook,
  }) => _commands.open(book, previousBook: previousBook);

  /// Resolves a route or external intent into a library audiobook.
  Future<Audiobook?> findBook(String bookId) => _books.getBook(bookId);

  Future<Audiobook?> findLastListenedBook() async {
    Audiobook? lastListenedBook;

    for (final book in await _books.getBooks()) {
      final playedAt = book.lastPlayedAt;
      if (playedAt == null ||
          book.listeningStatus != ListeningStatus.inProgress) {
        continue;
      }

      final lastPlayedAt = lastListenedBook?.lastPlayedAt;
      if (lastPlayedAt == null || playedAt.isAfter(lastPlayedAt)) {
        lastListenedBook = book;
      }
    }

    return lastListenedBook;
  }

  /// Starts playback after automatic continuation selected another book.
  Future<void> continuePlayback() => _audio.play();

  Future<void> resetForAppDataRemoval() => _commands.reset();

  Future<bool> removeBook({
    required Audiobook? currentBook,
    required String bookId,
  }) async {
    if (currentBook?.id != bookId) {
      return false;
    }
    await _commands.removeCurrentBook();
    return true;
  }

  Future<PlayerCompletionResult?> complete({
    required Audiobook? currentBook,
    required Duration duration,
    required bool continueSeries,
  }) async {
    if (currentBook == null) {
      return null;
    }
    final position = duration > Duration.zero
        ? duration
        : Duration(milliseconds: currentBook.durationMs);
    final completedAt = _policies.now();
    final finished = currentBook.markCompleted(
      position: position,
      at: completedAt,
    );

    await _books.saveBook(finished);

    final nextBook = await _selectNextBook(finished, continueSeries);
    return (finishedBook: finished, position: position, nextBook: nextBook);
  }

  Future<Audiobook?> _selectNextBook(
    Audiobook finished,
    bool continueSeries,
  ) async {
    if (!continueSeries || finished.series.trim().isEmpty) {
      return null;
    }
    return _policies.selectNext(finished, await _books.getBooks());
  }

  Future<List<BookNote>> prepareOpened({required PlaybackOpenResult result}) =>
      _notes.load(result.book.id);

  ({DateTime startedAt, Duration startPosition}) startListeningSession(
    Duration position,
  ) => _policies.startSession(position);

  Future<PlayerPlayingResult> updatePlaying(
    ({
      bool playing,
      Audiobook? book,
      Duration position,
      Duration duration,
      Duration chapterStart,
      bool wasPlaying,
      DateTime? pausedAt,
    })
    playback,
  ) async {
    final action = _policies.evaluateResume(
      playing: playback.playing,
      wasPlaying: playback.wasPlaying,
      pausedAt: playback.pausedAt,
      position: playback.position,
      chapterStart: playback.chapterStart,
    );

    if (action.rewind == Duration.zero) {
      return _playingResult(playback.playing, action);
    }

    final target = _clamp(playback.position - action.rewind, playback.duration);
    await _audio.seek(target);

    return _playingResult(
      playback.playing,
      action,
      position: target,
      shouldSave: true,
    );
  }

  PlayerPlayingResult _playingResult(
    bool playing,
    PlaybackResumeDecision action, {
    Duration? position,
    bool? shouldSave,
  }) {
    return (
      playing: playing,
      position: position,
      shouldSave: shouldSave ?? action.shouldSave,
      pausedAt: action.pausedAt,
      wasPlaying: action.wasPlaying,
    );
  }

  Future<void> finishListeningSession({
    required DateTime? startedAt,
    required Duration? startPosition,
    required Audiobook? book,
    required Duration position,
    required double speed,
  }) => _policies.finishSession(
    startedAt: startedAt,
    startPosition: startPosition,
    book: book,
    position: position,
    speed: speed,
  );

  Duration _clamp(Duration value, Duration maximum) {
    if (value < Duration.zero) {
      return Duration.zero;
    }
    return maximum > Duration.zero && value > maximum ? maximum : value;
  }
}
