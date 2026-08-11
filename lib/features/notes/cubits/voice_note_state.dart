import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/presentation/app_message.dart';

import 'voice_note_status.dart';
part 'voice_note_state.freezed.dart';

@freezed
abstract class VoiceNoteState with _$VoiceNoteState {
  const factory VoiceNoteState({
    @Default(VoiceNoteStatus.idle) VoiceNoteStatus status,
    @Default('') String text,
    AppMessage? message,
    @Default(0) int effectRevision,
  }) = _VoiceNoteState;
}
