import 'package:bookish_player/features/library/domain/audiobook.dart';
import 'package:bookish_player/features/library/domain/audiobook_removal_mode.dart';
import 'package:bookish_player/features/library/presentation/widgets/audiobook_removal_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  for (final testCase in <(String, AudiobookRemovalMode)>[
    ('Remove audio only', AudiobookRemovalMode.keepUserData),
    ('Delete everything', AudiobookRemovalMode.deleteAllData),
  ]) {
    testWidgets('${testCase.$1} returns the matching removal mode', (
      tester,
    ) async {
      AudiobookRemovalMode? selected;
      final book = Audiobook(
        id: 'book',
        title: 'A Wizard of Earthsea',
        filePath: '/audio/earthsea.m4b',
        durationMs: 3600000,
        addedAt: DateTime.utc(2026),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => TextButton(
              onPressed: () async {
                selected = await showAudiobookRemovalDialog(context, book);
              },
              child: const Text('Open dialog'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open dialog'));
      await tester.pumpAndSettle();
      expect(find.textContaining('Original files outside Bookish'), findsOne);

      await tester.tap(find.text(testCase.$1));
      await tester.pumpAndSettle();

      expect(selected, testCase.$2);
    });
  }
}
