import 'package:bookish_player/features/library/models/library_models.dart';
import 'package:bookish_player/features/transcription/repos/transcription_preferences.dart';
import 'package:bookish_player/features/transcription/models/speech_model.dart';
import 'package:bookish_player/features/transcription/models/transcription_download.dart';
import 'package:bookish_player/features/transcription/repos/transcription_repository.dart';
import 'package:bookish_player/features/transcription/cubits/speech_models_cubit.dart';
import 'package:bookish_player/features/transcription/cubits/transcription_cubits.dart';
import 'package:bookish_player/features/transcription/ui/speech_models_section.dart';
import 'package:bookish_player/features/transcription/ui/widgets/speech_model_picker_sheet.dart';
import 'package:bookish_player/core/presentation/app_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_support/support/pump_bookish_app.dart';
import '../../../test_support/features/transcription/transcription_test_builder.dart';

void main() {
  group('Local speech-model catalog', () {
    late _Transcription transcription;
    late _Preferences preferences;
    late SpeechModelsCubit cubit;

    setUp(() async {
      transcription = _Transcription();
      preferences = _Preferences()..selected = 'whisper-tiny';
      cubit = SpeechModelsCubit(
        buildSpeechModelApplication(
          transcription: transcription,
          preferences: preferences,
        ),
      );
      await cubit.load();
    });

    tearDown(() => cubit.close());

    testWidgets(
      'Given a local speech-model catalog, When an unavailable model is selected, Then it downloads locally and becomes the selected model',
      (tester) async {
        // WHEN
        await tester.pumpBookishApp(
          child: Scaffold(body: _SpeechModelsHarness(cubit: cubit)),
        );

        // THEN
        expect(find.text('Whisper Tiny'), findsOneWidget);
        expect(find.text('75 MB · Downloaded'), findsOneWidget);
        await tester.tap(find.text('Whisper Tiny'));
        await tester.pumpAndSettle();

        expect(find.text('Choose speech model'), findsOneWidget);
        expect(find.text('200 MB · Available to download'), findsOneWidget);
        await tester.tap(find.text('Whisper Small'));
        await tester.pumpAndSettle();

        expect(transcription.downloadedSlugs, ['whisper-small']);
        expect(preferences.selected, 'whisper-small');
        expect(cubit.state.selectedModelIsDownloaded, isTrue);
        expect(find.text('Speech model downloaded and ready.'), findsOneWidget);
        expect(find.text('Choose speech model'), findsNothing);
      },
    );

    testWidgets(
      'Given a local speech-model catalog, When a model download fails, Then the sheet remains open and a typed failure is shown',
      (tester) async {
        // GIVEN
        transcription.downloadFailure = Exception('offline');
        await tester.pumpBookishApp(
          child: Scaffold(body: _SpeechModelsHarness(cubit: cubit)),
        );

        await tester.tap(find.text('Whisper Tiny'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Whisper Small'));
        // WHEN
        await tester.pumpAndSettle();

        // THEN
        expect(find.text('Choose speech model'), findsOneWidget);
        expect(
          find.text('Could not download the speech model.'),
          findsOneWidget,
        );
        expect(cubit.state.effectRevision, 1);
      },
    );
  });

  group('Empty local speech-model catalog', () {
    testWidgets(
      'Given an empty local speech-model catalog, When the section is rendered, Then model selection is disabled with a clear empty state',
      (tester) async {
        // GIVEN
        final cubit = SpeechModelsCubit(
          buildSpeechModelApplication(
            transcription: _Transcription()..models = const [],
            preferences: _Preferences(),
          ),
        );
        addTearDown(cubit.close);
        await cubit.load();

        // WHEN
        await tester.pumpBookishApp(
          child: Scaffold(body: _SpeechModelsHarness(cubit: cubit)),
        );

        // THEN
        expect(find.text('No speech models available'), findsOneWidget);
        await tester.tap(find.text('No speech models available'));
        await tester.pumpAndSettle();
        expect(find.text('Choose speech model'), findsNothing);
      },
    );
  });
}

class _SpeechModelsHarness extends StatelessWidget {
  const _SpeechModelsHarness({required this.cubit});

  final SpeechModelsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SpeechModelsCubit, SpeechModelsState>(
      bloc: cubit,
      listenWhen: (previous, current) =>
          current.message != null &&
          previous.effectRevision != current.effectRevision,
      listener: (context, state) {
        final message = state.message;
        if (message != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(message.localize(context))));
        }
      },
      builder: (context, state) => SpeechModelsSection(
        state: state,
        onOpenPicker: () => _showPicker(context),
      ),
    );
  }

  Future<void> _showPicker(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (sheetContext) =>
          BlocBuilder<SpeechModelsCubit, SpeechModelsState>(
            bloc: cubit,
            builder: (_, state) => SpeechModelPickerSheet(
              state: state,
              onActivate: (model) => _activate(sheetContext, model),
            ),
          ),
    );
  }

  Future<void> _activate(BuildContext context, SpeechModel model) async {
    final activated = await cubit.activateModel(model);
    if (activated && context.mounted) {
      Navigator.pop(context);
    }
  }
}

class _Preferences implements TranscriptionPreferences {
  String? selected;
  final savedModels = <String>[];

  @override
  Future<String?> getSelectedModel() async => selected;

  @override
  Future<void> setSelectedModel(String model) async {
    selected = model;
    savedModels.add(model);
  }
}

class _Transcription implements TranscriptionRepository {
  var models = const <SpeechModel>[
    SpeechModel(slug: 'whisper-tiny', isDownloaded: true, sizeMb: 75),
    SpeechModel(slug: 'whisper-small', isDownloaded: false, sizeMb: 200),
  ];
  Exception? downloadFailure;
  final downloadedSlugs = <String>[];

  @override
  Future<List<SpeechModel>> getModels({bool refresh = true}) async => models;

  @override
  Future<void> downloadModel(
    String slug, {
    TranscriptionDownloadProgress? onProgress,
  }) async {
    onProgress?.call(.5, TranscriptionDownloadPhase.downloading);
    if (downloadFailure case final failure?) {
      throw failure;
    }
    downloadedSlugs.add(slug);
  }

  @override
  Future<bool> isModelDownloaded(String slug) async =>
      models.any((model) => model.slug == slug && model.isDownloaded);

  @override
  Future<void> reset() async {}

  @override
  Future<String> transcribeRange({
    required Audiobook book,
    required Duration start,
    required Duration end,
    required String model,
  }) async => '';
}
