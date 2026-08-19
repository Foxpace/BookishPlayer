import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/foundation/result.dart';
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
    await _inspectStorageAndEmit();
  }

  Future<void> cleanOrphans() async {
    await _cleanOrphansAndEmit();
  }

  Future<void> removeMissingBook(String id) async {
    switch (await _workflow.removeMissingBook(id)) {
      case ResultSuccess():
        await load();
      case ResultFailure():
        _emitStorageCleanupFailure();
    }
  }

  Future<AppDataResetOutcome> clearAll() async {
    emit(state.copyWith(loading: true, message: null));
    final outcome = await _appDataReset.reset();
    _emitResetOutcome(outcome);
    return outcome;
  }

  Future<void> _inspectStorageAndEmit() async {
    switch (await _workflow.inspect()) {
      case ResultSuccess(:final value):
        emit(
          state.copyWith(
            loading: false,
            books: value.books,
            report: value.report,
          ),
        );
      case ResultFailure():
        _emitStorageInspectionFailure();
    }
  }

  void _emitStorageInspectionFailure() => emit(
    state.copyWith(
      loading: false,
      message: AppMessage.storageInspectFailed,
      effectRevision: state.effectRevision + 1,
    ),
  );

  Future<void> _cleanOrphansAndEmit() async {
    switch (await _workflow.cleanOrphans(state.report)) {
      case ResultSuccess():
        await load();
        if (state.message != AppMessage.storageInspectFailed) {
          emit(
            state.copyWith(
              message: AppMessage.unusedFilesRemoved,
              effectRevision: state.effectRevision + 1,
            ),
          );
        }
      case ResultFailure():
        _emitStorageCleanupFailure();
    }
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
