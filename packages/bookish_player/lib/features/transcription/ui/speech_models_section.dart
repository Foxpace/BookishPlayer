import 'package:flutter/material.dart';

import '../cubits/transcription_cubits.dart';
import 'widgets/speech_model_selector_card.dart';

class SpeechModelsSection extends StatelessWidget {
  const SpeechModelsSection({
    required this.state,
    required this.onOpenPicker,
    super.key,
  });

  final SpeechModelsState state;
  final VoidCallback onOpenPicker;

  @override
  Widget build(BuildContext context) {
    final working = state.status == SpeechModelsStatus.downloading;
    final selectedModel = state.models.isEmpty
        ? null
        : state.models.firstWhere(
            (model) => model.slug == state.selectedModel,
            orElse: () => state.models.first,
          );
    return SpeechModelSelectorCard(
      state: state,
      selectedModel: selectedModel,
      onOpenPicker: working || state.models.isEmpty ? null : onOpenPicker,
    );
  }
}
