import 'package:freezed_annotation/freezed_annotation.dart';
import '../repos/selected_audio_file.dart';
import 'import_failed_item.dart';
import 'import_failure_kind.dart';
import 'import_stage.dart';
part 'import_result.freezed.dart';

@freezed
abstract class ImportResult with _$ImportResult {
  const factory ImportResult({
    required List<SelectedAudioFile> selectedFiles,
    required int importedCount,
    @Default(<String>[]) List<String> stageHistory,
    String? diagnostics,
    ImportFailedItem? failedItem,
    ImportFailureKind? failureKind,
    ImportStage? failureStage,
    @Default(false) bool originalRemovalOnly,
  }) = _ImportResult;
}
