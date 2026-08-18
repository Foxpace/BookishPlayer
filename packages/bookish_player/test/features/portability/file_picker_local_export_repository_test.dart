import 'dart:convert';
import 'dart:typed_data';

import 'package:bookish_player/core/platform/file_picker_gateway.dart';
import 'package:bookish_player/features/portability/repos/implementations/file_picker_local_export_repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_support/support/fixtures.dart';

void main() {
  group('Isolated local file picker', () {
    late _FilePicker picker;
    late FilePickerLocalExportRepository sut;

    setUp(() {
      picker = _FilePicker();
      sut = FilePickerLocalExportRepository(picker);
    });

    test(
      'Given an isolated local file picker, When notes are exported as Markdown, Then the filename is safe and timestamps remain readable',
      () async {
        // WHEN
        final exported = await sut.exportNotes(
          audiobookFixture().copyWith(
            title: 'A/B: Story?',
            author: 'An Author',
          ),
          [
            bookNoteFixture().copyWith(positionMs: 65_000, text: 'First note'),
            bookNoteFixture(
              id: 'note-2',
            ).copyWith(positionMs: 3_661_000, text: 'Second note'),
          ],
        );

        // THEN
        expect(exported, isTrue);
        expect(picker.savedFilename, 'AB-Story-notes.md');
        expect(picker.savedExtensions, ['md']);
        final savedBytes = picker.savedBytes;
        if (savedBytes == null) {
          fail('Markdown export must provide bytes to the picker.');
        }
        final markdown = utf8.decode(savedBytes);
        expect(markdown, contains('# A/B: Story?'));
        expect(markdown, contains('Author: An Author'));
        expect(markdown, contains('## 0:01:05'));
        expect(markdown, contains('## 1:01:01'));
        expect(markdown, contains('Second note'));

        picker.savePath = null;
        expect(await sut.exportNotes(audiobookFixture(), const []), isFalse);
      },
    );

    test(
      'Given an isolated local file picker, When a backup is exported and selected again, Then schema-versioned JSON round-trips through picker bytes',
      () async {
        // WHEN
        final backup = backupFixture();

        // THEN
        expect(await sut.exportBackup(backup), isTrue);
        expect(picker.savedFilename, 'bookish-backup.json');
        expect(picker.savedExtensions, ['json']);
        final savedBytes = picker.savedBytes;
        if (savedBytes == null) {
          fail('Backup export must provide bytes to the picker.');
        }
        final payload = jsonDecode(utf8.decode(savedBytes)) as Map;
        expect(payload['schemaVersion'], 3);

        picker.pickedResult = FilePickerResult([
          PlatformFile(
            name: 'bookish-backup.json',
            size: savedBytes.length,
            bytes: savedBytes,
          ),
        ]);
        final restored = await sut.pickBackup();
        expect(restored?.schemaVersion, 3);
        expect(restored?.books.single.id, 'book-1');

        picker.pickedResult = null;
        expect(await sut.pickBackup(), isNull);
      },
    );
  });
}

class _FilePicker implements FilePickerGateway {
  String? savePath = '/exports/bookish';
  String? savedFilename;
  List<String>? savedExtensions;
  Uint8List? savedBytes;
  FilePickerResult? pickedResult;

  @override
  Future<String?> saveFile({
    required String filename,
    required List<String> extensions,
    required Uint8List bytes,
  }) async {
    savedFilename = filename;
    savedExtensions = extensions;
    savedBytes = bytes;
    return savePath;
  }

  @override
  Future<FilePickerResult?> pickJson() async => pickedResult;

  @override
  Future<FilePickerResult?> pickAudioFiles(List<String> extensions) async =>
      pickedResult;

  @override
  Future<FilePickerResult?> pickImage() async => pickedResult;

  @override
  Future<bool?> clearTemporaryFiles() async => true;
}
