import 'package:flutter/material.dart';

import '../localization/generated/l10n.dart';
import '../theme/bookish_theme.dart';

class DiagnosticDetailsPanel extends StatelessWidget {
  const DiagnosticDetailsPanel({
    required this.details,
    required this.onCopy,
    super.key,
  });

  final String details;
  final VoidCallback onCopy;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      title: Text(S.of(context).errorDetails),
      subtitle: Text(S.of(context).shareErrorDetailsDescription),
      children: [
        Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxHeight: 260),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
          ),
          child: SingleChildScrollView(
            child: SelectableText(
              details,
              style: Theme.of(context).textTheme.diagnostics,
            ),
          ),
        ),
        const SizedBox(height: 10),
        OutlinedButton.icon(
          onPressed: onCopy,
          icon: const Icon(Icons.copy_rounded),
          label: Text(S.of(context).copyErrorDetails),
        ),
      ],
    );
  }
}
