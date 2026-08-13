import 'package:bookish_player/features/storage/cubits/storage_assistant_cubit.dart';
import 'package:bookish_player/features/storage/use_cases/storage_assistant_workflow.dart';
import 'package:bookish_player/features/storage/use_cases/storage_use_case_bundle.dart';

StorageAssistantCubit createStorageCubit(
  StorageAssistantWorkflow workflow, {
  Future<void> Function()? resetPlayback,
  Future<void> Function()? reloadSettings,
}) => StorageAssistantCubit(
  StorageUseCases(
    inspectStorage: InspectStorageUseCase(workflow),
    cleanOrphanFiles: CleanOrphanFilesUseCase(workflow),
    removeMissingBook: RemoveMissingBookUseCase(workflow),
    clearBookishData: ClearBookishDataUseCase(workflow),
  ),
  (
    resetPlayback: resetPlayback ?? _complete,
    reloadSettings: reloadSettings ?? _complete,
  ),
);

Future<void> _complete() async {}
