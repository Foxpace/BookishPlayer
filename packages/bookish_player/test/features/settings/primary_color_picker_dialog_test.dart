import 'package:bookish_player/features/settings/models/appearance_preferences.dart';
import 'package:bookish_player/features/settings/ui/widgets/primary_color_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_support/support/pump_bookish_app.dart';

void main() {
  testWidgets(
    'Given the app color dialog, When it opens, Then it offers a visual color field and hue strip',
    (tester) async {
      // GIVEN
      const preferences = AppearancePreferences();
      await tester.pumpBookishApp(
        child: Builder(
          builder: (context) => Center(
            child: FilledButton(
              onPressed: () => showDialog<void>(
                context: context,
                builder: (_) => PrimaryColorPickerDialog(
                  initialColor: preferences.primaryColor,
                ),
              ),
              child: const Text('Open picker'),
            ),
          ),
        ),
      );

      // WHEN
      await tester.tap(find.text('Open picker'));
      await tester.pumpAndSettle();

      // THEN
      expect(find.byKey(const ValueKey('primary-color-field')), findsOneWidget);
      expect(
        find.byKey(const ValueKey('primary-color-hue-strip')),
        findsOneWidget,
      );
      expect(find.byType(Slider), findsNothing);
      await expectLater(
        find.byType(PrimaryColorPickerDialog),
        matchesGoldenFile('goldens/primary_color_picker.png'),
      );
    },
  );
}
