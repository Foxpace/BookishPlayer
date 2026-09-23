import 'package:bookish_player/core/foundation/result.dart';
import 'package:bookish_player/core/presentation/app_message.dart';
import 'package:bookish_player/features/library/models/library_models.dart';
import 'package:bookish_player/features/transcription/cubits/speech_models_cubit.dart';
import 'package:bookish_player/features/transcription/cubits/transcription_cubits.dart';
import 'package:bookish_player/features/transcription/models/speech_model.dart';
import 'package:bookish_player/features/transcription/models/transcription_download.dart';
import 'package:bookish_player/features/transcription/repos/transcription_preferences.dart';
import 'package:bookish_player/features/transcription/repos/transcription_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_support/features/transcription/transcription_test_builder.dart';

void main() {
  group('Speech model manager', () {
    late _FakeTranscription transcription;
    late _FakePreferences preferences;
    late SpeechModelsCubit sut;

    setUp(() {
      transcription = _FakeTranscription();
      preferences = _FakePreferences();
      sut = SpeechModelsCubit(
        buildSpeechModelApplication(
          transcription: transcription,
          preferences: preferences,
        ),
      );
    });
    tearDown(() => sut.close());

    test('Given a saved missing model, When the catalog loads, Then a downloaded model is shown as active', () async {
      // GIVEN
      preferences.selected = 'missing';
      transcription.models = const [
        SpeechModel(slug: 'tiny', isDownloaded: false),
        SpeechModel(slug: 'small', isDownloaded: true),
      ];

      // WHEN
      await sut.load();

      // THEN
      expect(sut.state.status, SpeechModelsStatus.ready);
      expect(sut.state.selectedModel, 'small');
      expect(sut.state.selectedModelIsDownloaded, isTrue);
      expect(transcription.catalogReads, 1);
    });

    test('Given an active model, When another model downloads, Then it remains active until Use is chosen', () async {
      // GIVEN
      preferences.selected = 'tiny';
      transcription.models = const [
        SpeechModel(slug: 'tiny', isDownloaded: true),
        SpeechModel(slug: 'small', isDownloaded: false),
      ];
      await sut.load();

      // WHEN
      await sut.downloadModel('small');

      // THEN
      expect(transcription.downloadedSlugs, ['small']);
      expect(sut.state.selectedModel, 'tiny');
      expect(sut.state.models.last.isDownloaded, isTrue);
      expect(sut.state.message, AppMessage.speechModelDownloaded);
      expect(sut.state.effectRevision, 1);

      await sut.selectModel('small');
      expect(preferences.selected, 'small');
      expect(sut.state.selectedModel, 'small');
    });

    test('Given the active model, When it is removed, Then another downloaded model becomes active', () async {
      // GIVEN
      preferences.selected = 'small';
      transcription.models = const [
        SpeechModel(slug: 'tiny', isDownloaded: true),
        SpeechModel(slug: 'small', isDownloaded: true),
      ];
      await sut.load();

      // WHEN
      await sut.removeModel('small');

      // THEN
      expect(transcription.removedSlugs, ['small']);
      expect(sut.state.selectedModel, 'tiny');
      expect(preferences.selected, 'tiny');
      expect(sut.state.models.last.isDownloaded, isFalse);
      expect(sut.state.message, AppMessage.speechModelRemoved);
    });

    test('Given the only downloaded model, When it is removed, Then no usable model remains active', () async {
      // GIVEN
      preferences.selected = 'tiny';
      transcription.models = const [
        SpeechModel(slug: 'tiny', isDownloaded: true),
        SpeechModel(slug: 'small', isDownloaded: false),
      ];
      await sut.load();

      // WHEN
      await sut.removeModel('tiny');

      // THEN
      expect(sut.state.selectedModelIsDownloaded, isFalse);
      expect(sut.state.models.first.isDownloaded, isFalse);
    });

    test('Given loading, download, and removal failures, When those actions run, Then each reports a typed failure', () async {
      // GIVEN
      transcription.loadFailure = Exception('catalog');
      await sut.load();
      expect(sut.state.message, AppMessage.speechModelsLoadFailed);

      transcription.loadFailure = null;
      transcription.models = const [
        SpeechModel(slug: 'tiny', isDownloaded: true),
        SpeechModel(slug: 'small', isDownloaded: false),
      ];
      await sut.load();
      transcription.downloadFailure = Exception('offline');

      // WHEN / THEN
      await sut.downloadModel('small');
      expect(sut.state.message, AppMessage.speechModelDownloadFailed);
      expect(sut.state.selectedModel, 'tiny');
      transcription.removeFailure = Exception('storage');
      await sut.removeModel('tiny');
      expect(sut.state.message, AppMessage.speechModelRemoveFailed);
      expect(sut.state.models.first.isDownloaded, isTrue);
      expect(sut.state.effectRevision, 3);
    });
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
  List<SpeechModel> models = const [];
  var catalogReads = 0;
  Exception? loadFailure;
  Exception? downloadFailure;
  Exception? removeFailure;
  final downloadedSlugs = <String>[];
  final removedSlugs = <String>[];

  @override
  Future<List<SpeechModel>> listModels() async {
    if (loadFailure case final failure?) {
      throw failure;
    }
    catalogReads++;
    return models;
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
    downloadedSlugs.add(slug);
    models = [
      for (final model in models)
        model.slug == slug ? model.copyWith(isDownloaded: true) : model,
    ];
  }

  @override
  Future<void> removeModel(String slug) async {
    if (removeFailure case final failure?) {
      throw failure;
    }
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
