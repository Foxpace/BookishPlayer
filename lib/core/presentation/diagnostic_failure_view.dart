import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DiagnosticFailureView extends StatelessWidget {
  const DiagnosticFailureView({
    required this.title,
    required this.details,
    this.onRetry,
    this.retryLabel = 'Try again',
    this.secondaryAction,
    super.key,
  });

  factory DiagnosticFailureView.fromMessage({
    required String message,
    VoidCallback? onRetry,
    String retryLabel = 'Try again',
    Widget? secondaryAction,
    Key? key,
  }) {
    final separator = message.indexOf('\n');
    return DiagnosticFailureView(
      key: key,
      title: separator < 0 ? message : message.substring(0, separator),
      details: separator < 0 ? message : message.substring(separator + 1),
      onRetry: onRetry,
      retryLabel: retryLabel,
      secondaryAction: secondaryAction,
    );
  }

  final String title;
  final String details;
  final VoidCallback? onRetry;
  final String retryLabel;
  final Widget? secondaryAction;

  @override
  Widget build(BuildContext context) {
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
                'We’re sorry for the inconvenience. Please try again. If the issue keeps happening, expand and copy the error details below and send them to us.',
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
                  label: Text(retryLabel),
                ),
              ],
              if (secondaryAction != null) ...[
                const SizedBox(height: 6),
                secondaryAction!,
              ],
              const SizedBox(height: 16),
              ExpansionTile(
                tilePadding: EdgeInsets.zero,
                title: const Text('Error details'),
                subtitle: const Text(
                  'Share these details if the issue repeats',
                ),
                children: [
                  Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(maxHeight: 260),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: SingleChildScrollView(
                      child: SelectableText(
                        details,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton.icon(
                    onPressed: () => _copy(context),
                    icon: const Icon(Icons.copy_rounded),
                    label: const Text('Copy error details'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _copy(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: details));
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Error details copied')));
    }
  }
}
