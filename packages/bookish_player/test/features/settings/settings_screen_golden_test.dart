import 'package:bookish_player/features/settings/cubits/settings_cubit.dart';
import 'package:bookish_player/features/settings/ui/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_support/support/fakes/fake_library_test_support.dart';
import '../../../test_support/support/pump_bookish_app.dart';
import '../../../test_support/features/settings/settings_test_application.dart';

void main() {
  group('Cohesive settings presentation', () {
    late SettingsCubit sut;

    setUp(() async => sut = await _buildCubit());
    tearDown(() => sut.close());

    testWidgets(
      'Given the cohesive settings presentation, When the top-level settings are rendered in light English, Then it matches the approved golden',
      (tester) async {
        // WHEN
        await tester.pumpBookishApp(
          display: const (
            themeMode: ThemeMode.light,
            locale: Locale('en'),
            viewport: Size(430, 932),
            textScale: 1,
          ),
          child: _screen(sut),
        );

        // THEN
        await expectLater(
          find.byType(SettingsScreen),
          matchesGoldenFile('goldens/settings_light_en.png'),
        );
      },
    );

    testWidgets(
      'Given the cohesive settings presentation, When the top-level settings are rendered in dark Slovak, Then it matches the approved golden',
      (tester) async {
        // WHEN
        await tester.pumpBookishApp(
          display: const (
            themeMode: ThemeMode.dark,
            locale: Locale('sk'),
            viewport: Size(430, 932),
            textScale: 1,
          ),
          child: _screen(sut),
        );

        // THEN
        await expectLater(
          find.byType(SettingsScreen),
          matchesGoldenFile('goldens/settings_dark_sk.png'),
        );
      },
    );
  });
}

Future<SettingsCubit> _buildCubit() async {
  final cubit = SettingsCubit(buildSettingsApplication(FakeLibrarySettings()));
  await cubit.load();
  return cubit;
}

SettingsScreen _screen(SettingsCubit cubit) => SettingsScreen(
  state: cubit.state,
  actions: (
    onThemeChanged: cubit.setThemePreference,
    onPlaybackChanged: cubit.setPlaybackPreferences,
    onNavigate: (_) {},
  ),
  sections: (
    transcription: const Card(
      child: ListTile(
        leading: Icon(Icons.record_voice_over_outlined),
        title: Text('Whisper Tiny'),
      ),
    ),
    localData: const Card(
      child: ListTile(
        leading: Icon(Icons.backup_outlined),
        title: Text('Bookish JSON'),
      ),
    ),
  ),
);
