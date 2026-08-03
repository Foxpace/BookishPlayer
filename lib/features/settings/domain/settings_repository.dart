import 'theme_preference.dart';
import 'playback_preferences.dart';

abstract interface class SettingsRepository {
  Future<ThemePreference> getThemePreference();
  Future<void> setThemePreference(ThemePreference preference);

  Future<String?> getLibraryLayout();
  Future<void> setLibraryLayout(String layout);

  Future<String?> getSpeechModel();
  Future<void> setSpeechModel(String model);

  Future<PlaybackPreferences> getPlaybackPreferences();
  Future<void> setPlaybackPreferences(PlaybackPreferences preferences);
}
