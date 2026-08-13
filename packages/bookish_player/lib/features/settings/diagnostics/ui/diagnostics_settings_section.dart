import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../cubits/diagnostics_cubits.dart';

class DiagnosticsSettingsSection extends StatelessWidget {
  const DiagnosticsSettingsSection({
    required this.state,
    required this.onExport,
    required this.onDelete,
    super.key,
  });

  final DiagnosticsState state;
  final VoidCallback onExport;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final working = state.status == DiagnosticsStatus.working;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.diagnosticsTitle,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Text(
          l10n.diagnosticsDescription,
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
                leading: const Icon(Icons.ios_share_rounded),
                title: Text(l10n.exportDiagnostics),
                onTap: onExport,
              ),
              const Divider(height: 1),
              ListTile(
                enabled: !working,
                leading: const Icon(Icons.delete_outline_rounded),
                title: Text(l10n.deleteDiagnostics),
                onTap: onDelete,
              ),
              if (working) const LinearProgressIndicator(),
            ],
          ),
        ),
      ],
    );
  }
}
