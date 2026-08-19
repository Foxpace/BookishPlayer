import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/presentation/app_message.dart';
import '../../../core/use_cases/app_data_reset.dart';
import '../../../core/use_cases/app_data_reset_outcome.dart';
import '../use_cases/storage_assistant_workflow.dart';
import 'storage_assistant_state.dart';

class StorageAssistantCubit extends Cubit<StorageAssistantState> {
  StorageAssistantCubit(this._workflow, this._appDataReset)
    : super(const StorageAssistantState());

  final StorageAssistantWorkflow _workflow;
  final AppDataReset _appDataReset;

  Future<void> load() async {
    emit(state.copyWith(loading: true, message: null));
    try {
      await _inspectStorageAndEmit();
    } catch (_) {
      _emitStorageInspectionFailure();
    }
  }

  Future<void> cleanOrphans() async {
    try {
      await _cleanOrphansAndEmit();
    } catch (_) {
      _emitStorageCleanupFailure();
    }
  }

  Future<void> removeMissingBook(String id) async {
    await _workflow.removeMissingBook(id);
    await load();
  }

  Future<AppDataResetOutcome> clearAll() async {
    emit(state.copyWith(loading: true, message: null));
    final outcome = await _appDataReset.reset();
    _emitResetOutcome(outcome);
    return outcome;
  }

  Future<void> _inspectStorageAndEmit() async {
    final result = await _workflow.inspect();
    emit(
      state.copyWith(
        loading: false,
        books: result.books,
        report: result.report,
      ),
    );
  }

  void _emitStorageInspectionFailure() => emit(
    state.copyWith(
      loading: false,
      message: AppMessage.storageInspectFailed,
      effectRevision: state.effectRevision + 1,
    ),
  );

  Future<void> _cleanOrphansAndEmit() async {
    await _workflow.cleanOrphans(state.report);
    await load();
    emit(
      state.copyWith(
        message: AppMessage.unusedFilesRemoved,
        effectRevision: state.effectRevision + 1,
      ),
    );
  }

  void _emitStorageCleanupFailure() => emit(
    state.copyWith(
      loading: false,
      message: AppMessage.clearDataFailed,
      effectRevision: state.effectRevision + 1,
    ),
  );

  void _emitResetOutcome(AppDataResetOutcome outcome) {
    final message = switch (outcome) {
      AppDataResetOutcome.completed => AppMessage.allDataRemoved,
      AppDataResetOutcome.completedWithSettingsReloadWarning =>
        AppMessage.allDataRemovedSettingsReloadFailed,
      AppDataResetOutcome.playbackResetFailed ||
      AppDataResetOutcome.persistentDeletionFailed =>
        AppMessage.clearDataFailed,
    };
    emit(
      state.copyWith(
        loading: false,
        message: message,
        effectRevision: state.effectRevision + 1,
      ),
    );
  }
}
