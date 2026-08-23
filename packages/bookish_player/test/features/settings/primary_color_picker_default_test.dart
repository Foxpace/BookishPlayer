import 'package:bookish_player/core/theme/bookish_theme_seed.dart';
import 'package:bookish_player/features/settings/ui/widgets/primary_color_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_support/support/pump_bookish_app.dart';

void main() {
  testWidgets(
    'Given a custom app color, When default color is chosen, Then the Bookish seed color is returned',
    (tester) async {
      // GIVEN
      int? selectedColor;
      await tester.pumpBookishApp(
        child: Builder(
          builder: (context) => Center(
            child: FilledButton(
              onPressed: () async {
                selectedColor = await showDialog<int>(
                  context: context,
                  builder: (_) =>
                      const PrimaryColorPickerDialog(initialColor: 0xFF336699),
                );
              },
              child: const Text('Open picker'),
            ),
          ),
        ),
      );

      // WHEN
      await tester.tap(find.text('Open picker'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Default color'));
      await tester.pumpAndSettle();

      // THEN
      expect(selectedColor, defaultBookishSeedColorValue);
      expect(find.byType(PrimaryColorPickerDialog), findsNothing);
    },
  );
}
