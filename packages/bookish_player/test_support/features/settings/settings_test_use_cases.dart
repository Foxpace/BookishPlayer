import 'package:bookish_player/features/settings/repos/settings_repository.dart';
import 'package:bookish_player/features/settings/use_cases/save_playback_preferences_use_case.dart';
import 'package:bookish_player/features/settings/use_cases/save_theme_preference_use_case.dart';
import 'package:bookish_player/features/settings/use_cases/settings_use_cases.dart';

SettingsUseCases buildSettingsUseCases(SettingsRepository repository) =>
    SettingsUseCases(
      LoadSettingsUseCase(repository),
      SavePlaybackPreferencesUseCase(repository),
      SaveThemePreferenceUseCase(repository),
    );
