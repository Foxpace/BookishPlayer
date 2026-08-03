import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../portability/presentation/portability_cubit.dart';
import '../../portability/presentation/portability_state.dart';
import '../../transcription/domain/transcription_repository.dart';
import '../domain/theme_preference.dart';
import 'settings_cubit.dart';
import 'settings_state.dart';
import 'speech_models_cubit.dart';
import 'speech_models_state.dart';

part 'widgets/speech_models_section.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        appBar: AppBar(title: const Text('Settings')),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
            children: [
              Text(
                'Appearance',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Choose how Bookish looks on this device.',
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
                    child: const Column(
                      children: [
                        _ThemeOption(
                          preference: ThemePreference.system,
                          icon: Icons.brightness_auto_rounded,
                          title: 'Follow system',
                          subtitle:
                              'Match your device appearance automatically',
                        ),
                        Divider(height: 1),
                        _ThemeOption(
                          preference: ThemePreference.light,
                          icon: Icons.light_mode_rounded,
                          title: 'Light',
                          subtitle: 'Warm paper and dark ink',
                        ),
                        Divider(height: 1),
                        _ThemeOption(
                          preference: ThemePreference.dark,
                          icon: Icons.dark_mode_rounded,
                          title: 'Dark',
                          subtitle: 'Comfortable listening after lights out',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Local transcription',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Choose and download the on-device speech model used to turn audiobook ranges into quotes.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 18),
              const _SpeechModelsCard(),
              const SizedBox(height: 32),
              Text(
                'Local data',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Back up progress, notes, metadata, and settings without a cloud account.',
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
                        title: const Text('Export backup'),
                        subtitle: const Text(
                          'Save a portable Bookish JSON file',
                        ),
                        onTap: context.read<PortabilityCubit>().backup,
                      ),
                      const Divider(height: 1),
                      ListTile(
                        enabled: state.status != PortabilityStatus.working,
                        leading: const Icon(
                          Icons.settings_backup_restore_rounded,
                        ),
                        title: const Text('Restore backup'),
                        subtitle: const Text(
                          'Replace local library data from a backup',
                        ),
                        onTap: context.read<PortabilityCubit>().restore,
                      ),
                      if (state.status == PortabilityStatus.working)
                        const LinearProgressIndicator(),
                    ],
                  ),
                ),
              ),
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
