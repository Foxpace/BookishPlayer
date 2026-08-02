import 'package:freezed_annotation/freezed_annotation.dart';

part 'portability_state.freezed.dart';

enum PortabilityStatus { idle, working, success, failure }

@freezed
abstract class PortabilityState with _$PortabilityState {
  const factory PortabilityState({
    @Default(PortabilityStatus.idle) PortabilityStatus status,
    String? message,
  }) = _PortabilityState;
}
