import 'package:bookish_player/core/di/injection.dart';
import 'package:bookish_player/features/library/models/library_models.dart';
import 'package:bookish_player/features/player/models/share_origin.dart';
import 'package:bookish_player/features/player/repos/quote_share_repository.dart';
import 'package:bookish_player/features/transcription/models/transcription_draft.dart';
import 'package:bookish_player/features/transcription/repos/transcription_preferences.dart';
import 'package:bookish_player/features/transcription/repos/transcription_repository.dart';
import 'package:bookish_player/features/transcription/transcription_preview_root.dart';
import 'package:bookish_player/features/transcription/use_cases/quote_transcription_application.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_support/support/pump_bookish_app.dart';

void main() {
  group('Transcription preview root', () {
    testWidgets(
      'Given a transcription preview opened from the player, When save and share completes, Then the player is shown again',
      (tester) async {
        // GIVEN
        final sharing = _QuoteSharing();
        getIt.registerSingleton(
          QuoteTranscriptionApplication(
            _Transcription(),
            _TranscriptionPreferences(),
            sharing,
          ),
        );
        addTearDown(getIt.reset);
        await tester.pumpBookishApp(child: const _PlayerHarness());
        await tester.tap(find.text('Open transcription'));
        await tester.pumpAndSettle();

        // WHEN
        await tester.tap(find.text('Save & share'));
        await tester.pumpAndSettle();

        // THEN
        expect(find.text('Player'), findsOneWidget);
        expect(find.text('Preview quote'), findsNothing);
        expect(sharing.calls, 1);
      },
    );
  });
}

class _PlayerHarness extends StatelessWidget {
  const _PlayerHarness();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text('Player'),
          FilledButton(
            onPressed: () => Navigator.of(context).push<void>(
              MaterialPageRoute(
                builder: (_) => TranscriptionPreviewRoot(
                  draft: _draft,
                  onSave: (_, _) async {},
                ),
              ),
            ),
            child: const Text('Open transcription'),
          ),
        ],
      ),
    );
  }
}

class _Transcription implements TranscriptionRepository {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _TranscriptionPreferences implements TranscriptionPreferences {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _QuoteSharing implements QuoteShareRepository {
  var calls = 0;

  @override
  Future<void> share({
    required String text,
    required String subject,
    ShareOrigin? origin,
  }) async {
    calls++;
  }
}

final _draft = TranscriptionDraft(
  book: Audiobook(
    id: 'book',
    title: 'The Book',
    filePath: '/book.mp3',
    durationMs: 600000,
    addedAt: DateTime(2026),
  ),
  text: 'A quote worth keeping.',
  start: const Duration(minutes: 5, seconds: 20),
  end: const Duration(minutes: 5, seconds: 50),
  chapterStart: const Duration(seconds: 20),
  chapterEnd: const Duration(seconds: 50),
  chapterTitle: 'Chapter two',
);
