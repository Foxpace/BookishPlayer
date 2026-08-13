import 'package:injectable/injectable.dart';

import 'storage_assistant_workflow.dart';
import 'clean_orphan_files_use_case.dart';
import 'remove_missing_book_use_case.dart';
import 'clear_bookish_data_use_case.dart';

part 'inspect_storage_use_case.dart';

@injectable
class StorageUseCases {
  const StorageUseCases({
    required this.inspectStorage,
    required this.cleanOrphanFiles,
    required this.removeMissingBook,
    required this.clearBookishData,
  });

  final InspectStorageUseCase inspectStorage;
  final CleanOrphanFilesUseCase cleanOrphanFiles;
  final RemoveMissingBookUseCase removeMissingBook;
  final ClearBookishDataUseCase clearBookishData;
}
