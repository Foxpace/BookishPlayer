import 'dart:convert';
import 'dart:typed_data';

import 'package:bookish_player/core/platform/file_picker_gateway.dart';
import 'package:bookish_player/core/platform/picked_local_file.dart';
import 'package:bookish_player/features/portability/repos/implementations/file_picker_local_export_repository.dart';
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

    test('Given an isolated local file picker, When notes are exported, Then the filename is safe and timestamps remain readable', () async {
      // WHEN
      final exported = await sut.exportNotes(
        audiobookFixture().copyWith(title: 'A/B: Story?', author: 'An Author'),
        [
          bookNoteFixture().copyWith(positionMs: 65_000, text: 'First note'),
          bookNoteFixture(id: 'note-2')
              .copyWith(positionMs: 3_661_000, text: 'Second note'),
        ],
      );

      // THEN
      expect(exported, isTrue);
      expect(picker.savedFilename, 'AB-Story-notes.md');
      expect(picker.savedExtensions, ['md']);
      final savedBytes = picker.savedBytes;
      if (savedBytes == null) {
        fail('Note export must provide bytes to the picker.');
      }
      final exportedNotes = utf8.decode(savedBytes);
      expect(exportedNotes, contains('# A/B: Story?'));
      expect(exportedNotes, contains('Author: An Author'));
      expect(exportedNotes, contains('## 0:01:05'));
      expect(exportedNotes, contains('## 1:01:01'));
      expect(exportedNotes, contains('Second note'));

      picker.shouldSave = false;
      expect(await sut.exportNotes(audiobookFixture(), const []), isFalse);
    });

    test('Given an isolated local file picker, When a backup is exported and selected again, Then schema-versioned JSON round-trips through picker bytes', () async {
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

      picker.pickedJsonBytes = savedBytes;
      final restored = await sut.pickBackup();
      expect(restored?.schemaVersion, 3);
      expect(restored?.books.single.id, 'book-1');

      picker.pickedJsonBytes = null;
      expect(await sut.pickBackup(), isNull);
    });

    test('Given an older backup with a bookmark, When it is selected, Then only notes are restored', () async {
      // GIVEN
      final backup = backupFixture().toJson();
      backup['notes'] = [
        bookNoteFixture().toJson(),
        {...bookNoteFixture(id: 'legacy-bookmark').toJson(), 'kind': 'bookmark'},
      ];
      picker.pickedJsonBytes = Uint8List.fromList(utf8.encode(jsonEncode(backup)));

      // WHEN
      final restored = await sut.pickBackup();

      // THEN
      expect(restored?.notes.map((note) => note.id), ['note-1']);
    });
  });
}

class _FilePicker implements FilePickerGateway {
  var shouldSave = true;
  String? savedFilename;
  List<String>? savedExtensions;
  Uint8List? savedBytes;
  Uint8List? pickedJsonBytes;

  @override
  Future<bool> saveFile({
    required String filename,
    required List<String> extensions,
    required Uint8List bytes,
  }) async {
    savedFilename = filename;
    savedExtensions = extensions;
    savedBytes = bytes;
    return shouldSave;
  }

  @override
  Future<Uint8List?> pickJsonBytes() async => pickedJsonBytes;

  @override
  Future<List<PickedLocalFile>> pickAudioFiles(List<String> extensions) async =>
      const [];

  @override
  Future<PickedLocalFile?> pickImage() async => null;

  @override
  Future<void> clearTemporaryFiles() async {}
}
