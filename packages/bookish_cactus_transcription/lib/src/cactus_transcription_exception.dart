class CactusTranscriptionException implements Exception {
  const CactusTranscriptionException(this.message);

  final String message;

  @override
  String toString() => message;
}
