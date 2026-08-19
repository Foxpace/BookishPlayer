import 'package:bookish_player/features/importing/cubits/import_cubits.dart';
import 'package:bookish_player/features/importing/ui/import_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_support/support/pump_bookish_app.dart';

void main() {
  testWidgets(
    'Given an active import screen, When it renders, Then normal back is blocked and only the explicit cancel action requests cancellation',
    (tester) async {
      // GIVEN
      var cancellationCount = 0;

      // WHEN
      await tester.pumpBookishApp(
        child: ImportScreen(
          state: const ImportState(
            status: ImportStatus.importing,
            heading: ImportHeading.copyingAudiobook,
            detail: ImportDetail.keepAppOpen,
          ),
          actions: (
            retry: _ignore,
            cancel: () => cancellationCount++,
            copyDiagnostics: _ignoreAsync,
            back: _ignore,
          ),
        ),
      );

      // THEN
      expect(
        tester.widget<PopScope<void>>(find.byType(PopScope)).canPop,
        isFalse,
      );
      await tester.tap(find.text('Cancel'));
      expect(cancellationCount, 1);
    },
  );

  testWidgets(
    'Given a completed import screen, When it renders, Then normal back is available',
    (tester) async {
      // WHEN
      await tester.pumpBookishApp(
        child: const ImportScreen(
          state: ImportState(status: ImportStatus.complete),
          actions: (
            retry: _ignore,
            cancel: _ignore,
            copyDiagnostics: _ignoreAsync,
            back: _ignore,
          ),
        ),
      );

      // THEN
      expect(
        tester.widget<PopScope<void>>(find.byType(PopScope)).canPop,
        isTrue,
      );
    },
  );
}

void _ignore() {}

Future<void> _ignoreAsync() async {}
