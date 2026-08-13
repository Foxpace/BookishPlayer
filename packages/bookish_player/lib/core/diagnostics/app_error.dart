import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_error.freezed.dart';
part 'app_error.g.dart';
part 'app_error_diagnostics.dart';

@freezed
abstract class AppError with _$AppError {
  const AppError._();
  const factory AppError({
    required String time,
    required String operation,
    required String errorType,
    required String stack,
    required String platform,
    required String platformVersion,
    required String build,
    String? message,
    @Default(<String, String>{}) Map<String, String> context,
    @Default(<String>[]) List<String> history,
    @Default(<String>[]) List<String> diagnostics,
  }) = _AppError;
  factory AppError.fromJson(Map<String, dynamic> json) =>
      _$AppErrorFromJson(json);
}
