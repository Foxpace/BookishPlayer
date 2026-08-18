import 'package:bookish_player/features/library/cubits/library_intents.dart';
import 'package:bookish_player/features/library/ui/widgets/book_actions_menu.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_support/support/fixtures.dart';
import '../../../test_support/support/pump_bookish_app.dart';

void main() {
  group('Book actions menu with a typed callback', () {
    testWidgets(
      'Given a book actions menu with a typed callback, When the reader chooses to mark the book finished, Then the corresponding BookAction is dispatched',
      (tester) async {
        // GIVEN
        BookAction? selectedAction;
        await tester.pumpBookishApp(
          child: BookActionsMenu(
            book: audiobookFixture(),
            onSelected: (action) => selectedAction = action,
          ),
        );

        await tester.tap(find.byTooltip('Book actions'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Mark finished'));
        // WHEN
        await tester.pumpAndSettle();

        // THEN
        expect(selectedAction, BookAction.markFinished);
      },
    );
  });
}
