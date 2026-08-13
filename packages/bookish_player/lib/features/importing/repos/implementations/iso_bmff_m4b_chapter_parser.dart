import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:injectable/injectable.dart';

import '../../../library/models/library_models.dart';
import '../../models/chapter_parse_report.dart';
import '../m4b_chapter_parser.dart';
import 'embedded_audio_metadata_reader.dart';
import 'iso_bmff_chapter_list.dart';
import 'iso_bmff_quicktime_chapters.dart';

typedef _IsoBox = ({String type, int payloadStart, int end});

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
      final native = await _tryAnalyzeNativeChapters(
        source,
        diagnostics,
        warnings,
      );
      if (native != null) {
        return native;
      }
    }
    return _analyzeEmbeddedChapters(filePath, diagnostics, warnings);
  }

  Future<ChapterParseReport?> _tryAnalyzeNativeChapters(
    File source,
    List<String> diagnostics,
    List<String> warnings,
  ) async {
    try {
      return await _readNativeChapterReport(source, diagnostics, warnings);
    } catch (error, stackTrace) {
      return _recordNativeParserFailure(warnings, error, stackTrace);
    }
  }

  ChapterParseReport? _recordNativeParserFailure(
    List<String> warnings,
    Object error,
    StackTrace stackTrace,
  ) {
    warnings.add('Native ISO-BMFF parser failed: $error\n$stackTrace');
    return null;
  }

  Future<ChapterParseReport?> _readNativeChapterReport(
    File source,
    List<String> diagnostics,
    List<String> warnings,
  ) async {
    final file = await source.open();
    try {
      return await _parseNativeChapterReport(file, diagnostics, warnings);
    } finally {
      await file.close();
    }
  }

  Future<ChapterParseReport?> _parseNativeChapterReport(
    RandomAccessFile file,
    List<String> diagnostics,
    List<String> warnings,
  ) async {
    final chapters = await _scan(file, 0, await file.length(), 0);
    if (chapters == null || chapters.isEmpty) {
      diagnostics.add('No chpl atom or QuickTime text chapter track found.');
      return null;
    }
    diagnostics.add(
      'Native ISO-BMFF parser found ${chapters.length} chapters.',
    );
    return ChapterParseReport(
      chapters: chapters,
      diagnostics: diagnostics,
      warnings: warnings,
    );
  }

  Future<ChapterParseReport> _analyzeEmbeddedChapters(
    String filePath,
    List<String> diagnostics,
    List<String> warnings,
  ) async {
    try {
      return await _readEmbeddedChapterReport(filePath, diagnostics, warnings);
    } catch (error, stackTrace) {
      return _buildEmbeddedChapterFailure(
        diagnostics,
        warnings,
        error,
        stackTrace,
      );
    }
  }

  Future<ChapterParseReport> _readEmbeddedChapterReport(
    String filePath,
    List<String> diagnostics,
    List<String> warnings,
  ) async {
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
  }

  ChapterParseReport _buildEmbeddedChapterFailure(
    List<String> diagnostics,
    List<String> warnings,
    Object error,
    StackTrace stackTrace,
  ) {
    warnings.add('Custom metadata fallback failed: $error\n$stackTrace');
    return ChapterParseReport(diagnostics: diagnostics, warnings: warnings);
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
      final box = await _readBox(file, offset, end);
      if (box == null) {
        break;
      }

      final chapters = await _readBoxChapters(file, box, depth);
      if (chapters != null && chapters.isNotEmpty) {
        return chapters;
      }

      offset = box.end;
    }

    return null;
  }

  Future<_IsoBox?> _readBox(
    RandomAccessFile file,
    int offset,
    int containerEnd,
  ) async {
    await file.setPosition(offset);
    final header = await file.read(8);
    if (header.length != 8) {
      return null;
    }

    var size = _u32(header, 0);
    final type = ascii.decode(header.sublist(4, 8), allowInvalid: true);
    var headerSize = 8;

    if (size == 1) {
      final extended = await file.read(8);
      if (extended.length != 8) {
        return null;
      }

      size = _u64(extended, 0);
      headerSize = 16;
    } else if (size == 0) {
      size = containerEnd - offset;
    }

    final boxEnd = offset + size;
    if (size < headerSize || boxEnd > containerEnd) {
      return null;
    }

    return (type: type, payloadStart: offset + headerSize, end: boxEnd);
  }

  Future<List<AudioChapter>?> _readBoxChapters(
    RandomAccessFile file,
    _IsoBox box,
    int depth,
  ) async {
    if (box.type == 'chpl') {
      return readChapterList(file, box.payloadStart, box.end);
    }

    if (box.type == 'trak') {
      final chapters = await readQuickTimeChapterTrack(
        file,
        box.payloadStart,
        box.end,
      );
      if (chapters.isNotEmpty) {
        return chapters;
      }

      return _scan(file, box.payloadStart, box.end, depth + 1);
    }

    if (!_containers.contains(box.type)) {
      return null;
    }

    final childStart = box.payloadStart + (box.type == 'meta' ? 4 : 0);
    return _scan(file, childStart, box.end, depth + 1);
  }

  /// Reads the text track used by iTunes and older M4B authoring tools for
  /// chapters. The titles live in regular media samples; their timestamps and
  /// file offsets are described by the track's MP4 sample tables.
}

int _u32(List<int> bytes, int offset) =>
    ByteData.sublistView(Uint8List.fromList(bytes)).getUint32(offset);

int _u64(List<int> bytes, int offset) =>
    ByteData.sublistView(Uint8List.fromList(bytes)).getUint64(offset);
