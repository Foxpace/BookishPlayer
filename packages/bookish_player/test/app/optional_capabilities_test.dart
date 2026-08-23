import 'package:bookish_player/features/player/cubits/player_cubits.dart';
import 'package:bookish_player/features/player/ui/widgets/player_tools.dart';
import 'package:bookish_player/features/settings/cubits/settings_state.dart';
import 'package:bookish_player/features/settings/ui/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_support/support/pump_bookish_app.dart';

void main() {
  testWidgets(
    'Given store player capabilities, When player tools render, Then quote transcription is omitted',
    (tester) async {
      // WHEN
      await tester.pumpBookishApp(
        child: Scaffold(
          body: PlayerTools(
            state: const PlayerState(),
            actions: (
              onPickAudioOutput: null,
              onChapters: null,
              onTimer: () {},
              onNotes: () {},
              onQuote: null,
              onSpeedChanged: (_) {},
            ),
          ),
        ),
      );

      // THEN
      expect(find.byIcon(Icons.format_quote_rounded), findsNothing);
      expect(find.text('Quote'), findsNothing);
    },
  );

  testWidgets(
    'Given store settings capabilities, When settings render, Then speech model settings are omitted',
    (tester) async {
      // WHEN
      await tester.pumpBookishApp(
        child: SettingsScreen(
          state: const SettingsState(),
          sections: (transcription: null, localData: const SizedBox.shrink()),
          actions: (
            onThemeChanged: (_) {},
            onSystemColorsChanged: (_) {},
            onPrimaryColorChanged: (_) {},
            onPlaybackChanged: (_) {},
            onNavigate: (_) {},
          ),
        ),
      );

      // THEN
      expect(find.text('Transcription'), findsNothing);
      expect(find.text('Speech-to-text model'), findsNothing);
    },
  );
}
