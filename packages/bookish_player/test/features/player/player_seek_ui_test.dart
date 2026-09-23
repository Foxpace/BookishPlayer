import 'package:bookish_player/features/player/ui/player_seek_ui.dart';

import '../../../test_support/features/player/player_test_support.dart';

void main() {
  testWidgets(
    'Given a large forward jump, When it is cancelled, Then the dialog rejects the seek without a toast',
    (tester) async {
      // GIVEN
      bool? confirmed;
      await tester.pumpWidget(
        PlayerTestApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: TextButton(
                onPressed: () async {
                  confirmed = await context.confirmLargeSeek(
                    const Duration(minutes: 12),
                  );
                },
                child: const Text('Jump forward'),
              ),
            ),
          ),
        ),
      );

      // WHEN
      await tester.tap(find.text('Jump forward'));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.byType(SnackBar), findsNothing);
      await tester.tap(
        find.descendant(
          of: find.byType(AlertDialog),
          matching: find.byType(TextButton),
        ),
      );
      await tester.pumpAndSettle();

      // THEN
      expect(confirmed, isFalse);
      expect(find.byType(SnackBar), findsNothing);
    },
  );

  testWidgets(
    'Given a large backward jump, When it is confirmed, Then the same dialog accepts the seek without a toast',
    (tester) async {
      // GIVEN
      bool? confirmed;
      await tester.pumpWidget(
        PlayerTestApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: TextButton(
                onPressed: () async {
                  confirmed = await context.confirmLargeSeek(
                    const Duration(minutes: -12),
                  );
                },
                child: const Text('Jump backward'),
              ),
            ),
          ),
        ),
      );

      // WHEN
      await tester.tap(find.text('Jump backward'));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.byType(SnackBar), findsNothing);
      await tester.tap(
        find.descendant(
          of: find.byType(AlertDialog),
          matching: find.byType(FilledButton),
        ),
      );
      await tester.pumpAndSettle();

      // THEN
      expect(confirmed, isTrue);
      expect(find.byType(SnackBar), findsNothing);
    },
  );
}
