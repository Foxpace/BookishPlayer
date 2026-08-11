import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bookish_player/features/importing/repos/implementations/iso_bmff_m4b_chapter_parser.dart';
import 'package:bookish_player/features/library/models/library_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Iso bmff m4b chapter parser', () {
    test(
      'Given the iso bmff m4b chapter parser, When its behavior is exercised, Then parses embedded chpl chapters without reading media payloads',
      () async {
        // GIVEN
        final temporary = await Directory.systemTemp.createTemp(
          'bookish_m4b_test_',
        );
        // WHEN
        final file = File('${temporary.path}/sample.m4b');
        // THEN
        try {
          final chapterPayload = <int>[
            0, 0, 0, 0, // version and flags
            0, 0, 0, 0, // reserved
            2,
            ..._u64(0),
            ..._title('Opening'),
            ..._u64(900 * 10000000),
            ..._title('The Journey'),
          ];
          final bytes = _box(
            'moov',
            _box('udta', _box('chpl', chapterPayload)),
          );
          await file.writeAsBytes(bytes);

          final chapters = await IsoBmffM4bChapterParser().parse(file.path);

          expect(chapters, hasLength(2));
          expect(chapters.first.title, 'Opening');
          expect(chapters.first.startMs, 0);
          expect(chapters.last.title, 'The Journey');
          expect(chapters.last.startMs, 900000);
        } finally {
          await temporary.delete(recursive: true);
        }
      },
    );

    test(
      'Given the iso bmff m4b chapter parser, When its behavior is exercised, Then ignores non-M4B files',
      () async {
        // THEN
        expect(
          await IsoBmffM4bChapterParser().parse('/does/not/exist.mp3'),
          isEmpty,
        );
      },
    );

    test(
      'Given the iso bmff m4b chapter parser, When its behavior is exercised, Then uses the custom ID3 CHAP fallback for MP3 chapters',
      () async {
        // GIVEN
        final temporary = await Directory.systemTemp.createTemp(
          'bookish_id3_chapter_test_',
        );
        // WHEN
        final file = File('${temporary.path}/sample.mp3');
        // THEN
        try {
          final titlePayload = [0, ...latin1.encode('Opening')];
          final titleFrame = [
            ...ascii.encode('TIT2'),
            ..._u32(titlePayload.length),
            0,
            0,
            ...titlePayload,
          ];
          final chapterPayload = [
            ...ascii.encode('chapter-1'),
            0,
            ..._u32(12000),
            ..._u32(30000),
            ..._u32(0xffffffff),
            ..._u32(0xffffffff),
            ...titleFrame,
          ];
          final chapterFrame = [
            ...ascii.encode('CHAP'),
            ..._u32(chapterPayload.length),
            0,
            0,
            ...chapterPayload,
          ];
          await file.writeAsBytes([
            ...ascii.encode('ID3'),
            3,
            0,
            0,
            ..._synchsafe(chapterFrame.length),
            ...chapterFrame,
          ]);

          final report = await IsoBmffM4bChapterParser().analyze(file.path);

          expect(report.chapters, [
            const AudioChapter(title: 'Opening', startMs: 12000),
          ]);
          expect(
            report.diagnostics,
            contains('Custom metadata fallback found 1 chapters.'),
          );
        } finally {
          await temporary.delete(recursive: true);
        }
      },
    );

    test(
      'Given the iso bmff m4b chapter parser, When its behavior is exercised, Then parses chapters from the real M4B sample',
      () async {
        // WHEN
        final sample = File(
          'test_samples/ancient_ballads_legends_hindustan_1501.m4b',
        );
        // THEN
        expect(
          sample.existsSync(),
          isTrue,
          reason:
              'The checked-in M4B fixture is required for this integration test.',
        );

        final report = await IsoBmffM4bChapterParser().analyze(sample.path);
        final chapters = report.chapters;

        expect(chapters, hasLength(21));
        expect(report.warnings, isEmpty);
        expect(
          report.diagnostics,
          contains('Native ISO-BMFF parser found 21 chapters.'),
        );
        expect(
          chapters.first.title,
          '00 - Introductory Memoir by Edmund W. Gosse',
        );
        expect(chapters.first.startMs, 0);
        expect(chapters[1].title, '01 - Savitri, Part I');
        expect(chapters[1].startMs, closeTo(1437017, 1));
        expect(chapters.last.title, '20 - Our Casuarina Tree');
        expect(chapters.last.startMs, closeTo(10672016, 1));
        expect(
          chapters.map((chapter) => chapter.startMs),
          orderedEquals(
            chapters.map((chapter) => chapter.startMs).toList()..sort(),
          ),
        );
      },
    );
  });
}

List<int> _title(String value) {
  final bytes = utf8.encode(value);
  return [bytes.length, ...bytes];
}

List<int> _box(String type, List<int> payload) => [
  ..._u32(payload.length + 8),
  ...ascii.encode(type),
  ...payload,
];

List<int> _u32(int value) {
  final data = ByteData(4)..setUint32(0, value);
  return data.buffer.asUint8List();
}

List<int> _u64(int value) {
  final data = ByteData(8)..setUint64(0, value);
  return data.buffer.asUint8List();
}

List<int> _synchsafe(int value) => [
  (value >> 21) & 0x7f,
  (value >> 14) & 0x7f,
  (value >> 7) & 0x7f,
  value & 0x7f,
];
