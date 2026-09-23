import 'dart:io';
import 'dart:isolate';

import 'package:archive/archive_io.dart';
import 'package:path/path.dart' as p;

import '../cactus_models.dart';

const cactusModelRevisions = {
  'whisper-base': '47b87dc9ff4a5e01f002034b2bdd7f5a4895bd8f',
  'parakeet-tdt-0.6b-v2': '6d51da57ffd417d6418f631e453bdc2f4e29ecff',
  'parakeet-tdt-0.6b-v3': '26fa0fdba867416e6df970c517ac95c9bdce7c4b',
};

class CactusModelDownloader {
  CactusModelDownloader({Uri Function(String, String)? archiveUri})
    : _archiveUri = archiveUri ?? _publishedArchiveUri,
      _httpClient = HttpClient()
        ..connectionTimeout = const Duration(seconds: 30);

  final Uri Function(String, String) _archiveUri;
  final HttpClient _httpClient;

  Future<void> download({
    required Directory modelDirectory,
    required String modelSlug,
    CactusDownloadProgress? onProgress,
  }) async {
    Directory? stagingDirectory;
    try {
      final modelRevision = cactusModelRevisions[modelSlug];
      if (modelRevision == null) {
        throw const CactusTranscriptionException('Unsupported speech model.');
      }
      final stagedModel = await modelDirectory.parent.createTemp('.download-');
      stagingDirectory = stagedModel;
      await _downloadArchive(stagedModel, modelSlug, modelRevision, onProgress);
      await Isolate.run(() => unpackArchive(stagedModel.path));
      await File(p.join(stagedModel.path, '.complete'))
          .writeAsString(modelRevision);
      await stagedModel.rename(modelDirectory.path);
      onProgress?.call(1, CactusDownloadPhase.downloading);
    } finally {
      if (stagingDirectory != null && await stagingDirectory.exists()) {
        await stagingDirectory.delete(recursive: true);
      }
    }
  }

  Future<void> _downloadArchive(
    Directory stagingDirectory,
    String modelSlug,
    String modelRevision,
    CactusDownloadProgress? onProgress,
  ) async {
    final archiveUri = _archiveUri(modelSlug, modelRevision);
    final request = await _httpClient.getUrl(archiveUri);
    final response = await request.close().timeout(const Duration(seconds: 60));
    if (response.statusCode != HttpStatus.ok) {
      throw HttpException('Speech model download failed.', uri: archiveUri);
    }

    final archiveFile = File(p.join(stagingDirectory.path, 'model.zip'));
    final archiveSink = archiveFile.openWrite();
    var receivedBytes = 0;
    try {
      await archiveSink.addStream(
        response.timeout(const Duration(seconds: 60)).map((bytes) {
          receivedBytes += bytes.length;
          if (response.contentLength > 0) {
            onProgress?.call(
              receivedBytes / response.contentLength * 0.95,
              CactusDownloadPhase.downloading,
            );
          }
          return bytes;
        }),
      );
    } finally {
      await archiveSink.close();
    }
  }

  static Uri _publishedArchiveUri(String modelSlug, String modelRevision) {
    return Uri.https(
      'huggingface.co',
      '/Cactus-Compute/$modelSlug/resolve/$modelRevision/$modelSlug-cq4.zip',
    );
  }

  void close() => _httpClient.close(force: true);

  static void unpackArchive(String directory) {
    final archiveFile = File(p.join(directory, 'model.zip'));
    final archiveStream = InputFileStream(archiveFile.path);
    try {
      final archive = ZipDecoder().decodeStream(archiveStream, verify: true);
      _requireSafeArchivePaths(archive, directory);
      extractArchiveToDiskSync(archive, directory);
      _moveNestedModelFiles(directory);
      _requireModelFiles(directory);
    } finally {
      archiveStream.closeSync();
    }
    archiveFile.deleteSync();
  }

  static void _requireSafeArchivePaths(Archive archive, String directory) {
    for (final entry in archive) {
      final extractedPath = p.normalize(p.join(directory, entry.name));
      if (!p.isWithin(directory, extractedPath) || entry.isSymbolicLink) {
        throw const CactusTranscriptionException('Invalid model archive path.');
      }
    }
  }

  static void _moveNestedModelFiles(String directory) {
    final modelBundles = Directory(directory)
        .listSync()
        .whereType<Directory>()
        .where((bundle) => File(p.join(bundle.path, 'config.txt')).existsSync())
        .toList();
    if (modelBundles.length != 1) return;

    final modelBundle = modelBundles.single;
    for (final modelFile in modelBundle.listSync()) {
      modelFile.renameSync(p.join(directory, p.basename(modelFile.path)));
    }
    modelBundle.deleteSync();
  }

  static void _requireModelFiles(String directory) {
    if (!File(p.join(directory, 'config.txt')).existsSync() ||
        !File(p.join(directory, 'components', 'manifest.json')).existsSync()) {
      throw const CactusTranscriptionException(
        'Model archive is not a v2 bundle.',
      );
    }
  }
}
