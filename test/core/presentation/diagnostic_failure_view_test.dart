import 'package:bookish_player/core/presentation/diagnostic_failure_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('hides details and offers retry and copy actions', (
    tester,
  ) async {
    var retries = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DiagnosticFailureView.fromMessage(
            message: 'Could not load books.\nFormatException: invalid record',
            onRetry: () => retries++,
          ),
        ),
      ),
    );

    expect(find.text('Could not load books.'), findsOneWidget);
    expect(find.textContaining('sorry for the inconvenience'), findsOneWidget);
    expect(find.text('FormatException: invalid record'), findsNothing);

    await tester.tap(find.text('Try again'));
    expect(retries, 1);
    await tester.tap(find.text('Error details'));
    await tester.pumpAndSettle();

    expect(find.text('FormatException: invalid record'), findsOneWidget);
    expect(find.text('Copy error details'), findsOneWidget);
  });
}
