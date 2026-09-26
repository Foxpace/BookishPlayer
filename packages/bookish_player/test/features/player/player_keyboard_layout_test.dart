import 'package:bookish_player/features/library/models/audiobook.dart';
import 'package:bookish_player/features/notes/ui/widgets/note_composer_sheet.dart';
import 'package:bookish_player/features/player/cubits/player_cubits.dart';
import 'package:bookish_player/features/player/ui/player_screen.dart';
import 'package:bookish_player/features/player/ui/widgets/player_artwork.dart';
import 'package:bookish_player/features/player/ui/widgets/player_content.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_support/support/pump_bookish_app.dart';

void main() {
  testWidgets(
    'Given the player, When composing a note with the keyboard open, Then the background layout stays unchanged',
    (tester) async {
      // GIVEN
      await tester.pumpBookishApp(
        child: Builder(builder: (context) => _player(context)),
      );
      await tester.pumpAndSettle();
      final content = find.byType(PlayerContent, skipOffstage: false);
      final artwork = find.byType(PlayerArtwork, skipOffstage: false);
      final contentBounds = tester.getRect(content);
      final artworkBounds = tester.getRect(artwork);

      // WHEN
      await tester.tap(find.byTooltip('Notes'));
      await tester.pumpAndSettle();
      addTearDown(tester.view.resetViewInsets);
      for (final height in [100.0, 200.0, 300.0]) {
        tester.view.viewInsets = FakeViewPadding(bottom: height);
        await tester.pumpAndSettle();

        // THEN
        expect(tester.getRect(content), contentBounds);
        expect(tester.getRect(artwork), artworkBounds);
        expect(
          tester.getBottomLeft(find.text('Save note')).dy,
          lessThan(tester.view.physicalSize.height - height),
        );
        expect(tester.takeException(), isNull);
      }

      await tester.enterText(find.byType(TextField), 'A new thought');
      await tester.tap(find.text('Save note'));
      tester.view.resetViewInsets();
      await tester.pumpAndSettle();
      expect(find.byType(TextField), findsNothing);
      expect(tester.getRect(artwork), artworkBounds);
    },
  );
}

Widget _player(BuildContext context) => PlayerScreen(
  state: PlayerState(
    book: Audiobook(
      id: 'book',
      title: 'A book',
      filePath: '/book.m4b',
      durationMs: 600000,
      addedAt: DateTime(2026),
    ),
  ),
  intents: (
    pausePlayback: () async {},
    togglePlayback: () async {},
    previousChapter: () async {},
    nextChapter: () async {},
    skipBy: (_) async {},
    changeSpeed: (_) async {},
    seek: (_) async {},
    seekWithinChapter: (_) async {},
  ),
  actions: (
    onDidPop: () {},
    onBack: () {},
    onOpenSettings: () {},
    onTimelineSeek: (_) {},
    onPickAudioOutput: null,
    onShowChapters: () {},
    onShowSleepTimer: () {},
    onShowNotes: () => showNoteComposerSheet(context, heading: 'Add note'),
    onTranscribeQuote: null,
  ),
);
