import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/presentation/app_message.dart';
import '../models/playback_preferences.dart';
import '../models/theme_preference.dart';
import '../use_cases/settings_use_cases.dart';
import 'settings_state.dart';
import 'settings_status.dart';

@lazySingleton
class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this._useCases) : super(const SettingsState());

  final SettingsUseCases _useCases;

  Future<void> load() async {
    if (state.status == SettingsStatus.ready) {
      return;
    }
    emit(state.copyWith(status: SettingsStatus.loading, message: null));
    try {
      await _loadSettingsAndEmit();
    } catch (_) {
      _emitSettingsLoadFailure();
    }
  }

  Future<void> setPlaybackPreferences(PlaybackPreferences preferences) async {
    final previous = state.playback;
    emit(state.copyWith(playback: preferences, message: null));
    try {
      await _useCases.savePlayback(preferences);
    } catch (_) {
      _emitPlaybackSaveFailure(previous);
    }
  }

  Future<void> reload() async {
    emit(state.copyWith(status: SettingsStatus.initial));
    await load();
  }

  Future<void> setThemePreference(ThemePreference preference) async {
    final previous = state.themePreference;
    emit(
      state.copyWith(
        status: SettingsStatus.ready,
        themePreference: preference,
        message: null,
      ),
    );
    try {
      await _useCases.saveTheme(preference);
    } catch (_) {
      _emitThemeSaveFailure(previous);
    }
  }

  Future<void> _loadSettingsAndEmit() async {
    final loaded = await _useCases.load();
    emit(
      state.copyWith(
        status: SettingsStatus.ready,
        themePreference: loaded.theme,
        playback: loaded.playback,
      ),
    );
  }

  void _emitSettingsLoadFailure() => emit(
    state.copyWith(
      status: SettingsStatus.failure,
      message: AppMessage.settingsLoadFailed,
      effectRevision: state.effectRevision + 1,
    ),
  );

  void _emitPlaybackSaveFailure(PlaybackPreferences previous) => emit(
    state.copyWith(
      playback: previous,
      message: AppMessage.playbackSettingsSaveFailed,
      effectRevision: state.effectRevision + 1,
    ),
  );

  void _emitThemeSaveFailure(ThemePreference previous) => emit(
    state.copyWith(
      status: SettingsStatus.failure,
      themePreference: previous,
      message: AppMessage.appearanceSettingsSaveFailed,
      effectRevision: state.effectRevision + 1,
    ),
  );
}
