import 'package:bookish_player/features/settings/ui/widgets/bookish_about_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/pump_bookish_app.dart';

void main() {
  group('Bookish about dialog', () {
    testWidgets(
      'Given the Bookish about dialog, When the licenses action is selected, Then it emits a typed dialog action',
      (tester) async {
        // GIVEN
        BookishAboutDialogAction? selectedAction;
        await tester.pumpBookishApp(
          child: Scaffold(
            body: BookishAboutDialog(
              onAction: (action) => selectedAction = action,
            ),
          ),
        );

        // WHEN
        await tester.tap(find.text('View licenses'));

        // THEN
        expect(selectedAction, BookishAboutDialogAction.openLicenses);
      },
    );
  });
}
