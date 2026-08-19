import 'package:freezed_annotation/freezed_annotation.dart';

part 'cactus_transcription_outcome.freezed.dart';

@freezed
sealed class CactusTranscriptionOutcome with _$CactusTranscriptionOutcome {
  const factory CactusTranscriptionOutcome.success(String text) =
      CactusTranscriptionSucceeded;

  const factory CactusTranscriptionOutcome.failure(String message) =
      CactusTranscriptionFailed;
}
