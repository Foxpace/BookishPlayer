import 'package:freezed_annotation/freezed_annotation.dart';

import 'app_failure_code.dart';

export 'app_failure_code.dart';

part 'app_failure.freezed.dart';

@freezed
sealed class AppFailure with _$AppFailure {
  const AppFailure._();

  const factory AppFailure.cancelled(String detail, {Object? error}) =
      CancelledFailure;

  const factory AppFailure.notFound(String detail, {Object? error}) =
      NotFoundFailure;

  const factory AppFailure.invalidData(String detail, {Object? error}) =
      InvalidDataFailure;

  const factory AppFailure.operationFailed(String detail, {Object? error}) =
      OperationFailure;

  AppFailureCode get code => switch (this) {
    CancelledFailure() => AppFailureCode.cancelled,
    NotFoundFailure() => AppFailureCode.notFound,
    InvalidDataFailure() => AppFailureCode.invalidData,
    OperationFailure() => AppFailureCode.operationFailed,
  };
}
