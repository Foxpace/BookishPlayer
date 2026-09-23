import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:bookish_cactus_transcription/src/cactus_models.dart';
import 'package:bookish_cactus_transcription/src/repos/cactus_model_download.dart';
import 'package:test/test.dart';

void main() {
  late Directory directory;
  setUp(
    () => directory = Directory.systemTemp.createTempSync('cactus-archive-'),
  );
  tearDown(() => directory.deleteSync(recursive: true));

  void archive(List<ArchiveFile> files) {
    final content = Archive();
    files.forEach(content.add);
    File('${directory.path}/model.zip')
        .writeAsBytesSync(ZipEncoder().encode(content));
  }

  test('Given a valid model archive, When extracting, Then finishes writing weights before returning', () {
    // GIVEN
    archive([
      ArchiveFile.string('whisper-base-cq4/config.txt', 'model_type=whisper'),
      ArchiveFile.string('whisper-base-cq4/components/manifest.json', '{}'),
      ArchiveFile('whisper-base-cq4/weights.bin', 3, [1, 2, 3]),
    ]);
    // WHEN
    CactusModelDownloader.unpackArchive(directory.path);
    // THEN
    expect(File('${directory.path}/weights.bin').readAsBytesSync(), [1, 2, 3]);
    expect(File('${directory.path}/model.zip').existsSync(), isFalse);
  });

  test(
    'Given a traversal entry, When extracting, Then rejects the archive',
    () {
      // GIVEN
      archive([ArchiveFile.string('../escape', 'bad')]);
      // WHEN / THEN
      expect(
        () => CactusModelDownloader.unpackArchive(directory.path),
        throwsA(isA<CactusTranscriptionException>()),
      );
    },
  );

  test('Given an archive without model configuration, When extracting, Then rejects it', () {
    // GIVEN
    archive([ArchiveFile.string('readme.txt', 'not a model')]);
    // WHEN / THEN
    expect(
      () => CactusModelDownloader.unpackArchive(directory.path),
      throwsA(isA<CactusTranscriptionException>()),
    );
  });

  test(
    'Given two models, When downloading both, Then reuses the downloader',
    () async {
      // GIVEN
      final modelArchive = Archive()
        ..addFile(
          ArchiveFile.string('bundle/config.txt', 'model_type=parakeet_tdt'),
        )
        ..addFile(ArchiveFile.string('bundle/components/manifest.json', '{}'));
      final archiveBytes = ZipEncoder().encode(modelArchive);
      final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      var requests = 0;
      final responses = server.listen((request) async {
        requests++;
        request.response.add(archiveBytes);
        await request.response.close();
      });
      final downloader = CactusModelDownloader(
        archiveUri: (slug, revision) =>
            Uri.parse('http://127.0.0.1:${server.port}/$slug/$revision'),
      );
      try {
        // WHEN
        for (final slug in ['parakeet-tdt-0.6b-v2', 'parakeet-tdt-0.6b-v3']) {
          await downloader.download(
            modelDirectory: Directory('${directory.path}/$slug'),
            modelSlug: slug,
          );
        }
        // THEN
        expect(requests, 2);
        for (final slug in ['parakeet-tdt-0.6b-v2', 'parakeet-tdt-0.6b-v3']) {
          expect(
            File('${directory.path}/$slug/config.txt').existsSync(),
            isTrue,
          );
          expect(
            File('${directory.path}/$slug/.complete').readAsStringSync(),
            cactusModelRevisions[slug],
          );
        }
      } finally {
        downloader.close();
        await responses.cancel();
        await server.close(force: true);
      }
    },
  );
}
