import 'package:injectable/injectable.dart';

import '../domain/settings_repository.dart';
import '../domain/playback_preferences.dart';
import '../domain/theme_preference.dart';
import 'settings_dao.dart';

@LazySingleton(as: SettingsRepository)
class SembastSettingsRepository implements SettingsRepository {
  SembastSettingsRepository(this._dao);

  final SettingsDao _dao;

  @override
  Future<ThemePreference> getThemePreference() async {
    return ThemePreference.fromStorage(await _dao.getThemePreference());
  }

  @override
  Future<void> setThemePreference(ThemePreference preference) {
    return _dao.setThemePreference(preference.name);
  }

  @override
  Future<String?> getLibraryLayout() => _dao.getLibraryLayout();

  @override
  Future<void> setLibraryLayout(String layout) => _dao.setLibraryLayout(layout);

  @override
  Future<String?> getSpeechModel() => _dao.getSpeechModel();

  @override
  Future<void> setSpeechModel(String model) => _dao.setSpeechModel(model);

  @override
  Future<PlaybackPreferences> getPlaybackPreferences() async {
    final value = await _dao.getPlaybackPreferences();
    return value == null
        ? const PlaybackPreferences()
        : PlaybackPreferences.fromJson(value);
  }

  @override
  Future<void> setPlaybackPreferences(PlaybackPreferences preferences) =>
      _dao.setPlaybackPreferences(preferences.toJson());
}
