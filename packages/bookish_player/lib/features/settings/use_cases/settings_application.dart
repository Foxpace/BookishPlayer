import 'package:injectable/injectable.dart';

import '../models/playback_preferences.dart';
import '../models/theme_preference.dart';
import '../repos/settings_repository.dart';

typedef LoadedSettings = ({
  ThemePreference theme,
  PlaybackPreferences playback,
});

@injectable
class SettingsApplication {
  const SettingsApplication(this._repository);

  final SettingsRepository _repository;

  Future<LoadedSettings> load() async {
    final (theme, playback) = await (
      _repository.getThemePreference(),
      _repository.getPlaybackPreferences(),
    ).wait;

    return (theme: theme, playback: playback);
  }

  Future<void> saveThemePreference(ThemePreference preference) =>
      _repository.setThemePreference(preference);

  Future<void> savePlaybackPreferences(PlaybackPreferences preferences) =>
      _repository.setPlaybackPreferences(preferences);
}
