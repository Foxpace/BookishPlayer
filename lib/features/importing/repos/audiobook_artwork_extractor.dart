abstract interface class AudiobookArtworkExtractor {
  /// Extracts embedded front-cover artwork into durable app-private storage.
  /// Returns `null` when the file has no supported embedded image.
  Future<String?> extract(String audioFilePath);
}
