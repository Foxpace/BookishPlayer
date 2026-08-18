import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/app_metadata.dart';
import '../../app/app_capabilities.dart';
import '../../core/di/injection.dart';
import '../../core/localization/generated/l10n.dart';
import '../../core/navigation/app_router.dart';
import '../../core/presentation/app_message.dart';
import '../portability/backup_settings_root.dart';
import '../transcription/speech_models_root.dart';
import 'cubits/settings_cubit.dart';
import 'cubits/settings_intents.dart';
import 'cubits/settings_state.dart';
import 'diagnostics/diagnostics_settings_root.dart';
import 'ui/settings_screen.dart';
import 'ui/widgets/bookish_about_dialog.dart';

/// Independent composition boundary for the settings feature.
class SettingsScreenRoot extends StatelessWidget {
  const SettingsScreenRoot({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsCubit = getIt<SettingsCubit>();
    return BlocProvider<SettingsCubit>.value(
      value: settingsCubit,
      child: BlocConsumer<SettingsCubit, SettingsState>(
        listenWhen: (previous, current) =>
            current.message != null &&
            previous.effectRevision != current.effectRevision,
        listener: (context, state) {
          final message = state.message;
          if (message != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(message.localize(context))));
          }
        },
        builder: (context, state) => SettingsScreen(
          state: state,
          actions: (
            onThemeChanged: settingsCubit.setThemePreference,
            onPlaybackChanged: settingsCubit.setPlaybackPreferences,
            onNavigate: (intent) => _navigate(context, intent),
          ),
          sections: (
            transcription: getIt<AppCapabilities>().transcriptionEnabled
                ? const SpeechModelsRoot()
                : null,
            localData: Column(
              children: [
                BackupSettingsRoot(onRestored: settingsCubit.reload),
                const SizedBox(height: 32),
                const DiagnosticsSettingsRoot(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigate(BuildContext context, SettingsNavigationIntent intent) {
    switch (intent) {
      case SettingsNavigationIntent.listeningInsights:
        unawaited(context.pushNamed(AppRoutes.insights));
      case SettingsNavigationIntent.storageAssistant:
        unawaited(context.pushNamed(AppRoutes.storage));
      case SettingsNavigationIntent.aboutBookish:
        unawaited(_showAbout(context));
      case SettingsNavigationIntent.openSourceLicenses:
        _showLicenses(context);
    }
  }

  Future<void> _showAbout(BuildContext context) async {
    final action = await showDialog<BookishAboutDialogAction>(
      context: context,
      builder: (dialogContext) => BookishAboutDialog(
        onAction: (action) => Navigator.pop(dialogContext, action),
      ),
    );
    if (action == BookishAboutDialogAction.openLicenses && context.mounted) {
      _showLicenses(context);
    }
  }

  void _showLicenses(BuildContext context) {
    showLicensePage(
      context: context,
      applicationName: appName,
      applicationVersion: appVersion,
      applicationLegalese: S.of(context).applicationLegalese,
    );
  }
}
