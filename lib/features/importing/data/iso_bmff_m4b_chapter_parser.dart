import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:injectable/injectable.dart';

import '../../library/domain/audiobook.dart';
import '../domain/chapter_parse_report.dart';
import '../domain/m4b_chapter_parser.dart';
import 'embedded_audio_metadata_reader.dart';

part 'iso_bmff_quicktime_chapters.dart';
part 'iso_bmff_chapter_list.dart';

/// Reads Nero/Apple `chpl` chapter atoms directly from an ISO-BMFF (M4B) file.
/// It intentionally skips media payload boxes, so large audiobooks are never
/// loaded into memory.
@LazySingleton(as: M4bChapterParser)
class IsoBmffM4bChapterParser implements M4bChapterParser {
  static const _containers = {
    'moov',
    'trak',
    'mdia',
    'minf',
    'stbl',
    'udta',
    'meta',
    'ilst',
    'moof',
  };

  @override
  Future<List<AudioChapter>> parse(String filePath) async =>
      (await analyze(filePath)).chapters;

  @override
  Future<ChapterParseReport> analyze(String filePath) async {
    final diagnostics = <String>['File: $filePath'];
    final warnings = <String>[];
    final source = File(filePath);
    try {
      diagnostics.add('Size: ${await source.length()} bytes');
    } catch (error, stackTrace) {
      warnings.add('Could not inspect the source file: $error\n$stackTrace');
    }

    if (filePath.toLowerCase().endsWith('.m4b')) {
      RandomAccessFile? file;
      try {
        file = await source.open();
        final chapters = await _scan(file, 0, await file.length(), 0);
        if (chapters != null && chapters.isNotEmpty) {
          diagnostics.add(
            'Native ISO-BMFF parser found ${chapters.length} chapters.',
          );
          return ChapterParseReport(
            chapters: chapters,
            diagnostics: diagnostics,
            warnings: warnings,
          );
        }
        diagnostics.add('No chpl atom or QuickTime text chapter track found.');
      } catch (error, stackTrace) {
        warnings.add('Native ISO-BMFF parser failed: $error\n$stackTrace');
      } finally {
        await file?.close();
      }
    }
    try {
      final embeddedChapters = await Isolate.run(
        () => readEmbeddedChapters(File(filePath)),
      );
      final chapters = embeddedChapters
          .map(
            (chapter) =>
                AudioChapter(title: chapter.title, startMs: chapter.startMs),
          )
          .toList();
      diagnostics.add(
        chapters.isEmpty
            ? 'Custom metadata fallback found no chapters.'
            : 'Custom metadata fallback found ${chapters.length} chapters.',
      );
      return ChapterParseReport(
        chapters: chapters,
        diagnostics: diagnostics,
        warnings: warnings,
      );
    } catch (error, stackTrace) {
      warnings.add('Custom metadata fallback failed: $error\n$stackTrace');
      return ChapterParseReport(diagnostics: diagnostics, warnings: warnings);
    }
  }

  Future<List<AudioChapter>?> _scan(
    RandomAccessFile file,
    int start,
    int end,
    int depth,
  ) async {
    if (depth > 12) {
      return null;
    }
    var offset = start;
    while (offset + 8 <= end) {
      await file.setPosition(offset);
      final header = await file.read(8);
      if (header.length != 8) {
        break;
      }
      var size = _u32(header, 0);
      final type = ascii.decode(header.sublist(4, 8), allowInvalid: true);
      var headerSize = 8;
      if (size == 1) {
        final extended = await file.read(8);
        if (extended.length != 8) {
          break;
        }
        size = _u64(extended, 0);
        headerSize = 16;
      } else if (size == 0) {
        size = end - offset;
      }
      if (size < headerSize || offset + size > end) {
        break;
      }
      final payloadStart = offset + headerSize;
      final boxEnd = offset + size;
      if (type == 'chpl') {
        final chapters = await _readChapterList(file, payloadStart, boxEnd);
        if (chapters.isNotEmpty) {
          return chapters;
        }
      } else if (type == 'trak') {
        final chapters = await _readQuickTimeChapterTrack(
          file,
          payloadStart,
          boxEnd,
        );
        if (chapters.isNotEmpty) {
          return chapters;
        }
        final nested = await _scan(file, payloadStart, boxEnd, depth + 1);
        if (nested != null && nested.isNotEmpty) {
          return nested;
        }
      } else if (_containers.contains(type)) {
        final childStart = payloadStart + (type == 'meta' ? 4 : 0);
        final chapters = await _scan(file, childStart, boxEnd, depth + 1);
        if (chapters != null && chapters.isNotEmpty) {
          return chapters;
        }
      }
      offset = boxEnd;
    }
    return null;
  }

  /// Reads the text track used by iTunes and older M4B authoring tools for
  /// chapters. The titles live in regular media samples; their timestamps and
  /// file offsets are described by the track's MP4 sample tables.
}

int _u32(List<int> bytes, int offset) =>
    ByteData.sublistView(Uint8List.fromList(bytes)).getUint32(offset);

int _u64(List<int> bytes, int offset) =>
    ByteData.sublistView(Uint8List.fromList(bytes)).getUint64(offset);

typedef _Box = ({String type, int payloadStart, int end});
