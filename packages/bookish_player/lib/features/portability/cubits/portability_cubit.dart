import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/foundation/result.dart';
import '../use_cases/portability_failure.dart';
import '../use_cases/backup_workflow.dart';
import 'portability_message.dart';
import 'portability_state.dart';
import 'portability_status.dart';

@injectable
class PortabilityCubit extends Cubit<PortabilityState> {
  PortabilityCubit(this._workflow) : super(const PortabilityState());

  final BackupWorkflow _workflow;

  Future<void> backup() async {
    emit(state.copyWith(status: PortabilityStatus.working, message: null));
    await _exportBackupAndEmit();
  }

  Future<void> restore() async {
    emit(state.copyWith(status: PortabilityStatus.working, message: null));
    await _restoreBackupAndEmit();
  }

  Future<void> _exportBackupAndEmit() async {
    switch (await _workflow.export()) {
      case ResultSuccess(value: final saved):
        emit(
          state.copyWith(
            status: saved ? PortabilityStatus.success : PortabilityStatus.idle,
            message: saved ? PortabilityMessage.backupExported : null,
            effectRevision: saved
                ? state.effectRevision + 1
                : state.effectRevision,
          ),
        );
      case ResultFailure():
        _emitBackupExportFailure();
    }
  }

  void _emitBackupExportFailure() => emit(
    state.copyWith(
      status: PortabilityStatus.failure,
      message: PortabilityMessage.backupExportFailed,
      effectRevision: state.effectRevision + 1,
    ),
  );

  Future<void> _restoreBackupAndEmit() async {
    switch (await _workflow.restore()) {
      case ResultSuccess(value: final restored):
        emit(
          restored
              ? state.copyWith(
                  status: PortabilityStatus.success,
                  message: PortabilityMessage.backupRestored,
                  effectRevision: state.effectRevision + 1,
                )
              : state.copyWith(status: PortabilityStatus.idle, message: null),
        );
      case ResultFailure(failure: PortabilityFailure.invalidBackup):
        _emitInvalidBackupFailure();
      case ResultFailure():
        _emitBackupRestoreFailure();
    }
  }

  void _emitInvalidBackupFailure() => emit(
    state.copyWith(
      status: PortabilityStatus.failure,
      message: PortabilityMessage.invalidBackup,
      effectRevision: state.effectRevision + 1,
    ),
  );

  void _emitBackupRestoreFailure() => emit(
    state.copyWith(
      status: PortabilityStatus.failure,
      message: PortabilityMessage.backupRestoreFailed,
      effectRevision: state.effectRevision + 1,
    ),
  );
}
