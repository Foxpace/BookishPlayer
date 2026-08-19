import 'package:freezed_annotation/freezed_annotation.dart';

import '../repos/selected_audio_file.dart';
import 'import_failed_item.dart';
import 'import_failure_kind.dart';
import 'import_stage.dart';

part 'import_workflow_failure.freezed.dart';

@freezed
abstract class ImportWorkflowFailure
    with _$ImportWorkflowFailure
    implements Exception {
  const factory ImportWorkflowFailure({
    required ImportFailureKind kind,
    required ImportStage stage,
    required List<SelectedAudioFile> selectedFiles,
    required int importedCount,
    required List<String> stageHistory,
    required String diagnostics,
    ImportFailedItem? failedItem,
    @Default(false) bool originalRemovalOnly,
  }) = _ImportWorkflowFailure;
}
