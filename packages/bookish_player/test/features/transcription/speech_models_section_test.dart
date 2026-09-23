import 'package:bookish_player/core/foundation/result.dart';
import 'package:bookish_player/core/presentation/app_message.dart';
import 'package:bookish_player/features/library/models/library_models.dart';
import 'package:bookish_player/features/transcription/cubits/speech_models_cubit.dart';
import 'package:bookish_player/features/transcription/cubits/transcription_cubits.dart';
import 'package:bookish_player/features/transcription/models/speech_model.dart';
import 'package:bookish_player/features/transcription/models/transcription_download.dart';
import 'package:bookish_player/features/transcription/repos/transcription_preferences.dart';
import 'package:bookish_player/features/transcription/repos/transcription_repository.dart';
import 'package:bookish_player/features/transcription/ui/speech_models_section.dart';
import 'package:bookish_player/features/transcription/ui/widgets/speech_model_picker_sheet.dart';
import 'package:bookish_player/features/transcription/ui/widgets/speech_model_removal_dialog.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_support/support/pump_bookish_app.dart';
import '../../../test_support/features/transcription/transcription_test_builder.dart';

void main() {
  group('Speech model manager', () {
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
      'Given a missing model, When Download and Use are chosen, Then it becomes active',
      (tester) async {
        // GIVEN
        await tester.pumpBookishApp(
          child: Scaffold(body: _SpeechModelsHarness(cubit: cubit)),
        );
        await tester.tap(find.text('Whisper Tiny'));
      await tester.pumpAndSettle();
      expect(find.text('Manage speech models'), findsOneWidget);
      expect(find.text('200 MB · Available to download'), findsOneWidget);
      expect(find.text('Selected'), findsNothing);

        // WHEN
        await tester.tap(find.text('Download'));
        await tester.pumpAndSettle();

        // THEN
        expect(transcription.downloadedSlugs, ['whisper-small']);
        expect(preferences.selected, 'whisper-tiny');
        expect(find.text('Manage speech models'), findsOneWidget);
        expect(find.text('Use'), findsOneWidget);
        await tester.tap(find.text('Use'));
        await tester.pumpAndSettle();
        expect(preferences.selected, 'whisper-small');
        expect(cubit.state.selectedModelIsDownloaded, isTrue);
        expect(find.text('Manage speech models'), findsNothing);
      },
    );

    testWidgets(
      'Given a failed download, When Download is chosen, Then the manager stays open and reports failure',
      (tester) async {
        // GIVEN
        transcription.downloadFailure = Exception('offline');
        await tester.pumpBookishApp(
          child: Scaffold(body: _SpeechModelsHarness(cubit: cubit)),
        );
        await tester.tap(find.text('Whisper Tiny'));
        await tester.pumpAndSettle();

        // WHEN
        await tester.tap(find.text('Download'));
        await tester.pumpAndSettle();

        // THEN
        expect(find.text('Manage speech models'), findsOneWidget);
        expect(
          find.text('Could not download the speech model.'),
          findsOneWidget,
        );
        expect(preferences.selected, 'whisper-tiny');
      },
    );

    testWidgets(
      'Given a downloaded active model, When Remove is confirmed, Then the remaining downloaded model becomes active',
      (tester) async {
        // GIVEN
        transcription.models = const [
          SpeechModel(slug: 'whisper-tiny', isDownloaded: true, sizeMb: 75),
          SpeechModel(slug: 'whisper-small', isDownloaded: true, sizeMb: 200),
        ];
        await cubit.load();
        await tester.pumpBookishApp(
          child: Scaffold(body: _SpeechModelsHarness(cubit: cubit)),
        );
        await tester.tap(find.text('Whisper Tiny'));
        await tester.pumpAndSettle();

        // WHEN
        await tester.tap(find.byTooltip('Remove from device').first);
        await tester.pumpAndSettle();
        expect(find.text('Remove Whisper Tiny?'), findsOneWidget);
        await tester.tap(find.text('Cancel'));
        await tester.pumpAndSettle();
        expect(transcription.removedSlugs, isEmpty);
        await tester.tap(find.byTooltip('Remove from device').first);
        await tester.pumpAndSettle();
        await tester.tap(find.text('Remove from device').last);
        await tester.pumpAndSettle();

        // THEN
        expect(transcription.removedSlugs, ['whisper-tiny']);
        expect(preferences.selected, 'whisper-small');
        expect(find.text('Manage speech models'), findsOneWidget);
        expect(
          find.text('Speech model removed from this device.'),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'Given a narrow phone, When the manager opens, Then model actions fit in the sheet',
      (tester) async {
        // GIVEN
        tester.view.physicalSize = const Size(320, 640);
        tester.view.devicePixelRatio = 1;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });
        transcription.models = const [
          SpeechModel(slug: 'whisper-base', isDownloaded: true),
          SpeechModel(slug: 'parakeet-tdt-0.6b-v3', isDownloaded: false),
        ];
        await cubit.load();
        await tester.pumpBookishApp(
          child: Scaffold(body: _SpeechModelsHarness(cubit: cubit)),
        );

        // WHEN
        await tester.tap(find.text('Whisper Base'));
        await tester.pumpAndSettle();

        // THEN
        expect(find.text('Manage speech models'), findsOneWidget);
        expect(tester.takeException(), isNull);
      },
    );
  });

  testWidgets(
    'Given an empty catalog, When settings render, Then the manager is disabled',
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
      expect(find.text('Manage speech models'), findsNothing);
    },
  );
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
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message.localize(context))));
        }
      },
      builder: (context, state) => SpeechModelsSection(
        state: state,
        onOpenPicker: () => _showPicker(context),
      ),
    );
  }

  Future<void> _showPicker(BuildContext context) => showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (sheetContext) =>
        BlocBuilder<SpeechModelsCubit, SpeechModelsState>(
          bloc: cubit,
          builder: (_, state) => SpeechModelPickerSheet(
            state: state,
            onSelect: (model) => _select(sheetContext, model),
            onDownload: (model) => cubit.downloadModel(model.slug),
            onRemove: (model) => _remove(sheetContext, model),
          ),
        ),
  );

  Future<void> _select(BuildContext context, SpeechModel model) async {
    final selected = await cubit.selectModel(model.slug);
    if (selected && context.mounted) {
      Navigator.pop(context);
    }
  }

  Future<void> _remove(BuildContext context, SpeechModel model) async {
    if (await confirmSpeechModelRemoval(context, model)) {
      await cubit.removeModel(model.slug);
    }
  }
}

