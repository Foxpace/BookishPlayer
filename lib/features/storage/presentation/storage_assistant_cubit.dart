import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../application/storage_assistant_workflow.dart';
import '../../library/domain/audiobook_catalog_repository.dart';
import '../domain/library_storage_repository.dart';
import 'storage_assistant_state.dart';

@injectable
class StorageAssistantCubit extends Cubit<StorageAssistantState> {
  StorageAssistantCubit(
    AudiobookCatalogRepository books,
    LibraryStorageRepository storage,
  ) : _workflow = StorageAssistantWorkflow(books, storage),
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
    } catch (_) {
      emit(
        state.copyWith(
          loading: false,
          message: 'Storage could not be inspected.',
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
}
