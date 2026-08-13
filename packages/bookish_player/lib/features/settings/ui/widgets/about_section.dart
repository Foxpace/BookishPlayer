import 'package:flutter/material.dart';

import '../../../../core/app_metadata.dart';
import '../../../../core/localization/generated/l10n.dart';
import '../../cubits/settings_intents.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({required this.onNavigate, super.key});

  final ValueChanged<SettingsNavigationIntent> onNavigate;

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.aboutTitle,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Text(
          l10n.aboutDescription,
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
                leading: const Icon(Icons.info_outline_rounded),
                title: Text(l10n.aboutBookish),
                subtitle: Text(l10n.appVersion(appVersion)),
                onTap: () => onNavigate(SettingsNavigationIntent.aboutBookish),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.description_outlined),
                title: Text(l10n.openSourceLicenses),
                subtitle: Text(l10n.openSourceLicensesDescription),
                onTap: () =>
                    onNavigate(SettingsNavigationIntent.openSourceLicenses),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
