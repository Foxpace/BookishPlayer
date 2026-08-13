import 'package:bookish_player/core/database/bookish_database.dart';
import 'package:bookish_player/features/settings/repos/implementations/sembast_settings_repository.dart';
import 'package:bookish_player/features/settings/repos/implementations/settings_dao.dart';
import 'package:bookish_player/features/settings/models/playback_preferences.dart';
import 'package:bookish_player/features/settings/models/theme_preference.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sembast/sembast_memory.dart';

void main() {
  group('Empty Sembast settings store', () {
    late BookishDatabase database;
    late SembastSettingsRepository sut;

    setUp(() async {
      database = BookishDatabase.forTesting(
        await databaseFactoryMemory.openDatabase('settings-test.db'),
      );
      sut = SembastSettingsRepository(SettingsDao(database));
    });

    tearDown(() => database.database.close());

    test(
      'Given an empty Sembast settings store, When defaults are read, Then safe production defaults are returned',
      () async {
        // THEN
        expect(await sut.getThemePreference(), ThemePreference.system);
        expect(await sut.getLibraryLayout(), isNull);
        expect(await sut.getSpeechModel(), isNull);
        expect(await sut.getPlaybackPreferences(), const PlaybackPreferences());
      },
    );

    test(
      'Given an empty Sembast settings store, When all preferences are persisted, Then typed values round-trip through the DAO',
      () async {
        // GIVEN
        const playback = PlaybackPreferences(
          rewindSeconds: 20,
          forwardSeconds: 45,
          shortenSilence: true,
          voiceBoost: true,
          chapterFallbackMinutes: 30,
        );

        await sut.setThemePreference(ThemePreference.dark);
        await sut.setLibraryLayout('grid');
        await sut.setSpeechModel('whisper-small');
        // WHEN
        await sut.setPlaybackPreferences(playback);

        // THEN
        expect(await sut.getThemePreference(), ThemePreference.dark);
        expect(await sut.getLibraryLayout(), 'grid');
        expect(await sut.getSpeechModel(), 'whisper-small');
        expect(await sut.getPlaybackPreferences(), playback);
      },
    );

    test(
      'Given an empty Sembast settings store, When an unknown legacy theme value is read, Then it migrates behaviorally to the system preference',
      () async {
        // WHEN
        await SettingsDao(database).setThemePreference('legacy-sepia');

        // THEN
        expect(await sut.getThemePreference(), ThemePreference.system);
      },
    );
  });
}
