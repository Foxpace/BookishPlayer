import 'package:injectable/injectable.dart';

import '../repos/voice_note_transcription_repository.dart';

@injectable
class VoiceNoteApplication {
  const VoiceNoteApplication(this._speech);

  final VoiceNoteTranscriptionRepository _speech;

  Future<bool> start({
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

  Future<void> stop() => _speech.stop();
}