class _Preferences implements TranscriptionPreferences {
  String? selected;

  @override
  Future<String?> getSelectedModel() async => selected;

  @override
  Future<void> setSelectedModel(String model) async => selected = model;
}

class _Transcription implements TranscriptionRepository {
  var models = const <SpeechModel>[
    SpeechModel(slug: 'whisper-tiny', isDownloaded: true, sizeMb: 75),
    SpeechModel(slug: 'whisper-small', isDownloaded: false, sizeMb: 200),
  ];
  Exception? downloadFailure;
  final downloadedSlugs = <String>[];
  final removedSlugs = <String>[];

  @override
  Future<List<SpeechModel>> listModels() async => models;

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
    models = [
      for (final model in models)
        model.slug == slug ? model.copyWith(isDownloaded: true) : model,
    ];
  }

  @override
  Future<void> removeModel(String slug) async {
    removedSlugs.add(slug);
    models = [
      for (final model in models)
        model.slug == slug ? model.copyWith(isDownloaded: false) : model,
    ];
  }

  @override
  Future<bool> isModelDownloaded(String slug) async =>
      models.any((model) => model.slug == slug && model.isDownloaded);

  @override
  Future<Result<String>> transcribeRange({
    required Audiobook book,
    required Duration start,
    required Duration end,
    required String model,
  }) async => const Result.success('');
}
