import 'package:bookish_player/features/importing/models/import_models.dart';
import 'package:bookish_player/features/importing/cubits/import_cubits.dart';
import 'package:bookish_player/features/importing/ui/widgets/import_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/pump_bookish_app.dart';

void main() {
  group('Audiobook import presentation', () {
    testWidgets(
      'Given the audiobook import presentation, When a file is copying in the light English appearance, Then progress matches the approved golden',
      (tester) async {
        // WHEN
        await tester.pumpBookishApp(
          child: const ImportView(
            state: ImportState(
              status: ImportStatus.importing,
              stage: ImportStage.copyingFile,
              heading: ImportHeading.copyingAudiobook,
              detail: ImportDetail.copyProgress,
              currentTitle: 'The Dispossessed.m4b',
              copiedBytes: 25 * 1024 * 1024,
              totalBytes: 100 * 1024 * 1024,
              progress: .25,
            ),
            actions: (
              retry: _ignore,
              copyDiagnostics: _ignoreAsync,
              back: _ignore,
            ),
          ),
        );

        // THEN
        await expectLater(
          find.byType(Scaffold),
          matchesGoldenFile('goldens/import_progress_light_en.png'),
        );
      },
    );

    testWidgets(
      'Given the audiobook import presentation, When import fails in the dark Slovak appearance, Then failure matches the approved golden',
      (tester) async {
        // WHEN
        await tester.pumpBookishApp(
          display: const (
            themeMode: ThemeMode.dark,
            locale: Locale('sk'),
            viewport: Size(390, 844),
            textScale: 1.2,
          ),
          child: const ImportView(
            state: ImportState(
              status: ImportStatus.failure,
              stage: ImportStage.readingDuration,
              failureStage: ImportStage.readingDuration,
              heading: ImportHeading.fileAccessFailed,
              detail: ImportDetail.stageFailed,
              diagnostics: 'Sanitized local diagnostic',
            ),
            actions: (
              retry: _ignore,
              copyDiagnostics: _ignoreAsync,
              back: _ignore,
            ),
          ),
        );

        // THEN
        await expectLater(
          find.byType(Scaffold),
          matchesGoldenFile('goldens/import_failure_dark_sk.png'),
        );
      },
    );
  });
}

void _ignore() {}

Future<void> _ignoreAsync() async {}
