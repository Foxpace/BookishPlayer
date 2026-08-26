import 'package:bookish_player/features/notes/models/book_note.dart';
import 'package:bookish_player/features/player/ui/widgets/player_note_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_support/support/pump_bookish_app.dart';

void main() {
  testWidgets(
    'Given a player note, When it is shown and long-pressed, Then it opens from the arrow and deletes from the menu',
    (tester) async {
      // GIVEN
      var openCount = 0;
      var deleteCount = 0;
      final note = BookNote(
        id: 'note',
        metadataId: 'book',
        positionMs: 65000,
        text: 'A note',
        createdAt: DateTime(2026),
      );

      // WHEN
      await tester.pumpBookishApp(
        child: Scaffold(
          body: PlayerNoteTile(
            note: note,
            chapters: const [],
            actions: (
              onOpen: () => openCount += 1,
              onDelete: () => deleteCount += 1,
            ),
          ),
        ),
      );

      // THEN
      expect(tester.widget<ListTile>(find.byType(ListTile)).leading, isNull);
      expect(find.byIcon(Icons.play_arrow_rounded), findsNothing);
      expect(find.byIcon(Icons.delete_outline_rounded), findsNothing);
      expect(find.byIcon(Icons.chevron_right_rounded), findsOneWidget);

      await tester.tap(find.byIcon(Icons.chevron_right_rounded));
      expect(openCount, 1);
      expect(deleteCount, 0);

      await tester.longPress(find.text('A note'));
      await tester.pumpAndSettle();
      expect(find.text('Delete note'), findsOneWidget);

      await tester.tap(find.text('Delete note'));
      await tester.pumpAndSettle();
      expect(deleteCount, 1);
    },
  );
}
