import 'dart:async';
import 'package:bookish_player/features/settings/models/playback_preferences.dart';
import 'package:bookish_player/features/settings/repos/settings_repository.dart';
import 'package:bookish_player/features/settings/models/theme_preference.dart';
import 'player_test_support.dart';

class FakeSettings implements SettingsRepository {
  @override
  Future<PlaybackPreferences> getPlaybackPreferences() async =>
      const PlaybackPreferences();
  @override
  Future<void> setPlaybackPreferences(PlaybackPreferences preferences) async {}
  @override
  Future<String?> getLibraryLayout() async => null;
  @override
  Future<void> setLibraryLayout(String layout) async {}
  @override
  Future<String?> getSpeechModel() async => null;
  @override
  Future<void> setSpeechModel(String model) async {}
  @override
  Future<ThemePreference> getThemePreference() async => ThemePreference.system;
  @override
  Future<void> setThemePreference(ThemePreference preference) async {}
}
