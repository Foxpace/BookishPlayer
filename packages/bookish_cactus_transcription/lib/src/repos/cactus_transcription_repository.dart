import 'dart:developer' as developer;
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../cactus_models.dart';
import '../cactus_pcm_stream_factory.dart';
import 'cactus_inference.dart';
import 'cactus_model_download.dart';

class CactusTranscriptionRepository {
  CactusTranscriptionRepository(
    this._pcmStreamFactory, {
    Future<Directory> Function()? documents,
    CactusInference inference = transcribeCactusAudio,
  }) : _documentsDirectory = documents ?? getApplicationDocumentsDirectory,
       _transcribePcm = inference,
       _modelDownloader = CactusModelDownloader();

  final CactusPcmStreamFactory _pcmStreamFactory;
  final Future<Directory> Function() _documentsDirectory;
  final CactusInference _transcribePcm;
  final CactusModelDownloader _modelDownloader;
  final _activeModelDownloads = <String, Future<void>>{};
  final _activeModelRemovals = <String, Future<void>>{};
  Future<void> _transcriptionQueue = Future.value();

  Future<Directory> _modelsDirectory() async {
    final documentsDirectory = await _documentsDirectory();
    return Directory(p.join(documentsDirectory.path, 'cactus-v2.0.1', 'models'))
        .create(recursive: true);
  }

  Future<List<CactusSpeechModel>> listModels() async => [
    for (final slug in cactusModelRevisions.keys)
      CactusSpeechModel(
        slug: slug,
        isDownloaded: await isModelDownloaded(slug),
      ),
  ];

  Future<bool> isModelDownloaded(String slug) async {
    if (!cactusModelRevisions.containsKey(slug)) return false;
    final modelDirectory = p.join((await _modelsDirectory()).path, slug);
    final completionMarker = File(p.join(modelDirectory, '.complete'));
    return await completionMarker.exists() &&
        await completionMarker.readAsString() == cactusModelRevisions[slug] &&
        await File(p.join(modelDirectory, 'config.txt')).exists() &&
        await File(p.join(modelDirectory, 'components', 'manifest.json'))
            .exists();
  }

  Future<void> downloadModel(
    String slug, {
    CactusDownloadProgress? onProgress,
  }) async {
    final removal = _activeModelRemovals[slug];
    if (removal != null) {
      await removal;
    }
    await _activeModelDownloads.putIfAbsent(
      slug,
      () => _downloadModel(slug, onProgress),
    );
  }

  Future<void> _downloadModel(
    String slug,
    CactusDownloadProgress? onProgress,
  ) async {
    try {
      await _downloadModelIfMissing(slug, onProgress);
    } catch (_) {
      onProgress?.call(0, CactusDownloadPhase.failure);
      rethrow;
    } finally {
      _activeModelDownloads.remove(slug);
    }
  }

  Future<void> _downloadModelIfMissing(
    String slug,
    CactusDownloadProgress? progress,
  ) async {
    if (!cactusModelRevisions.containsKey(slug)) {
      throw const CactusTranscriptionException('Unsupported speech model.');
    }
    if (await isModelDownloaded(slug)) {
      progress?.call(1, CactusDownloadPhase.downloading);
      return;
    }
    final modelDirectory = Directory(
      p.join((await _modelsDirectory()).path, slug),
    );
    if (await modelDirectory.exists()) {
      await modelDirectory.delete(recursive: true);
    }
    await _modelDownloader.download(
      modelDirectory: modelDirectory,
      modelSlug: slug,
      onProgress: progress,
    );
  }

  Future<void> removeModel(String slug) {
    if (!cactusModelRevisions.containsKey(slug)) {
      return Future.error(
        const CactusTranscriptionException('Unsupported speech model.'),
      );
    }
    final pendingTranscriptions = _transcriptionQueue;
    return _activeModelRemovals.putIfAbsent(
      slug,
      () => _removeModel(slug, pendingTranscriptions),
    );
  }

