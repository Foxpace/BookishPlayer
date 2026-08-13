import 'package:bookish_player/core/presentation/app_message.dart';
import 'package:bookish_player/features/library/models/library_models.dart';
import 'package:bookish_player/features/transcription/repos/transcription_preferences.dart';
import 'package:bookish_player/features/transcription/repos/transcription_repositories.dart';
import 'package:bookish_player/features/transcription/cubits/speech_models_cubit.dart';
import 'package:bookish_player/features/transcription/cubits/transcription_cubits.dart';
import 'package:flutter_test/flutter_test.dart';

import 'transcription_test_builder.dart';

void main() {
  group('Local speech models and preferences', () {
    late _FakeTranscription transcription;
    late _FakePreferences preferences;
    late SpeechModelsCubit sut;

    setUp(() {
      transcription = _FakeTranscription();
      preferences = _FakePreferences();
      sut = SpeechModelsCubit(
        buildSpeechModelUseCases(
          transcription: transcription,
          preferences: preferences,
        ),
      );
    });

    tearDown(() => sut.close());

    test(
      'Given local speech models and preferences, When cached and refreshed models are loaded, Then the selected available model and refreshed catalog are emitted',
      () async {
        // GIVEN
        preferences.selected = 'missing';
        transcription.responses = [
          const [SpeechModel(slug: 'tiny', isDownloaded: false)],
          const [
            SpeechModel(slug: 'tiny', isDownloaded: false),
            SpeechModel(slug: 'small', isDownloaded: true),
          ],
        ];

        await sut.load();
        // WHEN
        await sut.selectModel('small');

        // THEN
        expect(sut.state.status, SpeechModelsStatus.ready);
        expect(sut.state.models, hasLength(2));
        expect(sut.state.selectedModel, 'small');
        expect(sut.state.selectedModelIsDownloaded, isTrue);
        expect(preferences.selected, 'small');
      },
    );

    test(
      'Given local speech models and preferences, When the selected model downloads, Then progress and a typed completion effect are emitted',
      () async {
        // GIVEN
        transcription.responses = [
          const [SpeechModel(slug: 'whisper-tiny', isDownloaded: false)],
          const [SpeechModel(slug: 'whisper-tiny', isDownloaded: false)],
        ];
        await sut.load();

        // WHEN
        await sut.downloadSelectedModel();

        // THEN
        expect(sut.state.status, SpeechModelsStatus.ready);
        expect(sut.state.selectedModelIsDownloaded, isTrue);
        expect(sut.state.message, AppMessage.speechModelDownloaded);
        expect(sut.state.effectRevision, 1);
      },
    );

    test(
      'Given local speech models and preferences, When loading and download operations fail, Then failures stay typed and revisioned',
      () async {
        // GIVEN
        transcription.loadFailure = Exception('catalog');
        // WHEN
        await sut.load();
        // THEN
        expect(sut.state.message, AppMessage.speechModelsLoadFailed);
        expect(sut.state.effectRevision, 1);

        transcription.loadFailure = null;
        transcription.responses = [const [], const []];
        await sut.load();
        transcription.downloadFailure = Exception('download');
        await sut.downloadSelectedModel();
        expect(sut.state.message, AppMessage.speechModelDownloadFailed);
        expect(sut.state.effectRevision, 2);
      },
    );
  });
}

class _FakePreferences implements TranscriptionPreferences {
  String? selected;

  @override
  Future<String?> getSelectedModel() async => selected;

  @override
  Future<void> setSelectedModel(String model) async {
    selected = model;
  }
}

class _FakeTranscription implements TranscriptionRepository {
  List<List<SpeechModel>> responses = const [[], []];
  Exception? loadFailure;
  Exception? downloadFailure;
  var _responseIndex = 0;

  @override
  Future<List<SpeechModel>> getModels({bool refresh = true}) async {
    if (loadFailure case final failure?) {
      throw failure;
    }
    return responses[_responseIndex++];
  }

  @override
  Future<void> downloadModel(
    String slug, {
    TranscriptionDownloadProgress? onProgress,
  }) async {
    onProgress?.call(.5, TranscriptionDownloadPhase.downloading);
    if (downloadFailure case final failure?) {
      throw failure;
    }
  }

  @override
  Future<bool> isModelDownloaded(String slug) async => false;

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
