import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../../models/speech_model.dart';

class SpeechModelSelector extends StatelessWidget {
  const SpeechModelSelector({
    required this.selectedModel,
    required this.onTap,
    super.key,
  });

  final SpeechModel? selectedModel;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color:
          Theme.of(context).inputDecorationTheme.fillColor ??
          Theme.of(context).colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 10, 8),
          child: Row(
            children: [
              const Icon(Icons.record_voice_over_outlined),
              const SizedBox(width: 12),
              Expanded(
                child: switch (selectedModel) {
                  final model? => _SpeechModelLabel(model: model),
                  null => Text(S.of(context).noSpeechModelsAvailable),
                },
              ),
              const SizedBox(width: 8),
              const Icon(Icons.expand_more_rounded),
            ],
          ),
        ),
      ),
    );
  }
}

class _SpeechModelLabel extends StatelessWidget {
  const _SpeechModelLabel({required this.model});

  final SpeechModel model;

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final details = [
      if (model.sizeMb case final size?) l10n.modelSize(size),
      model.isDownloaded ? l10n.modelDownloaded : l10n.modelNotDownloaded,
    ].join(' · ');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            model.displayName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 3),
          Text(
            details,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
