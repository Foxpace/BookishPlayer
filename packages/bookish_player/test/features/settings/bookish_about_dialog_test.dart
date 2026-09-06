import 'package:bookish_player/core/app_metadata.dart';
import 'package:bookish_player/features/settings/ui/widgets/bookish_about_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_support/support/pump_bookish_app.dart';

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
              versionName: '2.4.6',
              buildNumber: '81',
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

    testWidgets(
      'Given app metadata, When the dialog is shown, Then it displays the app icon, version name, and build number',
      (tester) async {
        // GIVEN
        await tester.pumpBookishApp(
          child: BookishAboutDialog(
            versionName: '2.4.6',
            buildNumber: '81',
            onAction: (_) {},
          ),
        );

        // WHEN
        final appIcon = tester.widget<Image>(find.byType(Image));

        // THEN
        expect(appIcon.image, isA<AssetImage>());
        expect((appIcon.image as AssetImage).assetName, appIconAsset);
        expect(find.text('Version 2.4.6'), findsOneWidget);
        expect(find.text('Build 81'), findsOneWidget);
      },
    );
  });
}
