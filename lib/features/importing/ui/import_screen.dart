import 'package:flutter/material.dart';

import '../cubits/import_cubits.dart';
import 'widgets/import_view.dart';

class ImportScreen extends StatelessWidget {
  const ImportScreen({
    required this.state,
    required this.onRetry,
    required this.onCopyDiagnostics,
    required this.onBack,
    super.key,
  });

  final ImportState state;
  final VoidCallback onRetry;
  final Future<void> Function() onCopyDiagnostics;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return ImportView(
      state: state,
      actions: (
        retry: onRetry,
        copyDiagnostics: onCopyDiagnostics,
        back: onBack,
      ),
    );
  }
}
