import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../../cubits/transcription_cubits.dart';
import '../../models/speech_model.dart';
import 'speech_model_selector.dart';

class SpeechModelSelectorCard extends StatelessWidget {
  const SpeechModelSelectorCard({
    required this.state,
    required this.selectedModel,
    required this.onOpenPicker,
    super.key,
  });

  final SpeechModelsState state;
  final SpeechModel? selectedModel;
  final VoidCallback? onOpenPicker;

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final working = state.status == SpeechModelsStatus.downloading;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.speechToTextModel,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            SpeechModelSelector(
              selectedModel: selectedModel,
              onTap: onOpenPicker,
            ),
            if (state.status == SpeechModelsStatus.loading) ...[
              const SizedBox(height: 14),
              const LinearProgressIndicator(),
            ],
            if (working) ...[
              const SizedBox(height: 14),
              LinearProgressIndicator(value: state.downloadProgress),
            ],
            const SizedBox(height: 16),
            Text(
              l10n.speechModelDescription,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
