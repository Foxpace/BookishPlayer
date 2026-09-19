import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/transcription_draft.dart';
import 'transcription_preview_effect.dart';
import 'transcription_preview_status.dart';

part 'transcription_preview_state.freezed.dart';

@freezed
abstract class TranscriptionPreviewState with _$TranscriptionPreviewState {
  const factory TranscriptionPreviewState({
    required TranscriptionDraft draft,
    required String text,
    @Default(TranscriptionPreviewStatus.ready)
    TranscriptionPreviewStatus status,
    TranscriptionPreviewEffect? effect,
    @Default(0) int effectRevision,
  }) = _TranscriptionPreviewState;
}
