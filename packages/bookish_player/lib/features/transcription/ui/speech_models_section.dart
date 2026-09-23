import 'package:material_ui/material_ui.dart';

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
    final working =
        state.status == SpeechModelsStatus.downloading ||
        state.status == SpeechModelsStatus.removing;
    final selectedModel = state.selectedModelIsDownloaded
        ? state.models
              .where((model) => model.slug == state.selectedModel)
              .firstOrNull
        : null;
    return SpeechModelSelectorCard(
      state: state,
      selectedModel: selectedModel,
      onOpenPicker: working || state.models.isEmpty ? null : onOpenPicker,
    );
  }
}
