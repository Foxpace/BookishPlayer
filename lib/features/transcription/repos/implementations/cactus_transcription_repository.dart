import 'dart:io';

import 'package:cactus/cactus.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../../library/models/library_models.dart';
import '../transcription_repositories.dart';
import 'cactus_audio_clip_factory.dart';
import 'speech_model_catalog_cache.dart';
import 'transcription_chunking.dart';

@LazySingleton(as: TranscriptionRepository)
class CactusTranscriptionRepository implements TranscriptionRepository {
  CactusTranscriptionRepository(this._clips) {
    CactusConfig.isTelemetryEnabled = false;
  }

  final CactusAudioClipFactory _clips;
  final _stt = CactusSTT();
  String? _initializedModel;

  @override
  Future<void> reset() async {
    if (_stt.isLoaded()) {
      _stt.unload();
    }
    _initializedModel = null;
  }

  @override
  Future<List<SpeechModel>> getModels({bool refresh = true}) async {
    final documents = await getApplicationDocumentsDirectory();
    final cache = SpeechModelCatalogCache(documents);
    var catalog = cache.read();

    if (refresh && await _hasInternetConnection()) {
      try {
        catalog = await _refreshCatalog(cache, catalog);
      } catch (_) {
        // The persisted catalog and local model directories remain authoritative.
      }
    }

    if (catalog.isEmpty) {
      catalog = const [
        SpeechModel(slug: 'whisper-tiny', isDownloaded: false),
        SpeechModel(slug: 'whisper-base', isDownloaded: false),
      ];
    }

    return reconcileSpeechModels(
      catalog: catalog,
      downloadedSlugs: cache.downloadedSlugs(),
    );
  }

  Future<List<SpeechModel>> _refreshCatalog(
    SpeechModelCatalogCache cache,
    List<SpeechModel> current,
  ) async {
    final remote = await _stt.getVoiceModels();
    if (remote.isEmpty) {
      return current;
    }

    final refreshed = [
      for (final model in remote)
        SpeechModel(
          slug: model.slug,
          sizeMb: model.sizeMb,
          isDownloaded: false,
        ),
    ];

    cache.write(refreshed);
    return refreshed;
  }

  @override
  Future<bool> isModelDownloaded(String slug) async {
    final documents = await getApplicationDocumentsDirectory();
    final directory = Directory(p.join(documents.path, 'models', slug));
    if (!directory.existsSync()) {
      return false;
    }

    return directory.listSync().isNotEmpty;
  }

  @override
  Future<void> downloadModel(
    String slug, {
    TranscriptionDownloadProgress? onProgress,
  }) async {
    await _stt.downloadModel(
      model: slug,
      downloadProcessCallback: (progress, _, isError) => onProgress?.call(
        progress,
        isError
            ? TranscriptionDownloadPhase.failure
            : TranscriptionDownloadPhase.downloading,
      ),
    );
  }

  @override
  Future<String> transcribeRange({
    required Audiobook book,
    required Duration start,
    required Duration end,
    required String model,
  }) async {
    if (end <= start) {
      throw const TranscriptionException(
        'Choose an audio range longer than zero.',
      );
    }
    if (!await isModelDownloaded(model)) {
      throw const TranscriptionException(
        'Download a speech model in Settings before transcribing.',
      );
    }

    if (_initializedModel != model || !_stt.isLoaded()) {
      _stt.unload();
      await _stt.initializeModel(params: CactusInitParams(model: model));
      _initializedModel = model;
    }

    final clips = await _clips.createClips(book, start, end);
    if (clips.isEmpty) {
      throw const TranscriptionException(
        'The selected range contains no audio.',
      );
    }

    try {
      return await _transcribeClips(clips);
    } finally {
      for (final clip in clips) {
        if (clip.existsSync()) {
          clip.deleteSync();
        }
      }
    }
  }

  Future<String> _transcribeClips(List<File> clips) async {
    final parts = <String>[];
    for (final clip in clips) {
      _stt.reset();
      final result = await _stt.transcribe(audioFilePath: clip.path);

      if (!result.success) {
        throw TranscriptionException(
          result.errorMessage ?? 'Cactus could not transcribe this audio.',
        );
      }

      final text = result.text.trim();
      if (text.isNotEmpty) {
        parts.add(text);
      }
    }

    return mergeTranscriptionParts(parts);
  }

  Future<bool> _hasInternetConnection() async {
    try {
      return await _lookupModelHost();
    } catch (_) {
      return false;
    }
  }

  Future<bool> _lookupModelHost() async {
    final addresses = await InternetAddress.lookup(
      'vlqqczxwyaodtcdmdmlw.supabase.co',
    ).timeout(const Duration(seconds: 2));
    return addresses.any((address) => address.rawAddress.isNotEmpty);
  }
}
