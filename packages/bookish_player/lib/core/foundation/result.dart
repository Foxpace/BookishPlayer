import 'package:freezed_annotation/freezed_annotation.dart';

import 'app_failure.dart';

export 'app_failure.dart';

part 'result.freezed.dart';

@freezed
sealed class Result<T> with _$Result<T> {
  const factory Result.success(T value) = ResultSuccess<T>;
  const factory Result.failure(AppFailure failure, {T? partialValue}) =
      ResultFailure<T>;
}
