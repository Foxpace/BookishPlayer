import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;

import '../domain/transcription_repository.dart';

class SpeechModelCatalogCache {
  const SpeechModelCatalogCache(this.documentsDirectory);

  final Directory documentsDirectory;

  File get _catalogFile =>
      File(p.join(documentsDirectory.path, 'bookish_speech_models.json'));

  Directory get _modelsDirectory =>
      Directory(p.join(documentsDirectory.path, 'models'));

  List<SpeechModel> read() {
    try {
      if (!_catalogFile.existsSync()) {
        return const [];
      }
      final decoded = jsonDecode(_catalogFile.readAsStringSync());
      if (decoded is! List) {
        return const [];
      }
      return [
        for (final item in decoded)
          if (item is Map)
            SpeechModel(
              slug: item['slug'] as String,
              sizeMb: (item['sizeMb'] as num?)?.toInt(),
              isDownloaded: false,
            ),
      ];
    } catch (_) {
      return const [];
    }
  }

  void write(List<SpeechModel> models) {
    if (!documentsDirectory.existsSync()) {
      documentsDirectory.createSync(recursive: true);
    }
    _catalogFile.writeAsStringSync(
      jsonEncode([
        for (final model in models)
          {'slug': model.slug, 'sizeMb': model.sizeMb},
      ]),
      flush: true,
    );
  }

  Set<String> downloadedSlugs() {
    if (!_modelsDirectory.existsSync()) {
      return const {};
    }
    return {
      for (final entity in _modelsDirectory.listSync())
        if (entity is Directory && entity.listSync().isNotEmpty)
          p.basename(entity.path),
    };
  }
}

List<SpeechModel> reconcileSpeechModels({
  required List<SpeechModel> catalog,
  required Set<String> downloadedSlugs,
}) {
  final models = <SpeechModel>[];
  final seen = <String>{};
  for (final model in catalog) {
    if (seen.add(model.slug)) {
      models.add(
        model.copyWith(isDownloaded: downloadedSlugs.contains(model.slug)),
      );
    }
  }
  final localOnly =
      downloadedSlugs.where((slug) => !seen.contains(slug)).toList()..sort();
  models.addAll(
    localOnly.map((slug) => SpeechModel(slug: slug, isDownloaded: true)),
  );
  return models;
}
