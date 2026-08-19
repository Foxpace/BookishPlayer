import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../../../../core/presentation/bookish_scaffold.dart';
import 'import_failure_view.dart';
import '../../cubits/import_cubits.dart';
import '../../models/import_stage.dart';
import 'import_state_localization.dart';

typedef ImportViewActions = ({
  VoidCallback retry,
  VoidCallback cancel,
  Future<void> Function() copyDiagnostics,
  VoidCallback back,
});

class ImportView extends StatelessWidget {
  const ImportView({required this.state, required this.actions, super.key});

  final ImportState state;
  final ImportViewActions actions;

  @override
  Widget build(BuildContext context) {
    return BookishScaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: _ImportContent(state: state, actions: actions),
        ),
      ),
    );
  }
}

class _ImportContent extends StatelessWidget {
  const _ImportContent({required this.state, required this.actions});

  final ImportState state;
  final ImportViewActions actions;

  @override
  Widget build(BuildContext context) {
    if (state.status == ImportStatus.failure) {
      return ImportFailureView(
        state: state,
        actions: (
          retry: actions.retry,
          copyDiagnostics: actions.copyDiagnostics,
          back: actions.back,
        ),
      );
    }
    if (state.status == ImportStatus.cancelled) {
      return ImportFailureView(
        state: state,
        isCancelled: true,
        actions: (
          retry: actions.retry,
          copyDiagnostics: actions.copyDiagnostics,
          back: actions.back,
        ),
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 220,
          child: LinearProgressIndicator(value: state.progress),
        ),
        const SizedBox(height: 30),
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
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            height: 1.5,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        if (state.status.isActive &&
            state.stage != ImportStage.removingOriginals) ...[
          const SizedBox(height: 20),
          TextButton.icon(
            onPressed: state.cancellationRequested ? null : actions.cancel,
            icon: const Icon(Icons.close_rounded),
            label: Text(S.of(context).cancel),
          ),
        ],
      ],
    );
  }
}
