import 'package:freezed_annotation/freezed_annotation.dart';

import '../../library/models/library_models.dart';

part 'quote_transcription_context.freezed.dart';

@freezed
abstract class QuoteTranscriptionContext with _$QuoteTranscriptionContext {
  const factory QuoteTranscriptionContext({
    required Audiobook book,
    required String? chapterTitle,
    required Duration chapterStart,
  }) = _QuoteTranscriptionContext;
}
