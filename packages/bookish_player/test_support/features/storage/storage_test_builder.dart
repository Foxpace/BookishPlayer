import 'package:bookish_player/app/use_cases/app_data_reset_coordinator.dart';
import 'package:bookish_player/features/storage/cubits/storage_assistant_cubit.dart';
import 'package:bookish_player/features/storage/use_cases/storage_assistant_workflow.dart';
import 'package:bookish_player/features/storage/use_cases/storage_use_case_bundle.dart';

StorageAssistantCubit createStorageCubit(
  StorageAssistantWorkflow workflow, {
  Future<void> Function()? resetPlayback,
  Future<void> Function()? deletePersistentData,
  Future<void> Function()? reloadSettings,
}) => StorageAssistantCubit(
  StorageUseCases(
    inspectStorage: InspectStorageUseCase(workflow),
    cleanOrphanFiles: CleanOrphanFilesUseCase(workflow),
    removeMissingBook: RemoveMissingBookUseCase(workflow),
  ),
  AppDataResetCoordinator(
    resetPlayback: resetPlayback ?? _complete,
    deletePersistentData: deletePersistentData ?? _complete,
    reloadSettings: reloadSettings ?? _complete,
  ),
);

Future<void> _complete() async {}
