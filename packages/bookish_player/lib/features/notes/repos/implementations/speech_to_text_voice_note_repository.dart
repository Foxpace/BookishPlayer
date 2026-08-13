import 'package:injectable/injectable.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../voice_note_transcription_repository.dart';

@Environment('prod')
@LazySingleton(as: VoiceNoteTranscriptionRepository)
class SpeechToTextVoiceNoteRepository
    implements VoiceNoteTranscriptionRepository {
  final _speech = SpeechToText();

  @override
  Future<bool> initialize({
    required void Function(String message) onError,
    required void Function() onDone,
  }) => _speech.initialize(
    onError: (error) => onError(error.errorMsg),
    onStatus: (status) {
      if (status == 'done' || status == 'notListening') {
        onDone();
      }
    },
  );

  @override
  Future<void> listen(void Function(String text) onText) => _speech.listen(
    onResult: (result) => onText(result.recognizedWords),
    listenOptions: SpeechListenOptions(
      listenFor: const Duration(minutes: 1),
      pauseFor: const Duration(seconds: 4),
    ),
  );

  @override
  Future<void> stop() => _speech.stop();
}
