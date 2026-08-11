import 'package:bookish_player/features/library/models/library_models.dart';
import 'package:bookish_player/features/library/models/audiobook_removal_mode.dart';
import 'package:bookish_player/features/library/ui/widgets/audiobook_removal_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/pump_bookish_app.dart';

void main() {
  group('Audiobook removal dialog', () {
    testWidgets(
      'Given an open dialog, When Remove audio only is selected, Then keep-user-data mode is returned',
      (tester) async {
        // GIVEN
        final harness = _RemovalDialogHarness(tester);
        await harness.open();

        // WHEN
        await harness.choose('Remove audio only');

        // THEN
        expect(harness.selected, AudiobookRemovalMode.keepUserData);
      },
    );
    testWidgets(
      'Given an open dialog, When Delete everything is selected, Then delete-all-data mode is returned',
      (tester) async {
        // GIVEN
        final harness = _RemovalDialogHarness(tester);
        await harness.open();

        // WHEN
        await harness.choose('Delete everything');

        // THEN
        expect(harness.selected, AudiobookRemovalMode.deleteAllData);
      },
    );
  });
}

final class _RemovalDialogHarness {
  _RemovalDialogHarness(this.tester);

  final WidgetTester tester;
  AudiobookRemovalMode? selected;

  Future<void> open() async {
    await tester.pumpBookishApp(
      child: Builder(
        builder: (context) => TextButton(
          onPressed: () async {
            selected = await showAudiobookRemovalDialog(context, _book);
          },
          child: const Text('Open dialog'),
        ),
      ),
    );
    await tester.tap(find.text('Open dialog'));
    await tester.pumpAndSettle();
  }

  Future<void> choose(String label) async {
    await tester.tap(find.text(label));
    await tester.pumpAndSettle();
  }
}

final _book = Audiobook(
  id: 'book',
  title: 'A Wizard of Earthsea',
  filePath: '/audio/earthsea.m4b',
  durationMs: 3600000,
  addedAt: DateTime.utc(2026),
);
