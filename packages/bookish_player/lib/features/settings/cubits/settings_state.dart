import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/presentation/app_message.dart';
import '../models/playback_preferences.dart';
import '../models/theme_preference.dart';

import 'settings_status.dart';
part 'settings_state.freezed.dart';

@freezed
abstract class SettingsState with _$SettingsState {
  const factory SettingsState({
    @Default(SettingsStatus.initial) SettingsStatus status,
    @Default(ThemePreference.system) ThemePreference themePreference,
    @Default(PlaybackPreferences()) PlaybackPreferences playback,
    AppMessage? message,
    @Default(0) int effectRevision,
  }) = _SettingsState;
}
