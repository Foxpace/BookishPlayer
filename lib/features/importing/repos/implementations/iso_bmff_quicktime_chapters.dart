import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import '../../../library/models/library_models.dart';
import 'iso_bmff_m4b_chapter_parser.dart';
import 'iso_bmff_quicktime_sample_tables.dart';

extension QuickTimeChapterReader on IsoBmffM4bChapterParser {
  Future<List<AudioChapter>> readQuickTimeChapterTrack(
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

    final starts = await readQuickTimeSampleStarts(file, stts);
    final sizes = await readQuickTimeSampleSizes(file, stsz);
    final chunks = await readQuickTimeChunkOffsets(file, stco);
    final samplesPerChunk = await readQuickTimeSampleToChunk(
      file,
      stsc,
      chunks.length,
    );
    if (starts.isEmpty || starts.length != sizes.length || chunks.isEmpty) {
      return const [];
    }

    final offsets = _readSampleOffsets(sizes, chunks, samplesPerChunk);
    if (offsets.length != sizes.length) {
      return const [];
    }

    return _readChapters(file, starts, sizes, offsets, timescale);
  }

  List<int> _readSampleOffsets(
    List<int> sizes,
    List<int> chunks,
    List<int> samplesPerChunk,
  ) {
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

    return offsets;
  }

  Future<List<AudioChapter>> _readChapters(
    RandomAccessFile file,
    List<int> starts,
    List<int> sizes,
    List<int> offsets,
    int timescale,
  ) async {
    final chapters = <AudioChapter>[];
    for (var index = 0; index < sizes.length; index++) {
      final title = await readQuickTimeTextSample(
        file,
        offsets[index],
        sizes[index],
      );
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

  Future<QuickTimeBox?> _findChild(
    RandomAccessFile file,
    int start,
    int end,
    String wanted,
  ) async {
    var offset = start;
    while (offset + 8 <= end) {
      final box = await _readBox(file, offset, end);
      if (box == null) {
        return null;
      }

      if (box.type == wanted) {
        return box;
      }

      offset = box.end;
    }

    return null;
  }

  Future<QuickTimeBox?> _readBox(
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

  Future<String?> _readType(RandomAccessFile file, int offset) async {
    await file.setPosition(offset);
    final bytes = await file.read(4);
    return bytes.length == 4 ? ascii.decode(bytes, allowInvalid: true) : null;
  }

  Future<int> _readTimescale(RandomAccessFile file, QuickTimeBox mdhd) async {
    await file.setPosition(mdhd.payloadStart);
    final version = await file.readByte();
    final offset = mdhd.payloadStart + (version == 1 ? 20 : 12);
    await file.setPosition(offset);
    final bytes = await file.read(4);
    return bytes.length == 4 ? _u32(bytes, 0) : 0;
  }
}

int _u32(List<int> bytes, int offset) =>
    ByteData.sublistView(Uint8List.fromList(bytes)).getUint32(offset);

int _u64(List<int> bytes, int offset) =>
    ByteData.sublistView(Uint8List.fromList(bytes)).getUint64(offset);
