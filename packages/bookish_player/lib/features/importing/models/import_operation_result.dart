import 'package:freezed_annotation/freezed_annotation.dart';

import 'import_result.dart';
import 'import_workflow_cancellation.dart';
import 'import_workflow_failure.dart';

part 'import_operation_result.freezed.dart';

@freezed
sealed class ImportOperationResult with _$ImportOperationResult {
  const factory ImportOperationResult.completed(ImportResult result) =
      ImportOperationCompleted;

  const factory ImportOperationResult.cancelled(
    ImportWorkflowCancellation cancellation,
  ) = ImportOperationCancelled;

  const factory ImportOperationResult.failed(ImportWorkflowFailure failure) =
      ImportOperationFailed;
}
