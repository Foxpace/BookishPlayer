import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';

import '../../../library/models/library_models.dart';
import '../audio_player_repository.dart';
import '../../models/playback_segments.dart';

class JustAudioPlayerRepository implements AudioPlayerRepository {
  JustAudioPlayerRepository(
    this._player, [
    this._loudnessEnhancer,
    this._equalizer,
  ]);

  final AudioPlayer _player;
  final AndroidLoudnessEnhancer? _loudnessEnhancer;
  final AndroidEqualizer? _equalizer;
  AudioHandler? _audioHandler;
  List<PlaybackSegment> _segments = const [];
  var _offsetsMs = const [0];
  var _totalDurationMs = 0;

  void attachAudioHandler(AudioHandler audioHandler) {
    if (_audioHandler != null) {
      throw StateError('The audio handler is already attached.');
    }
    _audioHandler = audioHandler;
  }

  Future<void> configure() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
  }

  @override
  Stream<Duration> get positionStream => _player.positionStream.map(
    (position) => position + Duration(milliseconds: _currentOffsetMs),
  );

  @override
  Stream<Duration> get bufferedPositionStream => _player.bufferedPositionStream
      .map((position) => position + Duration(milliseconds: _currentOffsetMs));

  @override
  Stream<Duration?> get durationStream => _player.durationStream.map(
    (_) => Duration(milliseconds: _totalDurationMs),
  );

  @override
  Stream<bool> get playingStream => _player.playingStream;

  @override
  Stream<bool> get completedStream => _player.processingStateStream
      .map((state) => state == ProcessingState.completed)
      .distinct();

  @override
  Duration get position =>
      _player.position + Duration(milliseconds: _currentOffsetMs);

  @override
  bool get isPlaying => _player.playing;

  @override
  Future<Duration> probeDuration(String path) async {
    final probe = AudioPlayer();
    try {
      return await probe.setFilePath(path, tag: durationProbeMediaItem(path)) ??
          Duration.zero;
    } finally {
      await probe.dispose();
    }
  }

  @override
  Future<void> load(Audiobook book) async {
    _segments = book.playbackSegments;
    _offsetsMs = _segments.map((segment) => segment.globalStartMs).toList();
    _totalDurationMs = book.playableTracks.fold(
      0,
      (total, track) => total + track.durationMs,
    );

    final initial = _buildLocation(Duration(milliseconds: book.positionMs));
    await _player.setAudioSources(
      _segments.map((segment) => _buildAudioSource(book, segment)).toList(),
      initialIndex: initial.index,
      initialPosition: initial.position,
    );
  }

  AudioSource _buildAudioSource(Audiobook book, PlaybackSegment segment) {
    final item = _buildMediaItem(book, segment);
    final fullTrack =
        segment.sourceStartMs == 0 &&
        segment.durationMs == segment.track.durationMs;
    if (fullTrack) {
      return AudioSource.file(segment.track.filePath, tag: item);
    }

    return ClippingAudioSource(
      child: AudioSource.file(segment.track.filePath),
      start: Duration(milliseconds: segment.sourceStartMs),
      end: Duration(milliseconds: segment.sourceStartMs + segment.durationMs),
      duration: Duration(milliseconds: segment.durationMs),
      tag: item,
    );
  }

  MediaItem _buildMediaItem(Audiobook book, PlaybackSegment segment) {
    return MediaItem(
      id: '${book.id}:${segment.id}',
      title: book.title,
      album: book.title,
      artist: book.author.isEmpty ? null : book.author,
      displayTitle: book.title,
      displaySubtitle: segment.title,
      duration: Duration(milliseconds: segment.durationMs),
      artUri: switch (book.artworkPath) {
        final path? => Uri.file(path),
        null => null,
      },
    );
  }

  @override
  Future<void> play() => _handler.play();

  @override
  Future<void> pause() => _handler.pause();

  @override
  Future<void> clear() async {
    await _handler.stop();
    await _player.clearAudioSources();
    _segments = const [];
    _offsetsMs = const [0];
    _totalDurationMs = 0;
  }

  @override
  Future<void> seek(Duration position) async {
    final location = _buildLocation(position);
    // Changing the queue item and seeking in two separate operations briefly
    // publishes position zero for the selected item. Use just_audio's atomic
    // indexed seek so the UI only observes the final position.
    await _player.seek(location.position, index: location.index);
  }

  @override
  Future<void> setSpeed(double speed) =>
      _handler.customAction('setSpeed', {'speed': speed});

  @override
  Future<void> setSkipIntervals(Duration rewind, Duration forward) =>
      _handler.customAction('setSkipIntervals', {
        'rewindMs': rewind.inMilliseconds,
        'forwardMs': forward.inMilliseconds,
      });

  @override
  Future<void> setShortenSilence({required bool enabled}) => Platform.isAndroid
      ? _player.setSkipSilenceEnabled(enabled)
      : Future<void>.value();

  @override
  Future<void> setVoiceBoost({required bool enabled}) async {
    if (!Platform.isAndroid) {
      return;
    }

    final loudness = _loudnessEnhancer;
    if (loudness != null) {
      await loudness.setTargetGain(4);
      await loudness.setEnabled(enabled);
    }

    final equalizer = _equalizer;
    if (equalizer == null) {
      return;
    }

    await equalizer.setEnabled(enabled);
    if (enabled) {
      await _configureEqualizer(equalizer);
    }
  }

  Future<void> _configureEqualizer(AndroidEqualizer equalizer) async {
    final parameters = await equalizer.parameters;
    for (final band in parameters.bands) {
      final preferred =
          band.centerFrequency >= 900 && band.centerFrequency <= 5000
          ? 3.0
          : -1.0;
      await band.setGain(
        preferred.clamp(parameters.minDecibels, parameters.maxDecibels),
      );
    }
  }

  @override
  Future<void> setVolume(double volume) => _player.setVolume(volume);

  @override
  Future<void> dispose() async {
    await _handler.stop();
    await _player.dispose();
  }

  AudioHandler get _handler =>
      _audioHandler ??
      (throw StateError('The audio handler has not been attached.'));

  int get _currentOffsetMs {
    final index = _player.currentIndex ?? 0;
    return index < _offsetsMs.length ? _offsetsMs[index] : 0;
  }

  ({int index, Duration position}) _buildLocation(Duration globalPosition) {
    if (_segments.isEmpty) {
      return (index: 0, position: globalPosition);
    }

    final milliseconds = globalPosition.inMilliseconds
        .clamp(0, _totalDurationMs)
        .toInt();
    var index = _segments.length - 1;

    for (var candidate = 0; candidate < _segments.length; candidate++) {
      final end = _offsetsMs[candidate] + _segments[candidate].durationMs;
      if (milliseconds < end) {
        index = candidate;
        break;
      }
    }

    return (
      index: index,
      position: Duration(milliseconds: milliseconds - _offsetsMs[index]),
    );
  }
}
