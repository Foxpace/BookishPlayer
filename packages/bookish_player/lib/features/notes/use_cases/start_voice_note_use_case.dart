part of 'voice_note_use_cases.dart';

@injectable
class StartVoiceNoteUseCase {
  const StartVoiceNoteUseCase(this._speech);

  final VoiceNoteTranscriptionRepository _speech;

  Future<bool> call({
    required void Function(Object error) onError,
    required void Function() onDone,
    required void Function(String text) onText,
  }) async {
    final available = await _speech.initialize(
      onError: onError,
      onDone: onDone,
    );
    if (available) {
      await _speech.listen(onText);
    }
    return available;
  }
}
