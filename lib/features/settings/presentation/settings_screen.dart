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

class _SpeechModelsCard extends StatelessWidget {
  const _SpeechModelsCard();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SpeechModelsCubit, SpeechModelsState>(
      listenWhen: (previous, current) =>
          current.message != null && previous.message != current.message,
      listener: (context, state) => ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(state.message!))),
      builder: (context, state) {
        final working = state.status == SpeechModelsStatus.downloading;
        final selectedModel = state.models.isEmpty
            ? null
            : state.models.firstWhere(
                (model) => model.slug == state.selectedModel,
                orElse: () => state.models.first,
              );
        return Card(
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Speech-to-text model',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                Material(
                  color:
                      Theme.of(context).inputDecorationTheme.fillColor ??
                      Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(16),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: working || state.models.isEmpty
                        ? null
                        : () => _showSpeechModelPicker(context),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 8, 10, 8),
                      child: Row(
                        children: [
                          const Icon(Icons.record_voice_over_outlined),
                          const SizedBox(width: 12),
                          Expanded(
                            child: selectedModel == null
                                ? const Text('No speech models available')
                                : _SpeechModelLabel(model: selectedModel),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.expand_more_rounded),
                        ],
                      ),
                    ),
                  ),
                ),
                if (state.status == SpeechModelsStatus.loading) ...[
                  const SizedBox(height: 14),
                  const LinearProgressIndicator(),
                ],
                if (working) ...[
                  const SizedBox(height: 14),
                  LinearProgressIndicator(value: state.downloadProgress),
                  if (state.statusMessage case final message?) ...[
                    const SizedBox(height: 8),
                    Text(message, style: Theme.of(context).textTheme.bodySmall),
                  ],
                ],
                const SizedBox(height: 16),
                Text(
                  'Choose a model to use it. If needed, it downloads automatically. Audio and generated text stay on this device.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showSpeechModelPicker(BuildContext context) {
    final cubit = context.read<SpeechModelsCubit>();
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: const _SpeechModelPickerSheet(),
      ),
    );
  }
}

class _SpeechModelPickerSheet extends StatelessWidget {
  const _SpeechModelPickerSheet();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: BlocBuilder<SpeechModelsCubit, SpeechModelsState>(
        builder: (context, state) {
          final working = state.status == SpeechModelsStatus.downloading;
          return ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.sizeOf(context).height * 0.72,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 4, 24, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Choose speech model',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Tap a model to select it. Models that are not on this device download automatically.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                if (state.status == SpeechModelsStatus.loading)
                  const LinearProgressIndicator(),
                if (working) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: LinearProgressIndicator(
                      value: state.downloadProgress,
                    ),
                  ),
                  if (state.statusMessage case final message?)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 8, 24, 12),
                      child: Text(
                        message,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                ],
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
                    itemCount: state.models.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final model = state.models[index];
                      final selected = model.slug == state.selectedModel;
                      final availability = model.isDownloaded
                          ? 'Downloaded'
                          : 'Available to download';
                      final details = [
                        if (model.sizeMb case final size?) '$size MB',
                        availability,
                        if (selected) 'Selected',
                      ].join(' · ');
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        leading: Icon(
                          selected
                              ? Icons.radio_button_checked_rounded
                              : model.isDownloaded
                              ? Icons.check_circle_outline_rounded
                              : Icons.cloud_download_outlined,
                          color: selected
                              ? Theme.of(context).colorScheme.primary
                              : null,
                        ),
                        title: Text(
                          model.displayName,
                          style: TextStyle(
                            fontWeight: selected
                                ? FontWeight.w700
                                : FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(details),
                        selected: selected,
                        selectedTileColor: Theme.of(
                          context,
                        ).colorScheme.primaryContainer.withValues(alpha: 0.3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        onTap: working
                            ? null
                            : () async {
                                final cubit = context.read<SpeechModelsCubit>();
                                await cubit.selectModel(model.slug);
                                if (!model.isDownloaded) {
                                  await cubit.downloadSelectedModel();
                                }
                                if (context.mounted &&
                                    cubit.state.status ==
                                        SpeechModelsStatus.ready) {
                                  Navigator.pop(context);
                                }
                              },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SpeechModelLabel extends StatelessWidget {
  const _SpeechModelLabel({required this.model});

  final SpeechModel model;

  @override
  Widget build(BuildContext context) {
    final details = [
      if (model.sizeMb case final size?) '$size MB',
      model.isDownloaded ? 'Downloaded' : 'Not downloaded',
    ].join(' · ');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.displayName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 3),
            Text(
              details,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
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
