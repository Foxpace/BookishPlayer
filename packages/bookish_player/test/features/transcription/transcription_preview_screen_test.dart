import 'package:bookish_player/features/library/models/library_models.dart';
import 'package:bookish_player/features/transcription/cubits/transcription_preview_state.dart';
import 'package:bookish_player/features/transcription/models/transcription_draft.dart';
import 'package:bookish_player/features/transcription/ui/transcription_preview_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_support/support/pump_bookish_app.dart';
import '../../../test_support/features/transcription/transcription_preview_robot.dart';

void main() {
  group('Transcription preview screen', () {
    testWidgets(
      'Given the transcription preview screen, When its behavior is exercised, Then shows a transcription draft on a separate chapter-relative screen',
      (tester) async {
        final robot = TranscriptionPreviewRobot(tester);

        // GIVEN
        final state = TranscriptionPreviewState(
          draft: _draft(text: 'A quote worth keeping.'),
          text: 'A quote worth keeping.',
        );

        // WHEN
        await tester.pumpBookishApp(
          child: TranscriptionPreviewScreen(
            state: state,
            onEdit: (_) {},
            onSave: () {},
            onSaveAndShare: (_) {},
          ),
        );

        // THEN
        robot.expectDraft(const [
          'Preview quote',
          'Chapter two',
          '0:20 – 0:50 in chapter',
          'A quote worth keeping.',
          'Save to notes',
          'Save & share',
        ]);
        expect(find.text('Review and edit'), findsNothing);
      },
    );

    testWidgets(
      'Given an editable transcription, When text is changed and save and share is tapped, Then both intents are dispatched',
      (tester) async {
        // GIVEN
        final edits = <String>[];
        var saveAndShareCalls = 0;
        final state = TranscriptionPreviewState(
          draft: _draft(text: 'Original text'),
          text: 'Original text',
        );
        await tester.pumpBookishApp(
          child: TranscriptionPreviewScreen(
            state: state,
            onEdit: edits.add,
            onSave: () {},
            onSaveAndShare: (_) => saveAndShareCalls++,
          ),
        );
        await tester.enterText(find.byType(TextField), 'Edited text');

        // WHEN
        await tester.tap(find.text('Save & share'));
        await tester.pump();

        // THEN
        expect(edits, ['Edited text']);
        expect(saveAndShareCalls, 1);
      },
    );

    testWidgets(
      'Given a narrow screen, When actions are shown, Then both labels stay on one line',
      (tester) async {
        // GIVEN
        tester.view.physicalSize = const Size(459, 800);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        final state = TranscriptionPreviewState(
          draft: _draft(text: 'A quote worth keeping.'),
          text: 'A quote worth keeping.',
        );

        // WHEN
        await tester.pumpBookishApp(
          child: TranscriptionPreviewScreen(
            state: state,
            onEdit: (_) {},
            onSave: () {},
            onSaveAndShare: (_) {},
          ),
        );

        // THEN
        final saveLabelHeight = tester
            .getSize(find.text('Save to notes'))
            .height;
        final saveAndShareLabelHeight = tester
            .getSize(find.text('Save & share'))
            .height;
        expect(saveAndShareLabelHeight, saveLabelHeight);
      },
    );
  });
}

TranscriptionDraft _draft({required String text}) => TranscriptionDraft(
  book: Audiobook(
    id: 'book',
    title: 'The Book',
    filePath: '/book.mp3',
    durationMs: 600000,
    addedAt: DateTime(2026),
  ),
  text: text,
  start: const Duration(minutes: 5, seconds: 20),
  end: const Duration(minutes: 5, seconds: 50),
  chapterStart: const Duration(seconds: 20),
  chapterEnd: const Duration(seconds: 50),
  chapterTitle: 'Chapter two',
);
