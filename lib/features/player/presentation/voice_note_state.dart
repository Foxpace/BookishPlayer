import 'package:freezed_annotation/freezed_annotation.dart';

part 'voice_note_state.freezed.dart';

enum VoiceNoteStatus { idle, listening, failure }

@freezed
abstract class VoiceNoteState with _$VoiceNoteState {
  const factory VoiceNoteState({
    @Default(VoiceNoteStatus.idle) VoiceNoteStatus status,
    @Default('') String text,
    String? message,
  }) = _VoiceNoteState;
}
