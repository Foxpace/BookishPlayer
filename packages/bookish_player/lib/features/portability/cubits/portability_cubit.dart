import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../use_cases/portability_use_case_bundle.dart';
import 'portability_cubits.dart';

@injectable
class PortabilityCubit extends Cubit<PortabilityState> {
  PortabilityCubit(this._useCases) : super(const PortabilityState());

  final PortabilityUseCases _useCases;

  Future<void> backup() async {
    emit(state.copyWith(status: PortabilityStatus.working, message: null));
    try {
      await _exportBackupAndEmit();
    } catch (_) {
      _emitBackupExportFailure();
    }
  }

  Future<void> restore() async {
    emit(state.copyWith(status: PortabilityStatus.working, message: null));
    try {
      await _restoreBackupAndEmit();
    } on BackupValidationException {
      _emitInvalidBackupFailure();
    } catch (_) {
      _emitBackupRestoreFailure();
    }
  }

  Future<void> _exportBackupAndEmit() async {
    final saved = await _useCases.exportBackup();
    emit(
      state.copyWith(
        status: saved ? PortabilityStatus.success : PortabilityStatus.idle,
        message: saved ? PortabilityMessage.backupExported : null,
        effectRevision: saved ? state.effectRevision + 1 : state.effectRevision,
      ),
    );
  }

  void _emitBackupExportFailure() => emit(
    state.copyWith(
      status: PortabilityStatus.failure,
      message: PortabilityMessage.backupExportFailed,
      effectRevision: state.effectRevision + 1,
    ),
  );

  Future<void> _restoreBackupAndEmit() async {
    final restored = await _useCases.restoreBackup();
    emit(
      restored
          ? state.copyWith(
              status: PortabilityStatus.success,
              message: PortabilityMessage.backupRestored,
              effectRevision: state.effectRevision + 1,
            )
          : state.copyWith(status: PortabilityStatus.idle, message: null),
    );
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
