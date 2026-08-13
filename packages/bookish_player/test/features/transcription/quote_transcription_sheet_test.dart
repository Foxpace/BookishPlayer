import 'package:bookish_player/features/library/models/library_models.dart';
import 'package:bookish_player/features/player/repos/player_repositories.dart';
import 'package:bookish_player/features/transcription/models/transcription_draft.dart';
import 'package:bookish_player/features/transcription/repos/transcription_preferences.dart';
import 'package:bookish_player/features/transcription/repos/transcription_repositories.dart';
import 'package:bookish_player/features/transcription/cubits/quote_transcription_cubit.dart';
import 'package:bookish_player/features/transcription/cubits/transcription_cubits.dart';
import 'package:bookish_player/features/transcription/ui/widgets/transcription_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/fixtures.dart';
import '../../support/pump_bookish_app.dart';
import 'transcription_test_builder.dart';

void main() {
  group('Prepared on-device quote range', () {
    late _Transcription transcription;
    late QuoteTranscriptionCubit cubit;

    setUp(() {
      transcription = _Transcription();
      cubit = QuoteTranscriptionCubit(
        buildQuoteTranscriptionUseCases(
          transcription: transcription,
          preferences: _Preferences(),
          sharing: _Sharing(),
        ),
      );
      cubit.prepare(
        book: audiobookFixture(),
        chapterTitle: 'A chapter',
        chapterStart: const Duration(minutes: 10),
        chapterDuration: const Duration(minutes: 2),
        anchor: const Duration(minutes: 1),
      );
    });

    tearDown(() => cubit.close());

    testWidgets(
      'Given a prepared on-device quote range, When preset and shift intents are followed by transcription, Then the local draft closes the sheet as its result',
      (tester) async {
        // GIVEN
        TranscriptionDraft? result;
        await tester.pumpBookishApp(
          child: BlocProvider.value(
            value: cubit,
            child: Scaffold(
              body: Builder(
                builder: (context) => FilledButton(
                  onPressed: () async {
                    result = await showModalBottomSheet<TranscriptionDraft>(
                      context: context,
                      isScrollControlled: true,
                      builder: (_) => _TranscriptionHarness(
                        cubit: cubit,
                        chapterTitle: 'A chapter',
                      ),
                    );
                  },
                  child: const Text('Open transcription'),
                ),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Open transcription'));
        // WHEN
        await tester.pumpAndSettle();
        // THEN
        expect(find.text('Transcribe a quote'), findsOneWidget);
        expect(find.text('A chapter'), findsOneWidget);

        await tester.tap(find.text('Last 30 sec'));
        await tester.pump();
        await tester.tap(find.text('15 sec earlier'));
        await tester.pump();
        await tester.tap(find.text('15 sec later'));
        await tester.pump();
        await tester.tap(find.text('Transcribe range'));
        await tester.pumpAndSettle();

        expect(result?.text, 'A local quote');
        expect(result?.chapterTitle, 'A chapter');
        expect(transcription.models, ['whisper-small']);
        expect(transcription.ranges, hasLength(1));
        expect(find.text('Transcribe a quote'), findsNothing);
      },
    );

    testWidgets(
      'Given a prepared on-device quote range, When the selected range has no speech, Then the typed failure remains visible for adjustment',
      (tester) async {
        // GIVEN
        transcription.response = '   ';
        await tester.pumpBookishApp(
          child: BlocProvider.value(
            value: cubit,
            child: Scaffold(
              body: Builder(
                builder: (context) => FilledButton(
                  onPressed: () => showModalBottomSheet<void>(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) => _TranscriptionHarness(cubit: cubit),
                  ),
                  child: const Text('Open transcription'),
                ),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Open transcription'));
        await tester.pumpAndSettle();
        await tester.ensureVisible(find.text('Transcribe range'));
        await tester.tap(find.text('Transcribe range'));
        // WHEN
        await tester.pumpAndSettle();

        // THEN
        expect(
          find.text('No speech was detected in this range.'),
          findsOneWidget,
        );
        expect(find.text('Transcribe a quote'), findsOneWidget);
      },
    );
  });
}

class _TranscriptionHarness extends StatelessWidget {
  const _TranscriptionHarness({required this.cubit, this.chapterTitle});

  final QuoteTranscriptionCubit cubit;
  final String? chapterTitle;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuoteTranscriptionCubit, QuoteTranscriptionState>(
      bloc: cubit,
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status == QuoteTranscriptionStatus.complete,
      listener: (context, state) => Navigator.pop(context, state.draft),
      builder: (_, state) => TranscriptionSheet(
        state: state,
        chapter: (title: chapterTitle, duration: const Duration(minutes: 2)),
        actions: (
          onStartChanged: cubit.setStart,
          onEndChanged: cubit.setEnd,
          onPreset: cubit.applyPreset,
          onShift: cubit.shift,
          onTranscribe: cubit.transcribe,
        ),
      ),
    );
  }
}

class _Preferences implements TranscriptionPreferences {
  @override
  Future<String?> getSelectedModel() async => 'whisper-small';

  @override
  Future<void> setSelectedModel(String model) async {}
}

class _Transcription implements TranscriptionRepository {
  var response = 'A local quote';
  final models = <String>[];
  final ranges = <(Duration, Duration)>[];

  @override
  Future<String> transcribeRange({
    required Audiobook book,
    required Duration start,
    required Duration end,
    required String model,
  }) async {
    models.add(model);
    ranges.add((start, end));
    return response;
  }

  @override
  Future<List<SpeechModel>> getModels({bool refresh = true}) async => const [];

  @override
  Future<bool> isModelDownloaded(String slug) async => true;

  @override
  Future<void> downloadModel(
    String slug, {
    TranscriptionDownloadProgress? onProgress,
  }) async {}

  @override
  Future<void> reset() async {}
}

class _Sharing implements QuoteShareRepository {
  @override
  Future<void> share({
    required String text,
    required String subject,
    ShareOrigin? origin,
  }) async {}
}
