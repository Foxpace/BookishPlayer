import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/foundation/result.dart';
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
    await _exportDiagnosticsAndEmit();
  }

  Future<void> clear() async {
    emit(state.copyWith(status: DiagnosticsStatus.working, message: null));
    await _clearDiagnosticsAndEmit();
  }

  Future<void> _exportDiagnosticsAndEmit() async {
    switch (await _workflow.export()) {
      case ResultSuccess(:final value):
        emit(
          state.copyWith(
            status: value ? DiagnosticsStatus.success : DiagnosticsStatus.idle,
            message: value
                ? DiagnosticsMessage.exported
                : DiagnosticsMessage.noRecords,
            effectRevision: state.effectRevision + 1,
          ),
        );
      case ResultFailure():
        _emitExportFailure();
    }
  }

  void _emitExportFailure() => emit(
    state.copyWith(
      status: DiagnosticsStatus.failure,
      message: DiagnosticsMessage.exportFailed,
      effectRevision: state.effectRevision + 1,
    ),
  );

  Future<void> _clearDiagnosticsAndEmit() async {
    switch (await _workflow.clear()) {
      case ResultSuccess():
        emit(
          state.copyWith(
            status: DiagnosticsStatus.success,
            message: DiagnosticsMessage.deleted,
            effectRevision: state.effectRevision + 1,
          ),
        );
      case ResultFailure():
        _emitDeleteFailure();
    }
  }

  void _emitDeleteFailure() => emit(
    state.copyWith(
      status: DiagnosticsStatus.failure,
      message: DiagnosticsMessage.deleteFailed,
      effectRevision: state.effectRevision + 1,
    ),
  );
}
