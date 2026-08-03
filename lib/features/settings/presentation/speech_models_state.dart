import 'package:freezed_annotation/freezed_annotation.dart';

import '../../transcription/domain/transcription_repository.dart';

part 'speech_models_state.freezed.dart';

enum SpeechModelsStatus { initial, loading, ready, downloading, failure }

@freezed
abstract class SpeechModelsState with _$SpeechModelsState {
  const SpeechModelsState._();

  const factory SpeechModelsState({
    @Default(SpeechModelsStatus.initial) SpeechModelsStatus status,
    @Default(<SpeechModel>[]) List<SpeechModel> models,
    @Default('whisper-tiny') String selectedModel,
    double? downloadProgress,
    String? statusMessage,
    String? message,
  }) = _SpeechModelsState;

  bool get selectedModelIsDownloaded =>
      models.any((model) => model.slug == selectedModel && model.isDownloaded);
}
