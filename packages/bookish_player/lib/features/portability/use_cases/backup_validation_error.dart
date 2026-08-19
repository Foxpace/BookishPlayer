import 'package:freezed_annotation/freezed_annotation.dart';

import 'backup_validation_failure.dart';

part 'backup_validation_error.freezed.dart';

@freezed
abstract class BackupValidationError with _$BackupValidationError {
  const factory BackupValidationError(
    BackupValidationFailure failure, {
    String? recordId,
  }) = _BackupValidationError;
}
