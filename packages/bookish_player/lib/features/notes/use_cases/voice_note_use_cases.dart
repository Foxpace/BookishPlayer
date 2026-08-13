import 'package:injectable/injectable.dart';

import '../repos/voice_note_transcription_repository.dart';
import 'stop_voice_note_use_case.dart';

part 'start_voice_note_use_case.dart';

@injectable
class VoiceNoteUseCases {
  const VoiceNoteUseCases({required this.start, required this.stop});

  final StartVoiceNoteUseCase start;
  final StopVoiceNoteUseCase stop;
}
