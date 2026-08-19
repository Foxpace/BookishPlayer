import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../use_cases/diagnostics_workflow.dart';
import 'diagnostics_message.dart';
import 'diagnostics_state.dart';
import 'diagnostics_status.dart';

@injectable
class DiagnosticsCubit extends Cubit<DiagnosticsState> {
  DiagnosticsCubit(this._workflow) : super(const DiagnosticsState());

  final DiagnosticsWorkflow _workflow;

  Future<void> export() async {
    emit(state.copyWith(status: DiagnosticsStatus.working, message: null));
    try {
      await _exportDiagnosticsAndEmit();
    } catch (_) {
      _emitExportFailure();
    }
  }

  Future<void> clear() async {
    emit(state.copyWith(status: DiagnosticsStatus.working, message: null));
    try {
      await _clearDiagnosticsAndEmit();
    } catch (_) {
      _emitDeleteFailure();
    }
  }

  Future<void> _exportDiagnosticsAndEmit() async {
    final exported = await _workflow.export();
    emit(
      state.copyWith(
        status: exported ? DiagnosticsStatus.success : DiagnosticsStatus.idle,
        message: exported
            ? DiagnosticsMessage.exported
            : DiagnosticsMessage.noRecords,
        effectRevision: state.effectRevision + 1,
      ),
    );
  }

  void _emitExportFailure() => emit(
    state.copyWith(
      status: DiagnosticsStatus.failure,
      message: DiagnosticsMessage.exportFailed,
      effectRevision: state.effectRevision + 1,
    ),
  );

  Future<void> _clearDiagnosticsAndEmit() async {
    await _workflow.clear();
    emit(
      state.copyWith(
        status: DiagnosticsStatus.success,
        message: DiagnosticsMessage.deleted,
        effectRevision: state.effectRevision + 1,
      ),
    );
  }

  void _emitDeleteFailure() => emit(
    state.copyWith(
      status: DiagnosticsStatus.failure,
      message: DiagnosticsMessage.deleteFailed,
      effectRevision: state.effectRevision + 1,
    ),
  );
}
