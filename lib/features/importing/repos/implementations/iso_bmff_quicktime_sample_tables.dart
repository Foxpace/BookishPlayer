import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

typedef QuickTimeBox = ({String type, int payloadStart, int end});

Future<List<int>> readQuickTimeSampleStarts(
  RandomAccessFile file,
  QuickTimeBox stts,
) async {
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

Future<List<int>> readQuickTimeSampleSizes(
  RandomAccessFile file,
  QuickTimeBox stsz,
) async {
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

Future<List<int>> readQuickTimeChunkOffsets(
  RandomAccessFile file,
  QuickTimeBox box,
) async {
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

Future<List<int>> readQuickTimeSampleToChunk(
  RandomAccessFile file,
  QuickTimeBox stsc,
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

Future<String?> readQuickTimeTextSample(
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

int _u32(List<int> bytes, int offset) =>
    ByteData.sublistView(Uint8List.fromList(bytes)).getUint32(offset);

int _u64(List<int> bytes, int offset) =>
    ByteData.sublistView(Uint8List.fromList(bytes)).getUint64(offset);
