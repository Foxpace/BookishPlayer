import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../../../../core/theme/bookish_theme.dart';
import '../../cubits/import_cubits.dart';
import 'import_state_localization.dart';

typedef ImportFailureActions = ({
  VoidCallback retry,
  Future<void> Function() copyDiagnostics,
  VoidCallback back,
});

class ImportFailureView extends StatelessWidget {
  const ImportFailureView({
    required this.state,
    required this.actions,
    this.isCancelled = false,
    super.key,
  });

  final ImportState state;
  final bool isCancelled;
  final ImportFailureActions actions;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isCancelled
                ? Icons.file_open_outlined
                : Icons.error_outline_rounded,
            size: 56,
            color: isCancelled
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 20),
          Text(
            state.heading.localize(context),
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          Text(
            state.localizeDetail(context),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          if (state.diagnostics case final diagnostics?)
            _ImportDiagnostics(
              diagnostics: diagnostics,
              onCopy: actions.copyDiagnostics,
            ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: actions.retry,
            icon: const Icon(Icons.refresh_rounded),
            label: Text(
              isCancelled ? strings.openFileBrowserAgain : strings.tryAgain,
            ),
          ),
          const SizedBox(height: 4),
          TextButton(
            onPressed: actions.back,
            child: Text(strings.backToLibrary),
          ),
        ],
      ),
    );
  }
}

class _ImportDiagnostics extends StatelessWidget {
  const _ImportDiagnostics({required this.diagnostics, required this.onCopy});

  final String diagnostics;
  final Future<void> Function() onCopy;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    return Column(
      children: [
        const SizedBox(height: 24),
        ExpansionTile(
          tilePadding: EdgeInsets.zero,
          title: Text(strings.technicalDetails),
          subtitle: Text(strings.importDiagnosticPrivacy),
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
                  diagnostics,
                  style: Theme.of(context).textTheme.diagnostics,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: () => _copyDiagnostics(context),
          icon: const Icon(Icons.copy_rounded),
          label: Text(strings.copyDiagnostic),
        ),
      ],
    );
  }

  Future<void> _copyDiagnostics(BuildContext context) async {
    await onCopy();
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(S.of(context).diagnosticCopied)));
    }
  }
}
