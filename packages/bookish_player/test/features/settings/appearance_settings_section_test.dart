import 'package:bookish_player/features/settings/models/appearance_preferences.dart';
import 'package:bookish_player/features/settings/models/theme_preference.dart';
import 'package:bookish_player/features/settings/ui/widgets/appearance_settings_section.dart';
import 'package:bookish_player/features/settings/ui/widgets/primary_color_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_support/support/pump_bookish_app.dart';

void main() {
  group('Appearance settings section', () {
    testWidgets(
      'Given Android appearance settings, When system colors are disabled and a primary color is picked, Then both intents are emitted',
      (tester) async {
        // GIVEN
        bool? systemColors;
        int? primaryColor;
        await tester.pumpBookishApp(
          child: Scaffold(
            body: SingleChildScrollView(
              child: AppearanceSettingsSection(
                preferences: const AppearancePreferences(),
                supportsSystemColors: true,
                actions: (
                  onThemeChanged: (_) {},
                  onSystemColorsChanged: (value) => systemColors = value,
                  onPrimaryColorChanged: (value) => primaryColor = value,
                ),
              ),
            ),
          ),
        );

        // WHEN
        await tester.tap(find.text('Use Android system colors'));
        await tester.pump();
        await tester.tap(find.text('App color'));
        await tester.pumpAndSettle();
        final colorField = find.byKey(const ValueKey('primary-color-field'));
        final fieldRect = tester.getRect(colorField);
        await tester.tapAt(Offset(fieldRect.right - 24, fieldRect.top + 24));
        await tester.pump();
        await tester.tap(find.text('Save'));
        await tester.pumpAndSettle();

        // THEN
        expect(systemColors, isFalse);
        expect(primaryColor, isNotNull);
        expect(primaryColor, isNot(const AppearancePreferences().primaryColor));
        expect(find.byType(PrimaryColorPickerDialog), findsNothing);
      },
    );

    testWidgets(
      'Given a non-Android appearance screen, When it renders, Then the system color control is hidden and manual color remains available',
      (tester) async {
        // WHEN
        await tester.pumpBookishApp(
          child: Scaffold(
            body: AppearanceSettingsSection(
              preferences: const AppearancePreferences(
                theme: ThemePreference.dark,
              ),
              supportsSystemColors: false,
              actions: (
                onThemeChanged: (_) {},
                onSystemColorsChanged: (_) {},
                onPrimaryColorChanged: (_) {},
              ),
            ),
          ),
        );

        // THEN
        expect(find.text('Use Android system colors'), findsNothing);
        expect(find.text('App color'), findsOneWidget);
      },
    );
  });
}
