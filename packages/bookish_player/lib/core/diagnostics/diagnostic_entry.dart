import 'package:freezed_annotation/freezed_annotation.dart';

part 'diagnostic_entry.freezed.dart';
part 'diagnostic_entry.g.dart';
part 'diagnostic_entry_formatting.dart';

@freezed
abstract class DiagnosticEntry with _$DiagnosticEntry {
  const DiagnosticEntry._();
  const factory DiagnosticEntry({
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
  }) = _DiagnosticEntry;
  factory DiagnosticEntry.fromJson(Map<String, dynamic> json) =>
      _$DiagnosticEntryFromJson(json);
}
