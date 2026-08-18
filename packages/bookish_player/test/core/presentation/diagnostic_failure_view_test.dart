import 'package:bookish_player/core/presentation/diagnostic_failure_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_support/support/pump_bookish_app.dart';

void main() {
  group('Diagnostic failure view', () {
    testWidgets(
      'Given the diagnostic failure view, When its behavior is exercised, Then hides details and offers retry and copy actions',
      (tester) async {
        // GIVEN
        var retries = 0;
        // WHEN
        await tester.pumpBookishApp(
          child: Scaffold(
            body: DiagnosticFailureView.fromMessage(
              message: 'Could not load books.\nFormatException: invalid record',
              onRetry: () => retries++,
            ),
          ),
        );

        // THEN
        expect(find.text('Could not load books.'), findsOneWidget);
        expect(
          find.textContaining('sorry for the inconvenience'),
          findsOneWidget,
        );
        expect(find.text('FormatException: invalid record'), findsNothing);

        await tester.tap(find.text('Try again'));
        expect(retries, 1);
        await tester.tap(find.text('Error details'));
        await tester.pumpAndSettle();

        expect(find.text('FormatException: invalid record'), findsOneWidget);
        expect(find.text('Copy error details'), findsOneWidget);
      },
    );
  });
}
