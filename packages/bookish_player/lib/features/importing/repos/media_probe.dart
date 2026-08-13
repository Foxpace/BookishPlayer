abstract interface class MediaProbe {
  Future<Duration> probeDuration(String path);
}
