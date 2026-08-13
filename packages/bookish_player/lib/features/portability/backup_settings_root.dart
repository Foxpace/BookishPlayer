import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/di/injection.dart';
import '../../core/localization/generated/l10n.dart';
import 'cubits/portability_cubit.dart';
import 'cubits/portability_cubits.dart';
import 'ui/widgets/backup_settings_section.dart';

class BackupSettingsRoot extends StatelessWidget {
  const BackupSettingsRoot({required this.onRestored, super.key});
  final Future<void> Function() onRestored;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<PortabilityCubit>(
      create: (_) => getIt<PortabilityCubit>(),
      child: BlocConsumer<PortabilityCubit, PortabilityState>(
        listenWhen: (previous, current) =>
            current.message != null &&
            previous.effectRevision != current.effectRevision,
        listener: _handleEffect,
        builder: (context, state) {
          final cubit = context.read<PortabilityCubit>();
          return BackupSettingsSection(
            state: state,
            onBackup: cubit.backup,
            onRestore: cubit.restore,
          );
        },
      ),
    );
  }

  Future<void> _handleEffect(
    BuildContext context,
    PortabilityState state,
  ) async {
    final message = state.message;
    if (message != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_localizeMessage(S.of(context), message))),
      );
    }
    if (state.status == PortabilityStatus.success &&
        state.message == PortabilityMessage.backupRestored) {
      await onRestored();
    }
  }

  String _localizeMessage(S l10n, PortabilityMessage message) =>
      switch (message) {
        PortabilityMessage.backupExported => l10n.backupExported,
        PortabilityMessage.backupExportFailed => l10n.backupExportFailed,
        PortabilityMessage.backupRestored => l10n.backupRestored,
        PortabilityMessage.backupRestoreFailed => l10n.backupRestoreFailed,
        PortabilityMessage.invalidBackup => l10n.invalidBackup,
      };
}
