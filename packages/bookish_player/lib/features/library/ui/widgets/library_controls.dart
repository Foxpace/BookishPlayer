import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../../../../core/navigation/app_navigation.dart' show ImportSource;

Future<void> importAudiobooks(
  BuildContext context,
  Future<void> Function(ImportSource source) onImport,
) async {
  final isAndroid = Theme.of(context).platform == TargetPlatform.android;
  if (isAndroid) {
    await onImport(ImportSource.files);
    return;
  }
  final source = await showModalBottomSheet<ImportSource>(
    context: context,
    showDragHandle: true,
    builder: (sheetContext) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.folder_open_rounded),
            title: Text(S.of(context).copyFromFiles),
            subtitle: Text(S.of(context).copyFromFilesDescription),
            onTap: () => Navigator.pop(sheetContext, ImportSource.files),
          ),
          ListTile(
            leading: const Icon(Icons.cable_rounded),
            title: Text(S.of(context).moveFromFinderTransfer),
            subtitle: Text(S.of(context).moveFromFinderDescription),
            onTap: () =>
                Navigator.pop(sheetContext, ImportSource.finderTransfer),
          ),
          const SizedBox(height: 8),
        ],
      ),
    ),
  );
  if (source == null || !context.mounted) {
    return;
  }
  await onImport(source);
}
