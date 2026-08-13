abstract interface class VoiceNoteTranscriptionRepository {
  Future<bool> initialize({
    required void Function(String message) onError,
    required void Function() onDone,
  });

  Future<void> listen(void Function(String text) onText);
  Future<void> stop();
}
