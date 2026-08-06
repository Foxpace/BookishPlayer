import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/presentation/diagnostic_failure.dart';
import '../domain/settings_repository.dart';
import '../domain/theme_preference.dart';
import '../domain/playback_preferences.dart';
import 'settings_state.dart';

@lazySingleton
class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this._repository) : super(const SettingsState());

  final SettingsRepository _repository;

  Future<void> load() async {
    if (state.status == SettingsStatus.ready) {
      return;
    }
    emit(state.copyWith(status: SettingsStatus.loading, message: null));
    try {
      final preference = await _repository.getThemePreference();
      final playback = await _repository.getPlaybackPreferences();
      emit(
        state.copyWith(
          status: SettingsStatus.ready,
          themePreference: preference,
          playback: playback,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: SettingsStatus.failure,
          message: diagnosticFailureMessage(
            'Could not load appearance settings.',
            error,
          ),
        ),
      );
    }
  }

  Future<void> setPlaybackPreferences(PlaybackPreferences preferences) async {
    final previous = state.playback;
    emit(state.copyWith(playback: preferences, message: null));
    try {
      await _repository.setPlaybackPreferences(preferences);
    } catch (error) {
      emit(
        state.copyWith(
          playback: previous,
          message: diagnosticFailureMessage(
            'Could not save playback settings.',
            error,
          ),
        ),
      );
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
      await _repository.setThemePreference(preference);
    } catch (error) {
      emit(
        state.copyWith(
          status: SettingsStatus.failure,
          themePreference: previous,
          message: diagnosticFailureMessage(
            'Could not save appearance settings.',
            error,
          ),
        ),
      );
    }
  }
}
