import 'theme_preference.dart';

abstract interface class SettingsRepository {
  Future<ThemePreference> getThemePreference();
  Future<void> setThemePreference(ThemePreference preference);
}
