import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';

class TranscriptionSettingsSection extends StatelessWidget {
  const TranscriptionSettingsSection({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).localTranscriptionTitle,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Text(
          S.of(context).localTranscriptionDescription,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 18),
        child,
      ],
    );
  }
}
