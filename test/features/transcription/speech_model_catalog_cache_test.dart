import 'dart:io';

import 'package:bookish_player/features/transcription/data/speech_model_catalog_cache.dart';
import 'package:bookish_player/features/transcription/domain/transcription_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Directory directory;

  setUp(() {
    directory = Directory.systemTemp.createTempSync('bookish-model-cache-');
  });

  tearDown(() {
    if (directory.existsSync()) {
      directory.deleteSync(recursive: true);
    }
  });

  test('persists the online model catalog for offline reads', () {
    final cache = SpeechModelCatalogCache(directory);
    const models = [
      SpeechModel(slug: 'whisper-tiny', sizeMb: 75, isDownloaded: false),
      SpeechModel(slug: 'whisper-base', sizeMb: 142, isDownloaded: false),
    ];

    cache.write(models);
    final restored = cache.read();

    expect(restored.map((model) => model.slug), [
      'whisper-tiny',
      'whisper-base',
    ]);
    expect(restored.map((model) => model.sizeMb), [75, 142]);
  });

  test('discovers downloaded models from local model directories', () {
    final model = Directory('${directory.path}/models/custom-whisper')
      ..createSync(recursive: true);
    File('${model.path}/weights.bin').writeAsBytesSync([1]);

    final cache = SpeechModelCatalogCache(directory);

    expect(cache.downloadedSlugs(), {'custom-whisper'});
  });

  test('reconciles cached models with authoritative local downloads', () {
    final models = reconcileSpeechModels(
      catalog: const [
        SpeechModel(slug: 'whisper-tiny', sizeMb: 75, isDownloaded: false),
        SpeechModel(slug: 'whisper-base', sizeMb: 142, isDownloaded: true),
      ],
      downloadedSlugs: {'whisper-tiny', 'offline-only-model'},
    );

    expect(models.map((model) => model.slug), [
      'whisper-tiny',
      'whisper-base',
      'offline-only-model',
    ]);
    expect(models.map((model) => model.isDownloaded), [true, false, true]);
  });

  test('ignores a corrupt cached response', () {
    File(
      '${directory.path}/bookish_speech_models.json',
    ).writeAsStringSync('{not-json');

    expect(SpeechModelCatalogCache(directory).read(), isEmpty);
  });
}
