import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../../models/speech_model.dart';

class SpeechModelTile extends StatelessWidget {
  const SpeechModelTile({
    required this.model,
    required this.selected,
    required this.working,
    required this.onActivate,
    super.key,
  });

  final SpeechModel model;
  final bool selected;
  final bool working;
  final ValueChanged<SpeechModel> onActivate;

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final availability = model.isDownloaded
        ? l10n.modelDownloaded
        : l10n.modelAvailableToDownload;
    final details = [
      if (model.sizeMb case final size?) l10n.modelSize(size),
      availability,
      if (selected) l10n.modelSelected,
    ].join(' · ');
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      leading: Icon(
        selected
            ? Icons.radio_button_checked_rounded
            : model.isDownloaded
            ? Icons.check_circle_outline_rounded
            : Icons.cloud_download_outlined,
        color: selected ? Theme.of(context).colorScheme.primary : null,
      ),
      title: Text(
        model.displayName,
        style: TextStyle(
          fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
        ),
      ),
      subtitle: Text(details),
      selected: selected,
      selectedTileColor: Theme.of(
        context,
      ).colorScheme.primaryContainer.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      onTap: working ? null : () => onActivate(model),
    );
  }
}
