import 'package:bookish_player/features/settings/cubits/settings_intents.dart';
import 'package:bookish_player/features/settings/ui/widgets/library_settings_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/pump_bookish_app.dart';

void main() {
  group('Library settings section with a typed callback', () {
    testWidgets(
      'Given the library settings section with a typed callback, When both library destinations are selected, Then it emits the matching navigation intents',
      (tester) async {
        // GIVEN
        final intents = <SettingsNavigationIntent>[];
        await tester.pumpBookishApp(
          child: Scaffold(
            body: LibrarySettingsSection(onNavigate: intents.add),
          ),
        );

        await tester.tap(find.text('Listening insights'));
        // WHEN
        await tester.tap(find.text('Storage assistant'));

        // THEN
        expect(intents, [
          SettingsNavigationIntent.listeningInsights,
          SettingsNavigationIntent.storageAssistant,
        ]);
      },
    );
  });
}
