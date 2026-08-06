import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/presentation/diagnostic_failure.dart';
import '../application/storage_assistant_workflow.dart';
import '../../library/domain/audiobook_catalog_repository.dart';
import '../domain/library_storage_repository.dart';
import '../domain/app_data_reset_repository.dart';
import '../../transcription/domain/transcription_repository.dart';
import 'storage_assistant_state.dart';

@injectable
class StorageAssistantCubit extends Cubit<StorageAssistantState> {
  StorageAssistantCubit(
    AudiobookCatalogRepository books,
    LibraryStorageRepository storage,
    AppDataResetRepository appData,
    TranscriptionRepository transcription,
  ) : _workflow = StorageAssistantWorkflow(
        books,
        storage,
        appData,
        transcription,
      ),
      super(const StorageAssistantState());

  final StorageAssistantWorkflow _workflow;

  Future<void> load() async {
    emit(state.copyWith(loading: true, message: null));
    try {
      final result = await _workflow.inspect();
      emit(
        StorageAssistantState(
          loading: false,
          books: result.books,
          report: result.report,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          loading: false,
          message: diagnosticFailureMessage(
            'Storage could not be inspected.',
            error,
          ),
        ),
      );
    }
  }

  Future<void> cleanOrphans() async {
    await _workflow.cleanOrphans(state.report);
    await load();
    emit(state.copyWith(message: 'Unused files removed.'));
  }

  Future<void> removeMissingBook(String id) async {
    await _workflow.removeMissingBook(id);
    await load();
  }

  Future<bool> clearAll() async {
    emit(state.copyWith(loading: true, message: null));
    try {
      await _workflow.clearAll();
      emit(
        const StorageAssistantState(
          loading: false,
          message: 'All Bookish data was removed.',
        ),
      );
      return true;
    } catch (error) {
      emit(
        state.copyWith(
          loading: false,
          message: diagnosticFailureMessage(
            'Bookish could not remove all app data.',
            error,
          ),
        ),
      );
      return false;
    }
  }
}
