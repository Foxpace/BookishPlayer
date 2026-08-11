import '../../library/models/library_models.dart';

abstract interface class AudioPlayerRepository {
  Stream<Duration> get positionStream;
  Stream<Duration> get bufferedPositionStream;
  Stream<Duration?> get durationStream;
  Stream<bool> get playingStream;
  Stream<bool> get completedStream;
  Duration get position;
  bool get isPlaying;

  Future<Duration> probeDuration(String path);
  Future<void> load(Audiobook book);
  Future<void> play();
  Future<void> pause();
  Future<void> clear();
  Future<void> seek(Duration position);
  Future<void> setSpeed(double speed);
  Future<void> setSkipIntervals(Duration rewind, Duration forward);
  Future<void> setShortenSilence({required bool enabled});
  Future<void> setVoiceBoost({required bool enabled});
  Future<void> setVolume(double volume);
  Future<void> dispose();
}
