import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/presentation/app_message.dart';
import '../models/speech_model.dart';

import 'speech_models_status.dart';
part 'speech_models_state.freezed.dart';

@freezed
abstract class SpeechModelsState with _$SpeechModelsState {
  const SpeechModelsState._();
  const factory SpeechModelsState({
    @Default(SpeechModelsStatus.initial) SpeechModelsStatus status,
    @Default(<SpeechModel>[]) List<SpeechModel> models,
    @Default('whisper-tiny') String selectedModel,
    double? downloadProgress,
    AppMessage? message,
    @Default(0) int effectRevision,
  }) = _SpeechModelsState;

  bool get selectedModelIsDownloaded =>
      models.any((model) => model.slug == selectedModel && model.isDownloaded);
}
