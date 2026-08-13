import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../localization/generated/l10n.dart';
import 'diagnostic_details_panel.dart';

class DiagnosticFailureView extends StatelessWidget {
  const DiagnosticFailureView({
    required this.title,
    required this.details,
    this.onRetry,
    this.actions = const (retryLabel: null, secondary: null),
    super.key,
  });

  factory DiagnosticFailureView.fromMessage({
    required String message,
    VoidCallback? onRetry,
    String? retryLabel,
    Widget? secondaryAction,
    Key? key,
  }) {
    final separator = message.indexOf('\n');
    return DiagnosticFailureView(
      key: key,
      title: separator < 0 ? message : message.substring(0, separator),
      details: separator < 0 ? message : message.substring(separator + 1),
      onRetry: onRetry,
      actions: (retryLabel: retryLabel, secondary: secondaryAction),
    );
  }

  final String title;
  final String details;
  final VoidCallback? onRetry;
  final ({String? retryLabel, Widget? secondary}) actions;

  @override
  Widget build(BuildContext context) {
    final (:retryLabel, secondary: secondaryAction) = actions;
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline_rounded,
                size: 52,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 18),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              Text(
                S.of(context).diagnosticFailureApology,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              if (onRetry != null) ...[
                const SizedBox(height: 20),
                FilledButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh_rounded),
                  label: Text(retryLabel ?? S.of(context).tryAgain),
                ),
              ],
              if (secondaryAction case final action?) ...[
                const SizedBox(height: 6),
                action,
              ],
              const SizedBox(height: 16),
              DiagnosticDetailsPanel(
                details: details,
                onCopy: () => _copyErrorDetails(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _copyErrorDetails(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: details));
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(S.of(context).errorDetailsCopied)));
    }
  }
}
