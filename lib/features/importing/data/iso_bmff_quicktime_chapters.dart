part of 'iso_bmff_m4b_chapter_parser.dart';

extension _QuickTimeChapters on IsoBmffM4bChapterParser {
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
      final box = (
        type: type,
        payloadStart: offset + headerSize,
        end: offset + size,
      );
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
}
