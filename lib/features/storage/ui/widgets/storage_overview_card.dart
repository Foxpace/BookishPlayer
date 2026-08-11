import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../../models/storage_report.dart';
import 'storage_section_title.dart';

class StorageOverviewCard extends StatelessWidget {
  const StorageOverviewCard({
    required this.report,
    required this.onClean,
    super.key,
  });

  final StorageReport report;
  final VoidCallback onClean;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.storage_rounded),
        title: Text(
          S.of(context).managedStorage(formatStorageBytes(report.managedBytes)),
        ),
        subtitle: Text(
          S
              .of(context)
              .reclaimableStorage(formatStorageBytes(report.reclaimableBytes)),
        ),
        trailing: FilledButton(
          onPressed: report.orphanPaths.isEmpty ? null : onClean,
          child: Text(S.of(context).clean),
        ),
      ),
    );
  }
}
