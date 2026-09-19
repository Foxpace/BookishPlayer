import 'package:bookish_player/features/player/ui/widgets/continue_listening_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_support/support/fixtures.dart';
import '../../../test_support/support/pump_bookish_app.dart';

void main() {
  testWidgets(
    'Given a continue listening sheet, When the barrier is tapped, Then the sheet closes and listening is cancelled',
    (tester) async {
      // GIVEN
      var cancelCalls = 0;
      await tester.pumpBookishApp(
        child: Scaffold(
          body: Builder(
            builder: (context) => FilledButton(
              onPressed: () => showContinueListeningSheet(
                context,
                book: audiobookFixture(),
                intents: (continueBook: () {}, cancel: () => cancelCalls++),
              ),
              child: const Text('Open continue listening'),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Open continue listening'));
      await tester.pumpAndSettle();

      // WHEN
      await tester.tapAt(const Offset(20, 20));
      await tester.pumpAndSettle();

      // THEN
      expect(find.text('Play'), findsNothing);
      expect(cancelCalls, 1);
    },
  );
}
