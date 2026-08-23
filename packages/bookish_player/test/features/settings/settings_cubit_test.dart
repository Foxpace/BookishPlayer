import 'package:bookish_player/features/settings/repos/settings_repository.dart';
import 'package:bookish_player/features/settings/models/appearance_preferences.dart';
import 'package:bookish_player/features/settings/models/playback_preferences.dart';
import 'package:bookish_player/features/settings/models/theme_preference.dart';
import 'package:bookish_player/features/settings/cubits/settings_cubit.dart';
import 'package:bookish_player/features/settings/cubits/settings_status.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_support/features/settings/settings_test_application.dart';

void main() {
  group('Settings cubit', () {
    test(
      'Given the settings cubit, When its behavior is exercised, Then loads and persists an independent theme preference',
      () async {
        // GIVEN
        final repository = _FakeSettingsStore(
          const AppearancePreferences(theme: ThemePreference.dark),
        );
        final sut = SettingsCubit(buildSettingsApplication(repository));
        addTearDown(sut.close);

        // WHEN
        await sut.load();

        // THEN
        expect(sut.state.status, SettingsStatus.ready);
        expect(sut.state.appearance.theme, ThemePreference.dark);

        await sut.setThemePreference(ThemePreference.light);
        await sut.setUseSystemColors(enabled: false);
        await sut.setPrimaryColor(0xFF336699);

        expect(
          sut.state.appearance,
          const AppearancePreferences(
            theme: ThemePreference.light,
            useSystemColors: false,
            primaryColor: 0xFF336699,
          ),
        );
        expect(repository.savedPreference, sut.state.appearance);
      },
    );
  });
}

class _FakeSettingsStore implements SettingsRepository {
  _FakeSettingsStore(this.preference);

  AppearancePreferences preference;
  AppearancePreferences? savedPreference;

  @override
  Future<AppearancePreferences> getAppearancePreferences() async => preference;

  @override
  Future<void> setAppearancePreferences(
    AppearancePreferences preference,
  ) async {
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