  Future<void> _removeModel(
    String slug,
    Future<void> pendingTranscriptions,
  ) async {
    try {
      final download = _activeModelDownloads[slug];
      if (download != null) {
        try {
          await download;
        } catch (_) {
          // A failed download may leave a partial directory to remove.
        }
      }
      await pendingTranscriptions;
      final modelDirectory = Directory(
        p.join((await _modelsDirectory()).path, slug),
      );
      if (await modelDirectory.exists()) {
        await modelDirectory.delete(recursive: true);
      }
    } finally {
      _activeModelRemovals.remove(slug);
    }
  }

  Future<CactusTranscriptionOutcome> transcribeRange({
    required CactusAudioSource source,
    required Duration start,
    required Duration end,
    required String model,
  }) {
    final removal = _activeModelRemovals[model];
    final transcription = _transcriptionQueue.then(
      (_) => _transcribeQueuedRange(source, start, end, model, removal),
    );
    _transcriptionQueue = transcription.then<void>((_) {});
    return transcription;
  }

  Future<CactusTranscriptionOutcome> _transcribeQueuedRange(
    CactusAudioSource source,
    Duration start,
    Duration end,
    String model,
    Future<void>? pendingRemoval,
  ) async {
    if (end <= start) {
      developer.log(
        'Rejected transcription range: model=$model, '
        'startMs=${start.inMilliseconds}, endMs=${end.inMilliseconds}',
        name: 'bookish.cactus',
      );
      return const CactusTranscriptionOutcome.failure(
        'Choose an audio range longer than zero.',
      );
    }
    developer.log(
      'Starting transcription: model=$model, '
      'startMs=${start.inMilliseconds}, endMs=${end.inMilliseconds}',
      name: 'bookish.cactus',
    );
    try {
      if (pendingRemoval != null) {
        await pendingRemoval;
      }
      final outcome = await _transcribeWithDownloadedModel(
        source,
        start,
        end,
        model,
      );
      if (outcome case CactusTranscriptionFailed(:final message)) {
        developer.log(
          'Transcription failed: model=$model, reason=${_logDetail(message)}',
          name: 'bookish.cactus',
        );
      } else {
        developer.log(
          'Transcription completed: model=$model',
          name: 'bookish.cactus',
        );
      }
      return outcome;
    } catch (error, stackTrace) {
      developer.log(
        'Transcription threw an error: model=$model',
        name: 'bookish.cactus',
        error: error,
        stackTrace: stackTrace,
      );
      return CactusTranscriptionOutcome.failure('$error');
    }
  }

  Future<CactusTranscriptionOutcome> _transcribeWithDownloadedModel(
    CactusAudioSource source,
    Duration start,
    Duration end,
    String model,
  ) async {
    if (!await isModelDownloaded(model)) {
      return const CactusTranscriptionOutcome.failure(
        'Download a speech model in Settings before transcribing.',
      );
    }
    final temporaryDirectory = await Directory.systemTemp.createTemp(
      'bookish-speech-',
    );
    try {
      return await _writePcmAndTranscribe(
        source,
        start,
        end,
        model,
        temporaryDirectory,
      );
    } finally {
      await temporaryDirectory.delete(recursive: true);
    }
  }

  Future<CactusTranscriptionOutcome> _writePcmAndTranscribe(
    CactusAudioSource source,
    Duration start,
    Duration end,
    String model,
    Directory temporaryDirectory,
  ) async {
    final pcmFile = File(p.join(temporaryDirectory.path, 'audio.pcm'));
    final pcmFileSink = pcmFile.openWrite();
    try {
      await pcmFileSink.addStream(
        _pcmStreamFactory.createStream(source, start, end),
      );
    } catch (error, stackTrace) {
      developer.log(
        'Audio decoding failed: model=$model',
        name: 'bookish.cactus',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    } finally {
      await pcmFileSink.close();
    }
    final modelDirectory = p.join((await _modelsDirectory()).path, model);
    try {
      return await _transcribePcm(modelDirectory, pcmFile.path);
    } catch (error, stackTrace) {
      developer.log(
        'Cactus inference failed: model=$model',
        name: 'bookish.cactus',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  String _logDetail(String detail) {
    final withoutPaths = detail.replaceAll(
      RegExp(r'(?:/[\w .-]+){2,}|(?:[A-Za-z]:\\[^\s]+)'),
      '<redacted-path>',
    );
    return withoutPaths.length <= 500
        ? withoutPaths
        : '${withoutPaths.substring(0, 500)}…';
  }
}
