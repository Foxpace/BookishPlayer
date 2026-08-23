import 'dart:async';
import 'package:bookish_player/features/settings/models/appearance_preferences.dart';
import 'package:bookish_player/features/settings/models/playback_preferences.dart';
import 'package:bookish_player/features/settings/repos/settings_repository.dart';
import 'player_test_support.dart';

class FakeSettings implements SettingsRepository {
  @override
  Future<AppearancePreferences> getAppearancePreferences() async =>
      const AppearancePreferences();
  @override
  Future<void> setAppearancePreferences(
    AppearancePreferences preferences,
  ) async {}
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
}
