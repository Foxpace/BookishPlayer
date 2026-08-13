import 'dart:io';

import 'package:bookish_cactus_transcription/src/cactus_models.dart';
import 'package:bookish_cactus_transcription/src/speech_model_catalog_cache.dart';
import 'package:test/test.dart';

void main() {
  group('Speech model catalog cache', () {
    late Directory directory;
    late SpeechModelCatalogCache sut;

    setUp(() {
      directory = Directory.systemTemp.createTempSync('bookish-model-cache-');
      sut = SpeechModelCatalogCache(directory);
    });

    tearDown(() {
      if (directory.existsSync()) {
        directory.deleteSync(recursive: true);
      }
    });

    test(
      'Given the speech model catalog cache, When its behavior is exercised, Then persists the online model catalog for offline reads',
      () {
        // GIVEN
        const models = [
          CactusSpeechModel(
            slug: 'whisper-tiny',
            sizeMb: 75,
            isDownloaded: false,
          ),
          CactusSpeechModel(
            slug: 'whisper-base',
            sizeMb: 142,
            isDownloaded: false,
          ),
        ];

        sut.write(models);
        // WHEN
        final restored = sut.read();

        // THEN
        expect(restored.map((model) => model.slug), [
          'whisper-tiny',
          'whisper-base',
        ]);
        expect(restored.map((model) => model.sizeMb), [75, 142]);
      },
    );

    test(
      'Given the speech model catalog cache, When its behavior is exercised, Then discovers downloaded models from local model directories',
      () {
        // GIVEN
        final model = Directory('${directory.path}/models/custom-whisper')
          ..createSync(recursive: true);
        File('${model.path}/weights.bin').writeAsBytesSync([1]);

        // WHEN
        final downloaded = sut.downloadedSlugs();

        // THEN
        expect(downloaded, {'custom-whisper'});
      },
    );

    test(
      'Given the speech model catalog cache, When its behavior is exercised, Then reconciles cached models with authoritative local downloads',
      () {
        // WHEN
        final models = reconcileSpeechModels(
          catalog: const [
            CactusSpeechModel(
              slug: 'whisper-tiny',
              sizeMb: 75,
              isDownloaded: false,
            ),
            CactusSpeechModel(
              slug: 'whisper-base',
              sizeMb: 142,
              isDownloaded: true,
            ),
          ],
          downloadedSlugs: {'whisper-tiny', 'offline-only-model'},
        );

        // THEN
        expect(models.map((model) => model.slug), [
          'whisper-tiny',
          'whisper-base',
          'offline-only-model',
        ]);
        expect(models.map((model) => model.isDownloaded), [true, false, true]);
      },
    );

    test(
      'Given the speech model catalog cache, When its behavior is exercised, Then ignores a corrupt cached response',
      () {
        // GIVEN
        File(
          '${directory.path}/bookish_speech_models.json',
        ).writeAsStringSync('{not-json');

        // WHEN
        final restored = sut.read();

        // THEN
        expect(restored, isEmpty);
      },
    );
  });
}
