import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/app_metadata.dart';
import '../../../core/localization/generated/l10n.dart';
import '../../../core/navigation/app_router.dart';
import '../../portability/presentation/portability_cubit.dart';
import '../../portability/presentation/portability_state.dart';
import '../../transcription/domain/transcription_repository.dart';
import '../domain/theme_preference.dart';
import 'settings_cubit.dart';
import 'settings_state.dart';
import 'speech_models_cubit.dart';
import 'speech_models_state.dart';

part 'widgets/speech_models_section.dart';
part 'widgets/about_section.dart';
part 'widgets/playback_settings_section.dart';
part 'widgets/library_settings_section.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    return MultiBlocListener(
      listeners: [
        BlocListener<SettingsCubit, SettingsState>(
          listenWhen: (previous, current) =>
              current.message != null && previous.message != current.message,
          listener: (context, state) => ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message!))),
        ),
        BlocListener<PortabilityCubit, PortabilityState>(
          listenWhen: (previous, current) =>
              current.message != null && previous.message != current.message,
          listener: (context, state) async {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message!)));
            if (state.status == PortabilityStatus.success &&
                state.message?.startsWith('Backup restored') == true) {
              await context.read<SettingsCubit>().reload();
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.settingsTitle)),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
            children: [
              const _LibrarySettingsSection(),
              const SizedBox(height: 32),
              Text(
                l10n.appearanceTitle,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
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
                child: BlocBuilder<SettingsCubit, SettingsState>(
                  buildWhen: (previous, current) =>
                      previous.themePreference != current.themePreference,
                  builder: (context, state) => RadioGroup<ThemePreference>(
                    groupValue: state.themePreference,
                    onChanged: (preference) {
                      if (preference != null) {
                        unawaited(
                          context.read<SettingsCubit>().setThemePreference(
                            preference,
                          ),
                        );
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
              ),
              const SizedBox(height: 32),
              const _PlaybackSettingsSection(),
              const SizedBox(height: 32),
              Text(
                l10n.localTranscriptionTitle,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.localTranscriptionDescription,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 18),
              const _SpeechModelsCard(),
              const SizedBox(height: 32),
              Text(
                l10n.localDataTitle,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.localDataDescription,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 18),
              BlocBuilder<PortabilityCubit, PortabilityState>(
                builder: (context, state) => Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      ListTile(
                        enabled: state.status != PortabilityStatus.working,
                        leading: const Icon(Icons.file_upload_outlined),
                        title: Text(l10n.exportBackup),
                        subtitle: Text(l10n.exportBackupDescription),
                        onTap: context.read<PortabilityCubit>().backup,
                      ),
                      const Divider(height: 1),
                      ListTile(
                        enabled: state.status != PortabilityStatus.working,
                        leading: const Icon(
                          Icons.settings_backup_restore_rounded,
                        ),
                        title: Text(l10n.restoreBackup),
                        subtitle: Text(l10n.restoreBackupDescription),
                        onTap: context.read<PortabilityCubit>().restore,
                      ),
                      if (state.status == PortabilityStatus.working)
                        const LinearProgressIndicator(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const AboutSection(),
            ],
          ),
        ),
      ),
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
