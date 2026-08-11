import 'dart:async';
import 'player_test_support.dart';

class FakeAudioPlayer implements AudioPlayerRepository {
  final _positions = StreamController<Duration>.broadcast();
  final _buffers = StreamController<Duration>.broadcast();
  final _durations = StreamController<Duration?>.broadcast();
  final _playing = StreamController<bool>.broadcast();
  final _completed = StreamController<bool>.broadcast();
  Duration currentPosition = Duration.zero;
  var speed = 1.0;
  var playing = false;
  var pauseCount = 0;

  void emitPosition(Duration value) {
    currentPosition = value;
    _positions.add(value);
  }

  void emitCompleted() => _completed.add(true);

  Future<void> close() async {
    await _positions.close();
    await _buffers.close();
    await _durations.close();
    await _playing.close();
    await _completed.close();
  }

  @override
  Stream<Duration> get positionStream => _positions.stream;
  @override
  Stream<Duration> get bufferedPositionStream => _buffers.stream;
  @override
  Stream<Duration?> get durationStream => _durations.stream;
  @override
  Stream<bool> get playingStream => _playing.stream;
  @override
  Stream<bool> get completedStream => _completed.stream;
  @override
  Duration get position => currentPosition;
  @override
  bool get isPlaying => playing;
  @override
  Future<Duration> probeDuration(String path) async => Duration.zero;
  @override
  Future<void> load(Audiobook book) async {
    currentPosition = Duration(milliseconds: book.positionMs);
  }

  @override
  Future<void> play() async {
    playing = true;
    _playing.add(true);
  }

  @override
  Future<void> pause() async {
    pauseCount++;
    playing = false;
    _playing.add(false);
  }

  @override
  Future<void> clear() async {
    currentPosition = Duration.zero;
    playing = false;
    _playing.add(false);
  }

  @override
  Future<void> seek(Duration position) async {
    currentPosition = position;
  }

  @override
  Future<void> setSpeed(double speed) async {
    this.speed = speed;
  }

  @override
  Future<void> setSkipIntervals(Duration rewind, Duration forward) async {}

  @override
  Future<void> setShortenSilence({required bool enabled}) async {}

  @override
  Future<void> setVoiceBoost({required bool enabled}) async {}

  @override
  Future<void> setVolume(double volume) async {}

  @override
  Future<void> dispose() async {}
}
