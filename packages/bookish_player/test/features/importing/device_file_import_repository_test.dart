import 'dart:io';

import 'package:bookish_player/core/platform/file_picker_gateway.dart';
import 'package:bookish_player/features/importing/repos/implementations/device_file_import_repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_support/support/fakes/fake_id_generator.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Background file-copy worker', () {
    test(
      'Given the background file-copy worker, When a large audiobook is copied, Then bytes and monotonic progress arrive without a partial file',
      () async {
        // GIVEN
        final temporary = await Directory.systemTemp.createTemp(
          'bookish_background_copy_test_',
        );
        final source = File('${temporary.path}/source.m4b');
        final destination = '${temporary.path}/destination.m4b';
        const chunk = 1024 * 1024;
        const chunkCount = 20;
        final bytes = List<int>.generate(chunk, (index) => index % 251);
        final output = source.openWrite();
        for (var index = 0; index < chunkCount; index++) {
          output.add(bytes);
        }
        await output.close();
        // WHEN
        final progress = <(int, int)>[];

        // THEN
        try {
          await copyFileInBackground(
            source.path,
            destination,
            onProgress: (copied, total) => progress.add((copied, total)),
          );

          final copied = File(destination);
          expect(await copied.length(), chunk * chunkCount);
          expect(progress.first, (0, chunk * chunkCount));
          expect(progress.last, (chunk * chunkCount, chunk * chunkCount));
          expect(File('$destination.part').existsSync(), isFalse);
          expect(
            await copied
                .openRead(0, chunk)
                .fold<List<int>>(
                  <int>[],
                  (result, value) => result..addAll(value),
                ),
            bytes,
          );
        } finally {
          await temporary.delete(recursive: true);
        }
      },
    );
  });

  group('Isolated document and application-support directories', () {
    late Directory temporary;
    late Directory documents;
    late Directory support;
    late _FilePicker picker;
    late DeviceFileImportRepository sut;
    const pathProvider = OptionalMethodChannel(
      'plugins.flutter.io/path_provider',
    );

    setUp(() async {
      temporary = await Directory.systemTemp.createTemp(
        'bookish_device_files_',
      );
      documents = await Directory('${temporary.path}/documents').create();
      support = await Directory('${temporary.path}/support').create();
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(pathProvider, (call) async {
            return switch (call.method) {
              'getApplicationDocumentsDirectory' => documents.path,
              'getApplicationSupportDirectory' => support.path,
              _ => null,
            };
          });
      picker = _FilePicker();
      sut = DeviceFileImportRepository(FakeIdGenerator('audio'), picker);
    });

    tearDown(() async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(pathProvider, null);
      await temporary.delete(recursive: true);
    });

    test(
      'Given isolated document and application-support directories, When the platform picker returns readable files or is cancelled, Then selections retain provider metadata and cancellation is empty',
      () async {
        // GIVEN
        final first = File('${temporary.path}/first.m4b')
          ..writeAsStringSync('one');
        final second = File('${temporary.path}/second.mp3')
          ..writeAsStringSync('two');
        picker.result = FilePickerResult([
          PlatformFile(name: 'first.m4b', size: 3, path: first.path),
          PlatformFile(name: 'second.mp3', size: 3, path: second.path),
        ]);

        // WHEN
        final selected = await sut.pickAudioFiles();

        // THEN
        expect(selected.map((file) => file.displayName), [
          'first.m4b',
          'second.mp3',
        ]);
        expect(selected.map((file) => file.sizeBytes), [3, 3]);
        expect(picker.allowedExtensions, containsAll(['m4b', 'opus']));
        expect(picker.allowMultiple, isTrue);

        picker.result = null;
        expect(await sut.pickAudioFiles(), isEmpty);
      },
    );

    test(
      'Given isolated document and application-support directories, When the platform picker returns readable files or is cancelled, Then inaccessible provider entries fail with their names',
      () async {
        // WHEN
        picker.result = FilePickerResult([
          PlatformFile(name: 'cloud-only.m4b', size: 100),
        ]);

        // THEN
        expect(
          sut.pickAudioFiles(),
          throwsA(
            isA<FileSystemException>().having(
              (error) => error.message,
              'message',
              contains('cloud-only.m4b'),
            ),
          ),
        );
      },
    );

    test(
      'Given isolated document and application-support directories, When transferred files are discovered, imported, and removed, Then only supported audio is copied to a generated durable path',
      () async {
        // GIVEN
        final nested = await Directory('${documents.path}/nested').create();
        final alpha = File('${nested.path}/alpha.MP3')
          ..writeAsStringSync('alpha');
        final beta = File('${documents.path}/beta.m4b')
          ..writeAsStringSync('beta');
        File('${documents.path}/ignore.txt').writeAsStringSync('ignore');

        // WHEN
        final transferred = await sut.findTransferredAudioFiles();
        // THEN
        expect(transferred.map((file) => file.displayName), [
          'beta.m4b',
          'alpha.MP3',
        ]);

        final progress = <(int, int)>[];
        final imported = await sut.importFile(
          transferred.first,
          onProgress: (copied, total) => progress.add((copied, total)),
        );
        expect(imported.displayName, 'beta.m4b');
        expect(imported.path, '${support.path}/audiobooks/audio-0.m4b');
        expect(File(imported.path).readAsStringSync(), 'beta');
        expect(progress.last, (4, 4));

        await sut.removeTransferredAudioFiles(transferred);
        expect(alpha.existsSync(), isFalse);
        expect(beta.existsSync(), isFalse);
        await sut.deleteImportedFile(imported.path);
        await sut.deleteImportedFile('${support.path}/missing.m4b');
        expect(File(imported.path).existsSync(), isFalse);
      },
    );

    test(
      'Given isolated document and application-support directories, When cover selection succeeds or is cancelled, Then artwork is copied by book identity without retaining provider paths',
      () async {
        // GIVEN
        final cover = File('${temporary.path}/cover.JPG')
          ..writeAsStringSync('cover');
        picker.result = FilePickerResult([
          PlatformFile(name: 'cover.JPG', size: 5, path: cover.path),
        ]);

        // WHEN
        final imported = await sut.pickAndImportCover('book-1');
        // THEN
        expect(imported, '${support.path}/covers/book-1.jpg');
        if (imported == null) {
          fail('The selected cover must be imported.');
        }
        expect(File(imported).readAsStringSync(), 'cover');

        picker.result = null;
        expect(await sut.pickAndImportCover('book-2'), isNull);
        await sut.clearTemporaryFiles();
        expect(picker.clearCalls, 0);
      },
    );
  });
}

class _FilePicker implements FilePickerGateway {
  FilePickerResult? result;
  List<String>? allowedExtensions;
  bool? allowMultiple;
  var clearCalls = 0;

  @override
  Future<FilePickerResult?> pickAudioFiles(List<String> extensions) async {
    allowedExtensions = extensions;
    allowMultiple = true;
    return result;
  }

  @override
  Future<FilePickerResult?> pickImage() async {
    allowMultiple = false;
    return result;
  }

  @override
  Future<FilePickerResult?> pickJson() async => result;

  @override
  Future<String?> saveFile({
    required String filename,
    required List<String> extensions,
    required Uint8List bytes,
  }) async => null;

  @override
  Future<bool?> clearTemporaryFiles() async {
    clearCalls++;
    return true;
  }
}
