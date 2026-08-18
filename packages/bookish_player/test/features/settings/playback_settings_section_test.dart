import 'package:bookish_player/features/settings/models/playback_preferences.dart';
import 'package:bookish_player/features/settings/cubits/settings_cubit.dart';
import 'package:bookish_player/features/settings/cubits/settings_state.dart';
import 'package:bookish_player/features/settings/ui/widgets/playback_settings_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_support/support/fakes/fake_library_test_support.dart';
import '../../../test_support/support/pump_bookish_app.dart';
import '../../../test_support/features/settings/settings_test_use_cases.dart';

void main() {
  group('Loaded playback preferences', () {
    late FakeLibrarySettings settings;
    late SettingsCubit cubit;

    setUp(() async {
      settings = FakeLibrarySettings()
        ..playback = const PlaybackPreferences(
          rewindSeconds: 20,
          forwardSeconds: 30,
        );
      cubit = SettingsCubit(buildSettingsUseCases(settings));
      await cubit.load();
    });

    tearDown(() => cubit.close());

    testWidgets(
      'Given loaded playback preferences, When playback controls are changed, Then each control dispatches an explicit preference intent',
      (tester) async {
        // WHEN
        await tester.pumpBookishApp(
          display: const (
            themeMode: ThemeMode.light,
            locale: Locale('en'),
            viewport: Size(500, 1200),
            textScale: 1,
          ),
          child: Scaffold(body: SingleChildScrollView(child: _section(cubit))),
        );

        // THEN
        expect(
          find.text('Tune Bookish for narration, sleep, and precise seeking.'),
          findsOneWidget,
        );
        expect(find.text('20 sec'), findsOneWidget);
        expect(find.text('30 sec'), findsOneWidget);

        await tester.tap(find.byType(DropdownButton<int>).at(0));
        await tester.pumpAndSettle();
        await tester.tap(find.text('45 sec').last);
        await tester.pumpAndSettle();

        await tester.tap(find.byType(DropdownButton<int>).at(1));
        await tester.pumpAndSettle();
        await tester.tap(find.text('60 sec').last);
        await tester.pumpAndSettle();

        await tester.tap(find.byType(DropdownButton<int>).at(2));
        await tester.pumpAndSettle();
        await tester.tap(find.text('30 min').last);
        await tester.pumpAndSettle();

        await tester.tap(find.text('Shorten silence'));
        await tester.pump();
        await tester.tap(find.text('Voice boost'));
        await tester.pump();
        await tester.tap(find.text('Continue series'));
        await tester.pump();

        expect(settings.savedPlayback, hasLength(6));
        expect(settings.playback.rewindSeconds, 45);
        expect(settings.playback.forwardSeconds, 60);
        expect(settings.playback.chapterFallbackMinutes, 30);
        expect(settings.playback.shortenSilence, isTrue);
        expect(settings.playback.voiceBoost, isTrue);
        expect(settings.playback.continueSeries, isFalse);
      },
    );

    testWidgets(
      'Given loaded playback preferences, When persistence rejects a control change, Then the previous value returns and failure is typed',
      (tester) async {
        // GIVEN
        settings.writeFailure = Exception('disk full');
        await tester.pumpBookishApp(
          display: const (
            themeMode: ThemeMode.light,
            locale: Locale('en'),
            viewport: Size(500, 1000),
            textScale: 1,
          ),
          child: Scaffold(body: _section(cubit)),
        );

        await tester.tap(find.text('Shorten silence'));
        // WHEN
        await tester.pumpAndSettle();

        // THEN
        expect(cubit.state.playback.shortenSilence, isFalse);
        expect(cubit.state.effectRevision, 1);
      },
    );
  });
}

Widget _section(SettingsCubit cubit) {
  return BlocBuilder<SettingsCubit, SettingsState>(
    bloc: cubit,
    builder: (_, state) => PlaybackSettingsSection(
      playback: state.playback,
      onChanged: cubit.setPlaybackPreferences,
    ),
  );
}
