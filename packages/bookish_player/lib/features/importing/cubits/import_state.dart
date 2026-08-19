import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/import_models.dart';
import '../repos/selected_audio_file.dart';

import 'import_status.dart';
import 'import_heading.dart';
import 'import_detail.dart';
part 'import_state.freezed.dart';

@freezed
abstract class ImportState with _$ImportState {
  const factory ImportState({
    @Default(ImportStatus.idle) ImportStatus status,
    @Default(false) bool cancellationRequested,
    @Default(false) bool finderTransfer,
    @Default(<SelectedAudioFile>[]) List<SelectedAudioFile> selectedFiles,
    ImportWorkflowFailure? workflowFailure,
    @Default(ImportStage.selectingFiles) ImportStage stage,
    @Default(0) int importedCount,
    @Default(0) int totalFiles,
    String? currentTitle,
    @Default(ImportHeading.openingFileBrowser) ImportHeading heading,
    @Default(ImportDetail.chooseFiles) ImportDetail detail,
    ImportStage? failureStage,
    int? copiedBytes,
    int? totalBytes,
    double? progress,
    String? diagnostics,
  }) = _ImportState;
}
