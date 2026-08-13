import 'package:bookish_player/features/settings/repos/settings_repository.dart';
import 'package:bookish_player/features/settings/models/playback_preferences.dart';
import 'package:bookish_player/features/settings/models/theme_preference.dart';
import 'package:bookish_player/features/settings/cubits/settings_cubit.dart';
import 'package:bookish_player/features/settings/cubits/settings_cubits.dart';
import 'package:flutter_test/flutter_test.dart';

import 'settings_test_use_cases.dart';

void main() {
  group('Settings cubit', () {
    test(
      'Given the settings cubit, When its behavior is exercised, Then loads and persists an independent theme preference',
      () async {
        // GIVEN
        final repository = _FakeSettingsStore(ThemePreference.dark);
        final sut = SettingsCubit(buildSettingsUseCases(repository));
        addTearDown(sut.close);

        // WHEN
        await sut.load();

        // THEN
        expect(sut.state.status, SettingsStatus.ready);
        expect(sut.state.themePreference, ThemePreference.dark);

        await sut.setThemePreference(ThemePreference.light);

        expect(sut.state.themePreference, ThemePreference.light);
        expect(repository.savedPreference, ThemePreference.light);
      },
    );
  });
}

class _FakeSettingsStore implements SettingsRepository {
  _FakeSettingsStore(this.preference);

  ThemePreference preference;
  ThemePreference? savedPreference;

  @override
  Future<ThemePreference> getThemePreference() async => preference;

  @override
  Future<void> setThemePreference(ThemePreference preference) async {
    this.preference = preference;
    savedPreference = preference;
  }

  @override
  Future<String?> getLibraryLayout() async => null;

  @override
  Future<void> setLibraryLayout(String layout) async {}

  @override
  Future<String?> getSpeechModel() async => null;

  @override
  Future<void> setSpeechModel(String model) async {}

  @override
  Future<PlaybackPreferences> getPlaybackPreferences() async =>
      const PlaybackPreferences();

  @override
  Future<void> setPlaybackPreferences(PlaybackPreferences preferences) async {}
}
