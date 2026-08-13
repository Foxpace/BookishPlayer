part of 'bookish_backup_validator.dart';

@freezed
abstract class BackupValidationException
    with _$BackupValidationException
    implements Exception {
  const factory BackupValidationException(
    BackupValidationFailure failure, {
    String? recordId,
  }) = _BackupValidationException;
}
