import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/presentation/app_message.dart';
import '../use_cases/voice_note_application.dart';
import 'notes_cubits.dart';

@injectable
class VoiceNoteCubit extends Cubit<VoiceNoteState> {
  VoiceNoteCubit(this._application) : super(const VoiceNoteState());

  final VoiceNoteApplication _application;

  Future<void> toggle() async {
    if (state.status == VoiceNoteStatus.listening) {
      await stop();
      return;
    }

    final available = await _application.start(
      onError: _handleRecognitionError,
      onDone: _handleRecognitionDone,
      onText: _handleRecognizedText,
    );

    if (available == false) {
      _fail(AppMessage.speechRecognitionUnavailable);
      return;
    }

    emit(state.copyWith(status: VoiceNoteStatus.listening, message: null));
  }

  void _handleRecognitionError(Object _) {
    _fail(AppMessage.speechRecognitionFailed);
  }

  void _handleRecognitionDone() {
    if (isClosed == false) {
      emit(state.copyWith(status: VoiceNoteStatus.idle));
    }
  }

  void _handleRecognizedText(String text) {
    emit(state.copyWith(text: text, message: null));
  }

  void _fail(AppMessage message) {
    emit(
      state.copyWith(
        status: VoiceNoteStatus.failure,
        message: message,
        effectRevision: state.effectRevision + 1,
      ),
    );
  }

  Future<void> stop() async {
    await _application.stop();
    emit(state.copyWith(status: VoiceNoteStatus.idle));
  }

  @override
  Future<void> close() async {
    await _application.stop();
    return super.close();
  }
}
