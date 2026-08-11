import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/presentation/app_message.dart';
import '../models/quote_transcription_context.dart';
import '../models/quote_time_range.dart';
import '../models/transcription_draft.dart';

import 'quote_transcription_status.dart';
part 'quote_transcription_state.freezed.dart';

@freezed
abstract class QuoteTranscriptionState with _$QuoteTranscriptionState {
  const factory QuoteTranscriptionState({
    @Default(QuoteTranscriptionStatus.idle) QuoteTranscriptionStatus status,
    QuoteTranscriptionContext? context,
    QuoteTimeRange? range,
    TranscriptionDraft? draft,
    AppMessage? message,
    @Default(0) int effectRevision,
  }) = _QuoteTranscriptionState;
}
