import 'package:freezed_annotation/freezed_annotation.dart';

import 'portability_status.dart';
import 'portability_message.dart';
part 'portability_state.freezed.dart';

@freezed
abstract class PortabilityState with _$PortabilityState {
  const factory PortabilityState({
    @Default(PortabilityStatus.idle) PortabilityStatus status,
    PortabilityMessage? message,
    @Default(0) int effectRevision,
  }) = _PortabilityState;
}
