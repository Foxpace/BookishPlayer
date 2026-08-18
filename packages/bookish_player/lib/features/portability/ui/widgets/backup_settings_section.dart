import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../../cubits/portability_state.dart';
import '../../cubits/portability_status.dart';

class BackupSettingsSection extends StatelessWidget {
  const BackupSettingsSection({
    required this.state,
    required this.onBackup,
    required this.onRestore,
    super.key,
  });

  final PortabilityState state;
  final VoidCallback onBackup;
  final VoidCallback onRestore;

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final working = state.status == PortabilityStatus.working;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.localDataTitle,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Text(
          l10n.localDataDescription,
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
                enabled: !working,
                leading: const Icon(Icons.file_upload_outlined),
                title: Text(l10n.exportBackup),
                subtitle: Text(l10n.exportBackupDescription),
                onTap: onBackup,
              ),
              const Divider(height: 1),
              ListTile(
                enabled: !working,
                leading: const Icon(Icons.settings_backup_restore_rounded),
                title: Text(l10n.restoreBackup),
                subtitle: Text(l10n.restoreBackupDescription),
                onTap: onRestore,
              ),
              if (working) const LinearProgressIndicator(),
            ],
          ),
        ),
      ],
    );
  }
}
