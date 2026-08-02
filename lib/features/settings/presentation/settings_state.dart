import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/theme_preference.dart';

part 'settings_state.freezed.dart';

enum SettingsStatus { initial, loading, ready, failure }

@freezed
abstract class SettingsState with _$SettingsState {
  const factory SettingsState({
    @Default(SettingsStatus.initial) SettingsStatus status,
    @Default(ThemePreference.system) ThemePreference themePreference,
    String? message,
  }) = _SettingsState;
}
