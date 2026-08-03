import 'package:freezed_annotation/freezed_annotation.dart';

import '../../library/domain/audiobook.dart';

part 'transcription_draft.freezed.dart';

@freezed
abstract class TranscriptionDraft with _$TranscriptionDraft {
  const factory TranscriptionDraft({
    required Audiobook book,
    required String text,
    required Duration start,
    required Duration end,
    required Duration chapterStart,
    required Duration chapterEnd,
    required String? chapterTitle,
  }) = _TranscriptionDraft;
}
