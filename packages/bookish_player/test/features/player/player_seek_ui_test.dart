import 'package:bookish_player/features/player/ui/player_seek_ui.dart';

import '../../../test_support/features/player/player_test_support.dart';

void main() {
  testWidgets(
    'Given seek feedback, When it is shown, Then it is configured as brief non-persistent feedback',
    (tester) async {
      // GIVEN
      await tester.pumpWidget(
        PlayerTestApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: TextButton(
                onPressed: () => context.showSeekUndo(() {}),
                child: const Text('Seek'),
              ),
            ),
          ),
        ),
      );

      // WHEN
      await tester.tap(find.text('Seek'));
      await tester.pump(const Duration(milliseconds: 250));
      await tester.pump();

      // THEN
      final snackBar = tester.widget<SnackBar>(find.byType(SnackBar));
      expect(snackBar.duration, const Duration(seconds: 2));
      expect(snackBar.behavior, SnackBarBehavior.floating);
      expect(snackBar.persist, isFalse);
    },
  );
}
