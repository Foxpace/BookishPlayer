import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

import '../../../library/models/library_models.dart';
import '../../../library/repos/audiobook_catalog_repository.dart';
import '../../use_cases/playback_command_service.dart';

class BookishAudioHandler extends BaseAudioHandler with SeekHandler {
  BookishAudioHandler(this._player, this._books, this._commands) {
    _player.playerEventStream.listen(_broadcastState);
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
    return (await _books.getBooks()).map(_buildBookMediaItem).toList();
  }

  @override
  Future<MediaItem?> getMediaItem(String mediaId) async {
    final book = await _books.getBook(mediaId);
    return book == null ? null : _buildBookMediaItem(book);
  }

  @override
  Future<void> playFromMediaId(
    String mediaId, [
    Map<String, dynamic>? extras,
  ]) async {
    await _commands.playBook(mediaId);
  }

  MediaItem _buildBookMediaItem(Audiobook book) => MediaItem(
    id: book.id,
    title: book.title,
    album: book.series.isEmpty ? null : book.series,
    artist: book.author.isEmpty ? null : book.author,
    artUri: switch (book.artworkPath) {
      final path? => Uri.file(path),
      null => null,
    },
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
  Future<Object?> customAction(
    String name, [
    Map<String, dynamic>? extras,
  ]) async {
    if (name == 'setSpeed') {
      await _setSpeed(extras);
      return null;
    }

    if (name == 'setSkipIntervals') {
      _setSkipIntervals(extras);
      return null;
    }

    return super.customAction(name, extras);
  }

  Future<void> _setSpeed(Map<String, dynamic>? extras) async {
    final speed = extras?['speed'];
    if (speed is num) {
      await _player.setSpeed(speed.toDouble());
      return;
    }

    throw ArgumentError.value(speed, 'speed', 'must be a number');
  }

  void _setSkipIntervals(Map<String, dynamic>? extras) {
    _rewindInterval = Duration(
      milliseconds: extras?['rewindMs'] as int? ?? 15000,
    );
    _forwardInterval = Duration(
      milliseconds: extras?['forwardMs'] as int? ?? 15000,
    );

    _broadcastState(_player.playerEvent);
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
      durations: [for (final source in sequence) _calculateDuration(source)],
      currentIndex: currentIndex,
      currentPosition: _player.position,
      delta: delta,
    );
    await _player.seek(target.position, index: target.index);
  }

  Duration _calculateDuration(IndexedAudioSource source) =>
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

  void _broadcastState(PlayerEvent event) {
    playbackState.add(_buildPlaybackState(event));
  }

  PlaybackState _buildPlaybackState(PlayerEvent event) => PlaybackState(
    controls: _mediaControls(playing: event.playing),
    systemActions: const {
      MediaAction.seek,
      MediaAction.seekForward,
      MediaAction.seekBackward,
    },
    androidCompactActionIndices: const [1, 2, 3],
    processingState: _audioProcessingState(event.playbackEvent.processingState),
    playing: event.playing,
    updatePosition: event.playbackEvent.updatePosition,
    bufferedPosition: event.playbackEvent.bufferedPosition,
    speed: _player.speed,
    updateTime: event.playbackEvent.updateTime,
    queueIndex: event.playbackEvent.currentIndex,
  );

  List<MediaControl> _mediaControls({required bool playing}) => [
    MediaControl.skipToPrevious,
    MediaControl(
      androidIcon: 'drawable/ic_replay_15',
      label: 'Rewind ${_rewindInterval.inSeconds} seconds',
      action: MediaAction.rewind,
    ),
    if (playing) MediaControl.pause else MediaControl.play,
    MediaControl(
      androidIcon: 'drawable/ic_forward_15',
      label: 'Forward ${_forwardInterval.inSeconds} seconds',
      action: MediaAction.fastForward,
    ),
    MediaControl.skipToNext,
  ];

  AudioProcessingState _audioProcessingState(ProcessingState state) =>
      switch (state) {
        ProcessingState.idle => AudioProcessingState.idle,
        ProcessingState.loading => AudioProcessingState.loading,
        ProcessingState.buffering => AudioProcessingState.buffering,
        ProcessingState.ready => AudioProcessingState.ready,
        ProcessingState.completed => AudioProcessingState.completed,
      };
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
