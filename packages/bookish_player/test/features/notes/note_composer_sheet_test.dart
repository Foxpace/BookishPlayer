import 'package:bookish_player/features/notes/ui/widgets/note_composer_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_support/support/pump_bookish_app.dart';

void main() {
  group('Localized note composer', () {
    testWidgets(
      'Given a localized note composer, When note text is entered and saved, Then the sheet returns text after its route safely closes',
      (tester) async {
        // GIVEN
        String? result;
        await tester.pumpBookishApp(
          child: Scaffold(
            body: Builder(
              builder: (context) => FilledButton(
                onPressed: () async {
                  result = await showNoteComposerSheet(
                    context,
                    heading: 'Chapter one · 02:10',
                  );
                },
                child: const Text('Open note composer'),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Open note composer'));
        // WHEN
        await tester.pumpAndSettle();
        // THEN
        expect(find.text('Chapter one · 02:10'), findsOneWidget);
        expect(find.text('A thought worth returning to…'), findsOneWidget);

        await tester.enterText(find.byType(TextField), 'A useful thought');
        await tester.tap(find.text('Save note'));
        await tester.pumpAndSettle();

        expect(result, 'A useful thought');
        expect(tester.takeException(), isNull);
      },
    );
  });
}
