import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

import '../../library/domain/audiobook.dart';
import '../../library/domain/audiobook_catalog_repository.dart';
import '../application/playback_command_service.dart';

class BookishAudioHandler extends BaseAudioHandler with SeekHandler {
  BookishAudioHandler(this._player, this._books, this._commands) {
    _player.playbackEventStream.listen(_broadcastState);
    _player.playingStream.listen((_) => _broadcastState(_player.playbackEvent));
    _player.sequenceStream.listen((_) => _broadcastQueue());
    _player.currentIndexStream.listen((_) => _broadcastCurrentItem());
  }

  static const skipInterval = Duration(seconds: 15);

  final AudiobookCatalogRepository _books;
  final PlaybackCommandService _commands;
  Duration _rewindInterval = skipInterval;
  Duration _forwardInterval = skipInterval;
  final AudioPlayer _player;

  @override
  Future<List<MediaItem>> getChildren(
    String parentMediaId, [
    Map<String, dynamic>? options,
  ]) async {
    if (parentMediaId != AudioService.browsableRootId) {
      return const [];
    }
    return (await _books.getBooks()).map(_bookMediaItem).toList();
  }

  @override
  Future<MediaItem?> getMediaItem(String mediaId) async {
    final book = await _books.getBook(mediaId);
    return book == null ? null : _bookMediaItem(book);
  }

  @override
  Future<void> playFromMediaId(
    String mediaId, [
    Map<String, dynamic>? extras,
  ]) async {
    await _commands.playBook(mediaId);
  }

  MediaItem _bookMediaItem(Audiobook book) => MediaItem(
    id: book.id,
    title: book.title,
    album: book.series.isEmpty ? null : book.series,
    artist: book.author.isEmpty ? null : book.author,
    artUri: book.artworkPath == null ? null : Uri.file(book.artworkPath!),
    duration: Duration(milliseconds: book.durationMs),
    playable: true,
  );

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> rewind() => _seekBy(-_rewindInterval);

  @override
  Future<void> fastForward() => _seekBy(_forwardInterval);

  @override
  Future<void> skipToNext() async {
    if (_player.hasNext) {
      await _player.seek(Duration.zero, index: _player.nextIndex);
    }
  }

  @override
  Future<void> skipToPrevious() async {
    if (_player.hasPrevious) {
      await _player.seek(Duration.zero, index: _player.previousIndex);
    }
  }

  @override
  Future<void> skipToQueueItem(int index) =>
      _player.seek(Duration.zero, index: index);

  @override
  Future<dynamic> customAction(
    String name, [
    Map<String, dynamic>? extras,
  ]) async {
    if (name == 'setSpeed') {
      final speed = extras?['speed'];
      if (speed is! num) {
        throw ArgumentError.value(speed, 'speed', 'must be a number');
      }
      await _player.setSpeed(speed.toDouble());
      return null;
    }
    if (name == 'setSkipIntervals') {
      _rewindInterval = Duration(
        milliseconds: extras?['rewindMs'] as int? ?? 15000,
      );
      _forwardInterval = Duration(
        milliseconds: extras?['forwardMs'] as int? ?? 15000,
      );
      _broadcastState(_player.playbackEvent);
      return null;
    }
    return super.customAction(name, extras);
  }

  @override
  Future<void> stop() => _player.stop();

  Future<void> _seekBy(Duration delta) async {
    final sequence = _player.sequence;
    final currentIndex = _player.currentIndex;
    if (sequence.isEmpty || currentIndex == null) {
      return;
    }
    final target = relativeSeekTarget(
      durations: [for (final source in sequence) _durationOf(source)],
      currentIndex: currentIndex,
      currentPosition: _player.position,
      delta: delta,
    );
    await _player.seek(target.position, index: target.index);
  }

  Duration _durationOf(IndexedAudioSource source) =>
      source.duration ??
      (source.tag is MediaItem ? (source.tag as MediaItem).duration : null) ??
      Duration.zero;

  void _broadcastQueue() {
    final items = [
      for (final source in _player.sequence)
        if (source.tag is MediaItem) source.tag as MediaItem,
    ];
    queue.add(items);
    _broadcastCurrentItem();
  }

  void _broadcastCurrentItem() {
    final sequence = _player.sequence;
    final index = _player.currentIndex;
    if (index == null || index >= sequence.length) {
      return;
    }
    final tag = sequence[index].tag;
    if (tag is MediaItem) {
      mediaItem.add(tag);
    }
  }

  void _broadcastState(PlaybackEvent event) {
    playbackState.add(
      PlaybackState(
        controls: [
          MediaControl.skipToPrevious,
          MediaControl(
            androidIcon: 'drawable/ic_replay_15',
            label: 'Rewind ${_rewindInterval.inSeconds} seconds',
            action: MediaAction.rewind,
          ),
          if (_player.playing) MediaControl.pause else MediaControl.play,
          MediaControl(
            androidIcon: 'drawable/ic_forward_15',
            label: 'Forward ${_forwardInterval.inSeconds} seconds',
            action: MediaAction.fastForward,
          ),
          MediaControl.skipToNext,
        ],
        systemActions: const {
          MediaAction.seek,
          MediaAction.seekForward,
          MediaAction.seekBackward,
        },
        androidCompactActionIndices: const [1, 2, 3],
        processingState: switch (_player.processingState) {
          ProcessingState.idle => AudioProcessingState.idle,
          ProcessingState.loading => AudioProcessingState.loading,
          ProcessingState.buffering => AudioProcessingState.buffering,
          ProcessingState.ready => AudioProcessingState.ready,
          ProcessingState.completed => AudioProcessingState.completed,
        },
        playing: _player.playing,
        updatePosition: _player.position,
        bufferedPosition: _player.bufferedPosition,
        speed: _player.speed,
        queueIndex: event.currentIndex,
      ),
    );
  }
}

({int index, Duration position}) relativeSeekTarget({
  required List<Duration> durations,
  required int currentIndex,
  required Duration currentPosition,
  required Duration delta,
}) {
  if (durations.isEmpty) {
    return (index: 0, position: Duration.zero);
  }
  var index = currentIndex.clamp(0, durations.length - 1).toInt();
  var milliseconds = currentPosition.inMilliseconds + delta.inMilliseconds;

  while (milliseconds < 0 && index > 0) {
    index--;
    milliseconds += durations[index].inMilliseconds;
  }
  while (milliseconds > durations[index].inMilliseconds &&
      index < durations.length - 1) {
    milliseconds -= durations[index].inMilliseconds;
    index++;
  }

  return (
    index: index,
    position: Duration(
      milliseconds: milliseconds
          .clamp(0, durations[index].inMilliseconds)
          .toInt(),
    ),
  );
}
