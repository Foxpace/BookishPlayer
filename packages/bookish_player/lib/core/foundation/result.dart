import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

@freezed
sealed class Result<S, F> with _$Result<S, F> {
  const factory Result.success(S value) = ResultSuccess<S, F>;
  const factory Result.failure(F failure) = ResultFailure<S, F>;
}
