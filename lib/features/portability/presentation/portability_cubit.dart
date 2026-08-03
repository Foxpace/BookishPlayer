import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../application/backup_workflow.dart';
import '../domain/backup_store_repository.dart';
import '../domain/local_export_repository.dart';
import 'portability_state.dart';

@injectable
class PortabilityCubit extends Cubit<PortabilityState> {
  PortabilityCubit(BackupStoreRepository store, LocalExportRepository files)
    : _workflow = BackupWorkflow(store, files),
      super(const PortabilityState());

  final BackupWorkflow _workflow;

  Future<void> backup() async {
    emit(const PortabilityState(status: PortabilityStatus.working));
    try {
      final saved = await _workflow.export();
      emit(
        PortabilityState(
          status: saved ? PortabilityStatus.success : PortabilityStatus.idle,
          message: saved ? 'Backup exported.' : null,
        ),
      );
    } catch (_) {
      emit(
        const PortabilityState(
          status: PortabilityStatus.failure,
          message: 'Could not export the backup.',
        ),
      );
    }
  }

  Future<void> restore() async {
    emit(const PortabilityState(status: PortabilityStatus.working));
    try {
      if (!await _workflow.restore()) {
        emit(const PortabilityState());
        return;
      }
      emit(
        const PortabilityState(
          status: PortabilityStatus.success,
          message:
              'Backup restored. Audio files must remain available locally.',
        ),
      );
    } catch (_) {
      emit(
        const PortabilityState(
          status: PortabilityStatus.failure,
          message: 'This backup could not be restored.',
        ),
      );
    }
  }
}
