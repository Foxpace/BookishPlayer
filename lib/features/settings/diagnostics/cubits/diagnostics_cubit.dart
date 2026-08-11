import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../use_cases/diagnostics_use_case_bundle.dart';
import 'diagnostics_cubits.dart';

@injectable
class DiagnosticsCubit extends Cubit<DiagnosticsState> {
  DiagnosticsCubit(this._useCases) : super(const DiagnosticsState());

  final DiagnosticsUseCases _useCases;

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
    final exported = await _useCases.exportDiagnostics();
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
    await _useCases.deleteDiagnostics();
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
