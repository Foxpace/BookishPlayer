import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/quote_time_range.dart';
import '../domain/transcription_draft.dart';

part 'quote_transcription_state.freezed.dart';

enum QuoteTranscriptionStatus { idle, ready, transcribing, complete, failure }

@freezed
abstract class QuoteTranscriptionState with _$QuoteTranscriptionState {
  const factory QuoteTranscriptionState({
    @Default(QuoteTranscriptionStatus.idle) QuoteTranscriptionStatus status,
    QuoteTimeRange? range,
    TranscriptionDraft? draft,
    String? message,
  }) = _QuoteTranscriptionState;
}
