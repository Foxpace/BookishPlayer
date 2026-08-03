import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../domain/voice_note_transcription_repository.dart';
import 'voice_note_state.dart';

@injectable
class VoiceNoteCubit extends Cubit<VoiceNoteState> {
  VoiceNoteCubit(this._speech) : super(const VoiceNoteState());

  final VoiceNoteTranscriptionRepository _speech;

  Future<void> toggle() async {
    if (state.status == VoiceNoteStatus.listening) {
      await stop();
      return;
    }
    final available = await _speech.initialize(
      onError: (message) => emit(
        state.copyWith(status: VoiceNoteStatus.failure, message: message),
      ),
      onDone: () {
        if (!isClosed) {
          emit(state.copyWith(status: VoiceNoteStatus.idle));
        }
      },
    );
    if (!available) {
      emit(
        state.copyWith(
          status: VoiceNoteStatus.failure,
          message: 'Speech recognition is not available.',
        ),
      );
      return;
    }
    emit(state.copyWith(status: VoiceNoteStatus.listening, message: null));
    await _speech.listen(
      (text) => emit(state.copyWith(text: text, message: null)),
    );
  }

  Future<void> stop() async {
    await _speech.stop();
    emit(state.copyWith(status: VoiceNoteStatus.idle));
  }

  @override
  Future<void> close() async {
    await _speech.stop();
    return super.close();
  }
}
