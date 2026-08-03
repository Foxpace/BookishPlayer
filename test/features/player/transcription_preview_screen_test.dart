import 'package:bookish_player/features/library/domain/audiobook.dart';
import 'package:bookish_player/features/player/domain/transcription_draft.dart';
import 'package:bookish_player/features/player/presentation/transcription_preview_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'shows a transcription draft on a separate chapter-relative screen',
    (tester) async {
      final book = Audiobook(
        id: 'book',
        title: 'The Book',
        filePath: '/book.mp3',
        durationMs: 600000,
        addedAt: DateTime(2026),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: TranscriptionPreviewScreen(
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
        ),
      );

      expect(find.text('Preview quote'), findsOneWidget);
      expect(find.text('Review and edit'), findsOneWidget);
      expect(find.text('Chapter two'), findsOneWidget);
      expect(find.text('0:20 – 0:50 in chapter'), findsOneWidget);
      expect(find.text('A quote worth keeping.'), findsOneWidget);
      expect(find.text('Save to notes'), findsOneWidget);
      expect(find.text('Share'), findsOneWidget);
    },
  );
}
