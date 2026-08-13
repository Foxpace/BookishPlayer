import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../../cubits/transcription_cubits.dart';
import '../../models/speech_model.dart';
import 'speech_model_tile.dart';

class SpeechModelPickerSheet extends StatelessWidget {
  const SpeechModelPickerSheet({
    required this.state,
    required this.onActivate,
    super.key,
  });

  final SpeechModelsState state;
  final ValueChanged<SpeechModel> onActivate;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.72,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _PickerHeader(),
            if (state.status == SpeechModelsStatus.loading)
              const LinearProgressIndicator(),
            if (state.status == SpeechModelsStatus.downloading)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: LinearProgressIndicator(value: state.downloadProgress),
              ),
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
                itemCount: state.models.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, index) => SpeechModelTile(
                  model: state.models[index],
                  selected: state.models[index].slug == state.selectedModel,
                  working: state.status == SpeechModelsStatus.downloading,
                  onActivate: onActivate,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PickerHeader extends StatelessWidget {
  const _PickerHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 4, 24, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).chooseSpeechModel,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Text(
            S.of(context).chooseSpeechModelDescription,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
