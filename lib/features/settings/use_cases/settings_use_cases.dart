import 'package:injectable/injectable.dart';

import '../models/playback_preferences.dart';
import '../models/theme_preference.dart';
import '../repos/settings_repository.dart';
import 'save_playback_preferences_use_case.dart';
import 'save_theme_preference_use_case.dart';

part 'load_settings_use_case.dart';

typedef LoadedSettings = ({
  ThemePreference theme,
  PlaybackPreferences playback,
});

@injectable
class SettingsUseCases {
  const SettingsUseCases(this.load, this.savePlayback, this.saveTheme);
  final LoadSettingsUseCase load;
  final SavePlaybackPreferencesUseCase savePlayback;
  final SaveThemePreferenceUseCase saveTheme;
}
