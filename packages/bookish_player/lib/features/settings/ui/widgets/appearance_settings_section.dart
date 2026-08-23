import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../../../../core/presentation/bookish_control_metrics.dart';
import '../../../../core/presentation/bookish_switch_list_tile.dart';
import '../../models/appearance_preferences.dart';
import '../../models/theme_preference.dart';
import 'primary_color_picker_dialog.dart';

class AppearanceSettingsSection extends StatelessWidget {
  const AppearanceSettingsSection({
    required this.preferences,
    required this.supportsSystemColors,
    required this.actions,
    super.key,
  });

  final AppearancePreferences preferences;
  final bool supportsSystemColors;
  final ({
    ValueChanged<ThemePreference> onThemeChanged,
    ValueChanged<bool> onSystemColorsChanged,
    ValueChanged<int> onPrimaryColorChanged,
  })
  actions;

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
        _ThemePreferencesCard(
          preference: preferences.theme,
          onChanged: actions.onThemeChanged,
        ),
        const SizedBox(height: 12),
        _ColorPreferencesCard(
          preferences: preferences,
          supportsSystemColors: supportsSystemColors,
          onSystemColorsChanged: actions.onSystemColorsChanged,
          onPrimaryColorChanged: actions.onPrimaryColorChanged,
        ),
      ],
    );
  }
}

class _ThemePreferencesCard extends StatelessWidget {
  const _ThemePreferencesCard({
    required this.preference,
    required this.onChanged,
  });

  final ThemePreference preference;
  final ValueChanged<ThemePreference> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    return Card(
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
    );
  }
}

class _ColorPreferencesCard extends StatelessWidget {
  const _ColorPreferencesCard({
    required this.preferences,
    required this.supportsSystemColors,
    required this.onSystemColorsChanged,
    required this.onPrimaryColorChanged,
  });

  final AppearancePreferences preferences;
  final bool supportsSystemColors;
  final ValueChanged<bool> onSystemColorsChanged;
  final ValueChanged<int> onPrimaryColorChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          if (supportsSystemColors) ...[
            BookishSwitchListTile(
              value: preferences.useSystemColors,
              onChanged: onSystemColorsChanged,
              content: (
                icon: Icons.wallpaper_rounded,
                title: Text(l10n.systemColorsTitle),
                subtitle: Text(l10n.systemColorsDescription),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 5,
              ),
            ),
            const Divider(height: 1),
          ],
          ListTile(
            leading: _ColorSwatch(color: Color(preferences.primaryColor)),
            title: Text(l10n.appColorTitle),
            subtitle: Text(l10n.appColorDescription),
            trailing: const Icon(Icons.chevron_right_rounded),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 5,
            ),
            onTap: () => _pickColor(context),
          ),
        ],
      ),
    );
  }

  Future<void> _pickColor(BuildContext context) async {
    final color = await showDialog<int>(
      context: context,
      builder: (_) =>
          PrimaryColorPickerDialog(initialColor: preferences.primaryColor),
    );
    if (color != null) {
      onPrimaryColorChanged(color);
    }
  }
}

class _ColorSwatch extends StatelessWidget {
  const _ColorSwatch({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Theme.of(context).colorScheme.outline),
      ),
      child: const SizedBox.square(dimension: BookishControlMetrics.iconSize),
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
      radioScaleFactor: BookishControlMetrics.selectionControlScale,
      secondary: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
    );
  }
}
