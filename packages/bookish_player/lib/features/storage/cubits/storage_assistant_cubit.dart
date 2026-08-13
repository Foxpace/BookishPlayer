import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/presentation/app_message.dart';
import '../use_cases/storage_use_case_bundle.dart';
import 'storage_assistant_state.dart';

typedef StorageScreenTools = ({
  Future<void> Function() resetPlayback,
  Future<void> Function() reloadSettings,
});

class StorageAssistantCubit extends Cubit<StorageAssistantState> {
  StorageAssistantCubit(this._useCases, this._tools)
    : super(const StorageAssistantState());

  final StorageUseCases _useCases;
  final StorageScreenTools _tools;

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
    await _useCases.removeMissingBook(id);
    await load();
  }

  Future<bool> clearAll() async {
    emit(state.copyWith(loading: true, message: null));
    try {
      return await _clearAllDataAndEmit();
    } catch (_) {
      return _emitClearAllFailure();
    }
  }

  Future<void> _inspectStorageAndEmit() async {
    final result = await _useCases.inspectStorage();
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
    await _useCases.cleanOrphanFiles(state.report);
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

  Future<bool> _clearAllDataAndEmit() async {
    await _tools.resetPlayback();
    await _useCases.clearBookishData();
    await _tools.reloadSettings();
    emit(
      state.copyWith(
        loading: false,
        message: AppMessage.allDataRemoved,
        effectRevision: state.effectRevision + 1,
      ),
    );
    return true;
  }

  bool _emitClearAllFailure() {
    emit(
      state.copyWith(
        loading: false,
        message: AppMessage.clearDataFailed,
        effectRevision: state.effectRevision + 1,
      ),
    );
    return false;
  }
}
