import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../../models/theme_preference.dart';

class AppearanceSettingsSection extends StatelessWidget {
  const AppearanceSettingsSection({
    required this.preference,
    required this.onChanged,
    super.key,
  });

  final ThemePreference preference;
  final ValueChanged<ThemePreference> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.appearanceTitle,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Text(
          l10n.appearanceDescription,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 20),
        Card(
          clipBehavior: Clip.antiAlias,
          child: RadioGroup<ThemePreference>(
            groupValue: preference,
            onChanged: (value) {
              if (value != null) {
                onChanged(value);
              }
            },
            child: Column(
              children: [
                _ThemeOption(
                  preference: ThemePreference.system,
                  icon: Icons.brightness_auto_rounded,
                  title: l10n.themeFollowSystem,
                  subtitle: l10n.themeFollowSystemDescription,
                ),
                const Divider(height: 1),
                _ThemeOption(
                  preference: ThemePreference.light,
                  icon: Icons.light_mode_rounded,
                  title: l10n.themeLight,
                  subtitle: l10n.themeLightDescription,
                ),
                const Divider(height: 1),
                _ThemeOption(
                  preference: ThemePreference.dark,
                  icon: Icons.dark_mode_rounded,
                  title: l10n.themeDark,
                  subtitle: l10n.themeDarkDescription,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ThemeOption extends StatelessWidget {
  const _ThemeOption({
    required this.preference,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final ThemePreference preference;
  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return RadioListTile<ThemePreference>(
      value: preference,
      secondary: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
    );
  }
}
