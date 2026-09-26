import 'package:bookish_player/features/player/ui/widgets/player_notes_header.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_support/support/pump_bookish_app.dart';

void main() {
  testWidgets(
    'Given the notes header, When it opens, Then note and voice actions remain without a bookmark action',
    (tester) async {
      // GIVEN
      var notes = 0;
      var voiceNotes = 0;
      await tester.pumpBookishApp(
        child: Scaffold(
          body: PlayerNotesHeader(
            hasNotes: false,
            actions: (
              onAddNote: () => notes++,
              onAddVoiceNote: () => voiceNotes++,
              onExport: () {},
            ),
          ),
        ),
      );

      // WHEN
      await tester.tap(find.byTooltip('Add note at current position'));
      await tester.tap(find.byTooltip('Dictate voice note'));

      // THEN
      expect(notes, 1);
      expect(voiceNotes, 1);
      expect(find.text('Notes'), findsOneWidget);
      expect(find.byIcon(Icons.bookmark_add_rounded), findsNothing);
    },
  );
}
