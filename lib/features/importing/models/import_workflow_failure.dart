import 'package:freezed_annotation/freezed_annotation.dart';
import 'import_stage.dart';
part 'import_workflow_failure.freezed.dart';

@freezed
abstract class ImportWorkflowFailure
    with _$ImportWorkflowFailure
    implements Exception {
  const factory ImportWorkflowFailure({
    required Object error,
    required StackTrace stackTrace,
    required ImportStage stage,
    required List<String> stageHistory,
    String? activeFile,
    @Default(<String>[]) List<String> parserDiagnostics,
    @Default(false) bool originalRemovalOnly,
  }) = _ImportWorkflowFailure;
}
