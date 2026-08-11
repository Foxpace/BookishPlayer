import 'package:freezed_annotation/freezed_annotation.dart';

import 'diagnostics_status.dart';
import 'diagnostics_message.dart';
part 'diagnostics_state.freezed.dart';

@freezed
abstract class DiagnosticsState with _$DiagnosticsState {
  const factory DiagnosticsState({
    @Default(DiagnosticsStatus.idle) DiagnosticsStatus status,
    DiagnosticsMessage? message,
    @Default(0) int effectRevision,
  }) = _DiagnosticsState;
}
