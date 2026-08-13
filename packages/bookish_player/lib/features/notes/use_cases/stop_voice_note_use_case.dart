import 'package:injectable/injectable.dart';
import '../repos/voice_note_transcription_repository.dart';

@injectable
class StopVoiceNoteUseCase {
  const StopVoiceNoteUseCase(this._speech);

  final VoiceNoteTranscriptionRepository _speech;

  Future<void> call() => _speech.stop();
}
