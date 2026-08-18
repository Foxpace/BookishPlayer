import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/injection.dart';
import '../../../core/localization/generated/l10n.dart';
import 'cubits/diagnostics_cubit.dart';
import 'cubits/diagnostics_message.dart';
import 'cubits/diagnostics_state.dart';
import 'ui/diagnostics_settings_section.dart';

class DiagnosticsSettingsRoot extends StatelessWidget {
  const DiagnosticsSettingsRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DiagnosticsCubit>(
      create: (_) => getIt<DiagnosticsCubit>(),
      child: BlocConsumer<DiagnosticsCubit, DiagnosticsState>(
        listenWhen: (previous, current) =>
            current.message != null &&
            previous.effectRevision != current.effectRevision,
        listener: _showMessage,
        builder: (context, state) {
          final cubit = context.read<DiagnosticsCubit>();
          return DiagnosticsSettingsSection(
            state: state,
            onExport: cubit.export,
            onDelete: cubit.clear,
          );
        },
      ),
    );
  }

  void _showMessage(BuildContext context, DiagnosticsState state) {
    final message = state.message;
    if (message != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_localizeMessage(S.of(context), message))),
      );
    }
  }

  String _localizeMessage(S l10n, DiagnosticsMessage message) =>
      switch (message) {
        DiagnosticsMessage.exported => l10n.diagnosticsExported,
        DiagnosticsMessage.noRecords => l10n.diagnosticsNoRecords,
        DiagnosticsMessage.exportFailed => l10n.diagnosticsExportFailed,
        DiagnosticsMessage.deleted => l10n.diagnosticsDeleted,
        DiagnosticsMessage.deleteFailed => l10n.diagnosticsDeleteFailed,
      };
}
