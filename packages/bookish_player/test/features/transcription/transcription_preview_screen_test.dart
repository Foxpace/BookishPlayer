import 'package:bookish_player/features/library/models/library_models.dart';
import 'package:bookish_player/features/transcription/models/transcription_draft.dart';
import 'package:bookish_player/features/transcription/ui/transcription_preview_screen.dart';
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
        final book = Audiobook(
          id: 'book',
          title: 'The Book',
          filePath: '/book.mp3',
          durationMs: 600000,
          addedAt: DateTime(2026),
        );
        // WHEN
        await tester.pumpBookishApp(
          child: TranscriptionPreviewScreen(
            onSave: (_, _) async {},
            onShare: (_, {required subject, origin}) async {},
            draft: TranscriptionDraft(
              book: book,
              text: 'A quote worth keeping.',
              start: const Duration(minutes: 5, seconds: 20),
              end: const Duration(minutes: 5, seconds: 50),
              chapterStart: const Duration(seconds: 20),
              chapterEnd: const Duration(seconds: 50),
              chapterTitle: 'Chapter two',
            ),
          ),
        );

        // THEN
        robot.expectDraft(const [
          'Preview quote',
          'Review and edit',
          'Chapter two',
          '0:20 – 0:50 in chapter',
          'A quote worth keeping.',
          'Save to notes',
          'Share',
        ]);
      },
    );
  });
}
