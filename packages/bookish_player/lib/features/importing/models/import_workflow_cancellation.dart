import 'package:freezed_annotation/freezed_annotation.dart';

import '../repos/selected_audio_file.dart';

part 'import_workflow_cancellation.freezed.dart';

@freezed
abstract class ImportWorkflowCancellation
    with _$ImportWorkflowCancellation
    implements Exception {
  const factory ImportWorkflowCancellation({
    required List<SelectedAudioFile> selectedFiles,
    required int importedCount,
  }) = _ImportWorkflowCancellation;
}
