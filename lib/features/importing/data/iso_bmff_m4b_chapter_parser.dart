import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:injectable/injectable.dart';

import '../../library/domain/audiobook.dart';
import '../domain/chapter_parse_report.dart';
import '../domain/m4b_chapter_parser.dart';
import 'embedded_audio_metadata_reader.dart';

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
      final chapters = readEmbeddedChapters(source)
          .map(
            (chapter) => AudioChapter(
              title: chapter.title,
              startMs: chapter.startMs,
            ),
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
  Future<List<AudioChapter>> _readQuickTimeChapterTrack(
    RandomAccessFile file,
    int start,
    int end,
  ) async {
    final mdia = await _findChild(file, start, end, 'mdia');
    if (mdia == null) {
      return const [];
    }
    final hdlr = await _findChild(file, mdia.payloadStart, mdia.end, 'hdlr');
    if (hdlr == null ||
        await _readType(file, hdlr.payloadStart + 8) != 'text') {
      return const [];
    }
    final mdhd = await _findChild(file, mdia.payloadStart, mdia.end, 'mdhd');
    final minf = await _findChild(file, mdia.payloadStart, mdia.end, 'minf');
    if (mdhd == null || minf == null) {
      return const [];
    }
    final stbl = await _findChild(file, minf.payloadStart, minf.end, 'stbl');
    if (stbl == null) {
      return const [];
    }

    final stsd = await _findChild(file, stbl.payloadStart, stbl.end, 'stsd');
    if (stsd == null ||
        await _readType(file, stsd.payloadStart + 12) != 'text') {
      return const [];
    }
    final timescale = await _readTimescale(file, mdhd);
    final stts = await _findChild(file, stbl.payloadStart, stbl.end, 'stts');
    final stsc = await _findChild(file, stbl.payloadStart, stbl.end, 'stsc');
    final stsz = await _findChild(file, stbl.payloadStart, stbl.end, 'stsz');
    final stco =
        await _findChild(file, stbl.payloadStart, stbl.end, 'stco') ??
        await _findChild(file, stbl.payloadStart, stbl.end, 'co64');
    if (timescale <= 0 ||
        stts == null ||
        stsc == null ||
        stsz == null ||
        stco == null) {
      return const [];
    }

    final starts = await _readSampleStarts(file, stts);
    final sizes = await _readSampleSizes(file, stsz);
    final chunks = await _readChunkOffsets(file, stco);
    final samplesPerChunk = await _readSampleToChunk(file, stsc, chunks.length);
    if (starts.isEmpty || starts.length != sizes.length || chunks.isEmpty) {
      return const [];
    }
    final offsets = <int>[];
    var sampleIndex = 0;
    for (
      var chunkIndex = 0;
      chunkIndex < chunks.length && sampleIndex < sizes.length;
      chunkIndex++
    ) {
      var offset = chunks[chunkIndex];
      final count = samplesPerChunk[chunkIndex];
      for (
        var index = 0;
        index < count && sampleIndex < sizes.length;
        index++
      ) {
        offsets.add(offset);
        offset += sizes[sampleIndex++];
      }
    }
    if (offsets.length != sizes.length) {
      return const [];
    }

    final chapters = <AudioChapter>[];
    for (var index = 0; index < sizes.length; index++) {
      final title = await _readTextSample(file, offsets[index], sizes[index]);
      if (title == null) {
        return const [];
      }
      chapters.add(
        AudioChapter(
          title: title.isEmpty ? 'Chapter ${index + 1}' : title,
          startMs: starts[index] * 1000 ~/ timescale,
        ),
      );
    }
    return chapters;
  }

  Future<_Box?> _findChild(
    RandomAccessFile file,
    int start,
    int end,
    String wanted,
  ) async {
    var offset = start;
    while (offset + 8 <= end) {
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
        size = end - offset;
      }
      if (size < headerSize || offset + size > end) {
        return null;
      }
      final box = _Box(type, offset + headerSize, offset + size);
      if (type == wanted) {
        return box;
      }
      offset += size;
    }
    return null;
  }

  Future<String?> _readType(RandomAccessFile file, int offset) async {
    await file.setPosition(offset);
    final bytes = await file.read(4);
    return bytes.length == 4 ? ascii.decode(bytes, allowInvalid: true) : null;
  }

  Future<int> _readTimescale(RandomAccessFile file, _Box mdhd) async {
    await file.setPosition(mdhd.payloadStart);
    final version = await file.readByte();
    final offset = mdhd.payloadStart + (version == 1 ? 20 : 12);
    await file.setPosition(offset);
    final bytes = await file.read(4);
    return bytes.length == 4 ? _u32(bytes, 0) : 0;
  }

  Future<List<int>> _readSampleStarts(RandomAccessFile file, _Box stts) async {
    await file.setPosition(stts.payloadStart + 4);
    final countBytes = await file.read(4);
    if (countBytes.length != 4) {
      return const [];
    }
    final entryCount = _u32(countBytes, 0);
    if (entryCount > 100000) {
      return const [];
    }
    final starts = <int>[];
    var timestamp = 0;
    for (var index = 0; index < entryCount; index++) {
      final entry = await file.read(8);
      if (entry.length != 8) {
        return const [];
      }
      final sampleCount = _u32(entry, 0);
      final delta = _u32(entry, 4);
      if (starts.length + sampleCount > 100000) {
        return const [];
      }
      for (var sample = 0; sample < sampleCount; sample++) {
        starts.add(timestamp);
        timestamp += delta;
      }
    }
    return starts;
  }

  Future<List<int>> _readSampleSizes(RandomAccessFile file, _Box stsz) async {
    await file.setPosition(stsz.payloadStart + 4);
    final header = await file.read(8);
    if (header.length != 8) {
      return const [];
    }
    final fixedSize = _u32(header, 0);
    final count = _u32(header, 4);
    if (count == 0 || count > 100000) {
      return const [];
    }
    if (fixedSize != 0) {
      return List.filled(count, fixedSize);
    }
    final sizes = <int>[];
    for (var index = 0; index < count; index++) {
      final bytes = await file.read(4);
      if (bytes.length != 4) {
        return const [];
      }
      sizes.add(_u32(bytes, 0));
    }
    return sizes;
  }

  Future<List<int>> _readChunkOffsets(RandomAccessFile file, _Box box) async {
    await file.setPosition(box.payloadStart + 4);
    final countBytes = await file.read(4);
    if (countBytes.length != 4) {
      return const [];
    }
    final count = _u32(countBytes, 0);
    if (count == 0 || count > 100000) {
      return const [];
    }
    final width = box.type == 'co64' ? 8 : 4;
    final offsets = <int>[];
    for (var index = 0; index < count; index++) {
      final bytes = await file.read(width);
      if (bytes.length != width) {
        return const [];
      }
      offsets.add(width == 8 ? _u64(bytes, 0) : _u32(bytes, 0));
    }
    return offsets;
  }

  Future<List<int>> _readSampleToChunk(
    RandomAccessFile file,
    _Box stsc,
    int chunkCount,
  ) async {
    await file.setPosition(stsc.payloadStart + 4);
    final countBytes = await file.read(4);
    if (countBytes.length != 4) {
      return const [];
    }
    final count = _u32(countBytes, 0);
    if (count == 0 || count > 100000) {
      return const [];
    }
    final entries = <(int, int)>[];
    for (var index = 0; index < count; index++) {
      final bytes = await file.read(12);
      if (bytes.length != 12) {
        return const [];
      }
      entries.add((_u32(bytes, 0), _u32(bytes, 4)));
    }
    final result = <int>[];
    var entryIndex = 0;
    for (var chunk = 1; chunk <= chunkCount; chunk++) {
      while (entryIndex + 1 < entries.length &&
          entries[entryIndex + 1].$1 <= chunk) {
        entryIndex++;
      }
      result.add(entries[entryIndex].$2);
    }
    return result;
  }

  Future<String?> _readTextSample(
    RandomAccessFile file,
    int offset,
    int size,
  ) async {
    if (size < 2 || size > 1024 * 1024) {
      return null;
    }
    await file.setPosition(offset);
    final bytes = await file.read(size);
    if (bytes.length != size) {
      return null;
    }
    final titleLength = (bytes[0] << 8) | bytes[1];
    if (titleLength > size - 2) {
      return null;
    }
    return utf8
        .decode(bytes.sublist(2, 2 + titleLength), allowMalformed: true)
        .replaceAll('\u0000', '')
        .trim();
  }

  Future<List<AudioChapter>> _readChapterList(
    RandomAccessFile file,
    int start,
    int end,
  ) async {
    final length = end - start;
    if (length < 5 || length > 4 * 1024 * 1024) {
      return const [];
    }
    await file.setPosition(start);
    final bytes = Uint8List.fromList(await file.read(length));
    // Standard chpl has 4-byte full-box flags, 4 reserved bytes, then count.
    // Some encoders omit the reserved word, so support both layouts.
    return _decodeEntries(bytes, 8) ?? _decodeEntries(bytes, 4) ?? const [];
  }

  List<AudioChapter>? _decodeEntries(Uint8List bytes, int countOffset) {
    if (countOffset >= bytes.length) {
      return null;
    }
    final count = bytes[countOffset];
    if (count == 0 || count > 250) {
      return null;
    }
    var cursor = countOffset + 1;
    final chapters = <AudioChapter>[];
    for (var index = 0; index < count; index++) {
      if (cursor + 9 > bytes.length) {
        return null;
      }
      final startMs = _u64(bytes, cursor) ~/ 10000;
      cursor += 8;
      final titleLength = bytes[cursor++];
      if (cursor + titleLength > bytes.length) {
        return null;
      }
      final rawTitle = utf8
          .decode(
            bytes.sublist(cursor, cursor + titleLength),
            allowMalformed: true,
          )
          .trim();
      cursor += titleLength;
      chapters.add(
        AudioChapter(
          title: rawTitle.isEmpty ? 'Chapter ${index + 1}' : rawTitle,
          startMs: startMs,
        ),
      );
    }
    for (var index = 1; index < chapters.length; index++) {
      if (chapters[index].startMs < chapters[index - 1].startMs) {
        return null;
      }
    }
    return chapters;
  }

  int _u32(List<int> bytes, int offset) =>
      ByteData.sublistView(Uint8List.fromList(bytes)).getUint32(offset);

  int _u64(List<int> bytes, int offset) =>
      ByteData.sublistView(Uint8List.fromList(bytes)).getUint64(offset);
}

class _Box {
  const _Box(this.type, this.payloadStart, this.end);

  final String type;
  final int payloadStart;
  final int end;
}
