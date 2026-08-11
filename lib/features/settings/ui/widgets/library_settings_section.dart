import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../../cubits/settings_intents.dart';

class LibrarySettingsSection extends StatelessWidget {
  const LibrarySettingsSection({required this.onNavigate, super.key});

  final ValueChanged<SettingsNavigationIntent> onNavigate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).libraryTitle,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Text(
          S.of(context).librarySettingsDescription,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 18),
        Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.insights_rounded),
                title: Text(S.of(context).listeningInsightsTitle),
                subtitle: Text(S.of(context).listeningInsightsDescription),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () =>
                    onNavigate(SettingsNavigationIntent.listeningInsights),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.storage_rounded),
                title: Text(S.of(context).storageAssistantTitle),
                subtitle: Text(S.of(context).storageAssistantDescription),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () =>
                    onNavigate(SettingsNavigationIntent.storageAssistant),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
