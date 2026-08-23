import 'package:bookish_player/core/foundation/result.dart';
import 'package:bookish_player/features/settings/models/appearance_preferences.dart';
import 'package:bookish_player/features/settings/models/playback_preferences.dart';
import 'package:bookish_player/features/settings/models/theme_preference.dart';
import 'package:bookish_player/features/settings/use_cases/settings_application.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_support/support/fakes/fake_library_dependencies.dart';

void main() {
  group('Settings application', () {
    test(
      'Given theme and playback preferences, When they are loaded and changed, Then the cohesive snapshot and writes stay repository-backed',
      () async {
        // GIVEN
        final repository = FakeLibrarySettings()
          ..theme = ThemePreference.dark
          ..playback = const PlaybackPreferences(rewindSeconds: 30);
        final sut = SettingsApplication(repository);
        // WHEN
        final loaded = switch (await sut.load()) {
          ResultSuccess(:final value) => value,
          ResultFailure(:final failure) => throw TestFailure(
            'Expected settings to load, received $failure.',
          ),
        };
        await sut.saveAppearancePreferences(
          const AppearancePreferences(theme: ThemePreference.light),
        );
        const playback = PlaybackPreferences(forwardSeconds: 30);
        await sut.savePlaybackPreferences(playback);
        // THEN
        expect(loaded.appearance.theme, ThemePreference.dark);
        expect(loaded.playback.rewindSeconds, 30);
        expect(repository.savedThemes, [ThemePreference.light]);
        expect(repository.savedPlayback, [playback]);
      },
    );
  });
}
