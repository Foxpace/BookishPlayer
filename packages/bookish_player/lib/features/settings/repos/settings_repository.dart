import '../models/appearance_preferences.dart';
import '../models/playback_preferences.dart';

abstract interface class SettingsRepository {
  Future<AppearancePreferences> getAppearancePreferences();
  Future<void> setAppearancePreferences(AppearancePreferences preferences);

  Future<String?> getLibraryLayout();
  Future<void> setLibraryLayout(String layout);

  Future<String?> getSpeechModel();
  Future<void> setSpeechModel(String model);

  Future<PlaybackPreferences> getPlaybackPreferences();
  Future<void> setPlaybackPreferences(PlaybackPreferences preferences);
}
