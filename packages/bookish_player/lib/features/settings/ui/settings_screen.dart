import 'package:flutter/material.dart';

import '../../../core/localization/generated/l10n.dart';
import '../../../core/presentation/bookish_scaffold.dart';
import '../cubits/settings_intents.dart';
import '../cubits/settings_state.dart';
import '../models/playback_preferences.dart';
import '../models/theme_preference.dart';
import 'widgets/about_section.dart';
import 'widgets/appearance_settings_section.dart';
import 'widgets/library_settings_section.dart';
import 'widgets/playback_settings_section.dart';
import 'widgets/transcription_settings_section.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    required this.state,
    required this.sections,
    required this.actions,
    super.key,
  });

  final SettingsState state;
  final ({Widget? transcription, Widget localData}) sections;
  final ({
    ValueChanged<ThemePreference> onThemeChanged,
    ValueChanged<PlaybackPreferences> onPlaybackChanged,
    ValueChanged<SettingsNavigationIntent> onNavigate,
  })
  actions;

  @override
  Widget build(BuildContext context) {
    return BookishScaffold(
      appBar: AppBar(title: Text(S.of(context).settingsTitle)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
        children: [
          LibrarySettingsSection(onNavigate: actions.onNavigate),
          const SizedBox(height: 32),
          AppearanceSettingsSection(
            preference: state.themePreference,
            onChanged: actions.onThemeChanged,
          ),
          const SizedBox(height: 32),
          PlaybackSettingsSection(
            playback: state.playback,
            onChanged: actions.onPlaybackChanged,
          ),
          if (sections.transcription case final transcription?) ...[
            const SizedBox(height: 32),
            TranscriptionSettingsSection(child: transcription),
          ],
          const SizedBox(height: 32),
          sections.localData,
          const SizedBox(height: 32),
          AboutSection(onNavigate: actions.onNavigate),
        ],
      ),
    );
  }
}
