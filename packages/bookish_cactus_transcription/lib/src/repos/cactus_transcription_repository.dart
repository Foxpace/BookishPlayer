import 'dart:io';

import 'package:cactus/cactus.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../cactus_models.dart';
import '../cactus_pcm_stream_factory.dart';
import '../speech_model_catalog_cache.dart';

class CactusTranscriptionRepository {
  CactusTranscriptionRepository(this._audio) {
    CactusConfig.isTelemetryEnabled = false;
  }

  final CactusPcmStreamFactory _audio;
  final _stt = CactusSTT();
  String? _initializedModel;

  Future<void> reset() async {
    if (_stt.isLoaded()) {
      _stt.unload();
    }
    _initializedModel = null;
  }

  Future<List<CactusSpeechModel>> getModels({bool refresh = true}) async {
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
        CactusSpeechModel(slug: 'whisper-tiny', isDownloaded: false),
        CactusSpeechModel(slug: 'whisper-base', isDownloaded: false),
      ];
    }

    return reconcileSpeechModels(
      catalog: catalog,
      downloadedSlugs: cache.downloadedSlugs(),
    );
  }

  Future<List<CactusSpeechModel>> _refreshCatalog(
    SpeechModelCatalogCache cache,
    List<CactusSpeechModel> current,
  ) async {
    final remote = await _stt.getVoiceModels();
    if (remote.isEmpty) {
      return current;
    }

    final refreshed = [
      for (final model in remote)
        CactusSpeechModel(
          slug: model.slug,
          sizeMb: model.sizeMb,
          isDownloaded: false,
        ),
    ];

    cache.write(refreshed);
    return refreshed;
  }

  Future<bool> isModelDownloaded(String slug) async {
    final documents = await getApplicationDocumentsDirectory();
    final directory = Directory(p.join(documents.path, 'models', slug));
    if (!directory.existsSync()) {
      return false;
    }

    return directory.listSync().isNotEmpty;
  }

  Future<void> downloadModel(
    String slug, {
    CactusDownloadProgress? onProgress,
  }) async {
    await _stt.downloadModel(
      model: slug,
      downloadProcessCallback: (progress, _, isError) => onProgress?.call(
        progress,
        isError ? CactusDownloadPhase.failure : CactusDownloadPhase.downloading,
      ),
    );
  }

  Future<String> transcribeRange({
    required CactusAudioSource source,
    required Duration start,
    required Duration end,
    required String model,
  }) async {
    if (end <= start) {
      throw const CactusTranscriptionException(
        'Choose an audio range longer than zero.',
      );
    }
    if (!await isModelDownloaded(model)) {
      throw const CactusTranscriptionException(
        'Download a speech model in Settings before transcribing.',
      );
    }

    if (_initializedModel != model || !_stt.isLoaded()) {
      _stt.unload();
      await _stt.initializeModel(params: CactusInitParams(model: model));
      _initializedModel = model;
    }

    final result = await _stt.transcribe(
      audioStream: _audio.createStream(source, start, end),
    );
    if (!result.success) {
      throw CactusTranscriptionException(
        result.errorMessage ?? 'Cactus could not transcribe this audio.',
      );
    }

    return result.text.trim();
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
