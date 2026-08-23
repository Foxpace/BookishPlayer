import 'package:injectable/injectable.dart';

import '../settings_repository.dart';
import '../../models/playback_preferences.dart';
import '../../models/appearance_preferences.dart';
import '../../models/theme_preference.dart';
import 'settings_dao.dart';

@LazySingleton(as: SettingsRepository)
class SembastSettingsRepository implements SettingsRepository {
  SembastSettingsRepository(this._dao);

  final SettingsDao _dao;

  @override
  Future<AppearancePreferences> getAppearancePreferences() async {
    final stored = await _dao.getAppearancePreferences();
    return AppearancePreferences(
      theme: ThemePreference.fromStorage(stored?['theme'] as String?),
      useSystemColors: stored?['useSystemColors'] as bool? ?? true,
      primaryColor:
          stored?['primaryColor'] as int? ??
          const AppearancePreferences().primaryColor,
    );
  }

  @override
  Future<void> setAppearancePreferences(AppearancePreferences preferences) =>
      _dao.setAppearancePreferences({
        'theme': preferences.theme.name,
        'useSystemColors': preferences.useSystemColors,
        'primaryColor': preferences.primaryColor,
      });

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
