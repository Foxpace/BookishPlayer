import 'dart:io';

import 'package:cactus/cactus.dart';
import 'package:ffmpeg_kit_flutter_new_audio/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new_audio/return_code.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../library/domain/audiobook.dart';
import '../domain/transcription_repository.dart';
import 'speech_model_catalog_cache.dart';
import 'transcription_chunking.dart';

@LazySingleton(as: TranscriptionRepository)
class CactusTranscriptionRepository implements TranscriptionRepository {
  CactusTranscriptionRepository() {
    CactusConfig.isTelemetryEnabled = false;
  }

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
        final remote = await _stt.getVoiceModels();
        if (remote.isNotEmpty) {
          catalog = [
            for (final model in remote)
              SpeechModel(
                slug: model.slug,
                sizeMb: model.sizeMb,
                isDownloaded: false,
              ),
          ];
          cache.write(catalog);
        }
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
    await _stt.downloadModel(model: slug, downloadProcessCallback: onProgress);
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

    final clips = await _createClips(book, start, end);
    if (clips.isEmpty) {
      throw const TranscriptionException(
        'The selected range contains no audio.',
      );
    }

    try {
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
    } finally {
      for (final clip in clips) {
        if (clip.existsSync()) {
          clip.deleteSync();
        }
      }
    }
  }

  Future<List<File>> _createClips(
    Audiobook book,
    Duration start,
    Duration end,
  ) async {
    final directory = await getTemporaryDirectory();
    final clips = <File>[];
    var trackOffset = Duration.zero;
    final tracks = book.playableTracks;
    var clipIndex = 0;

    try {
      for (var index = 0; index < tracks.length; index++) {
        final track = tracks[index];
        final trackDuration = Duration(milliseconds: track.durationMs);
        final trackEnd = trackOffset + trackDuration;
        final clipStart = start > trackOffset ? start : trackOffset;
        final clipEnd = end < trackEnd ? end : trackEnd;
        if (clipEnd > clipStart) {
          final chunks = planTranscriptionChunks(
            start: clipStart,
            end: clipEnd,
          );
          for (final chunk in chunks) {
            final localStart = chunk.start - trackOffset;
            final localDuration = chunk.end - chunk.start;
            final output = File(
              p.join(
                directory.path,
                'bookish_quote_${DateTime.now().microsecondsSinceEpoch}_${index}_${clipIndex++}.wav',
              ),
            );
            final session = await FFmpegKit.executeWithArguments([
              '-y',
              '-i',
              track.filePath,
              '-ss',
              _seconds(localStart),
              '-t',
              _seconds(localDuration),
              '-vn',
              '-ac',
              '1',
              '-ar',
              '16000',
              '-c:a',
              'pcm_s16le',
              output.path,
            ]);
            final returnCode = await session.getReturnCode();
            if (!ReturnCode.isSuccess(returnCode)) {
              final outputText = await session.getOutput();
              throw TranscriptionException(
                'Could not prepare the selected audio. ${outputText ?? ''}'
                    .trim(),
              );
            }
            clips.add(output);
          }
        }
        trackOffset = trackEnd;
        if (trackOffset >= end) {
          break;
        }
      }
      return clips;
    } catch (_) {
      for (final clip in clips) {
        if (clip.existsSync()) {
          clip.deleteSync();
        }
      }
      rethrow;
    }
  }

  String _seconds(Duration value) =>
      (value.inMicroseconds / Duration.microsecondsPerSecond).toStringAsFixed(
        3,
      );

  Future<bool> _hasInternetConnection() async {
    try {
      final addresses = await InternetAddress.lookup(
        'vlqqczxwyaodtcdmdmlw.supabase.co',
      ).timeout(const Duration(seconds: 2));
      return addresses.any((address) => address.rawAddress.isNotEmpty);
    } catch (_) {
      return false;
    }
  }
}
