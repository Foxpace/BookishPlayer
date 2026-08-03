part of 'embedded_audio_metadata_reader.dart';

_Box? _readBox(RandomAccessFile file, int offset, int parentEnd) {
  final header = _readAt(file, offset, 8);
  if (header.length != 8) {
    return null;
  }
  var size = _u32(header, 0);
  var headerSize = 8;
  if (size == 1) {
    final extended = _readAt(file, offset + 8, 8);
    if (extended.length != 8) {
      return null;
    }
    size = _u64(extended, 0);
    headerSize = 16;
  } else if (size == 0) {
    size = parentEnd - offset;
  }
  if (size < headerSize || offset + size > parentEnd) {
    return null;
  }
  return (
    type: latin1.decode(header.sublist(4, 8), allowInvalid: true),
    payloadStart: offset + headerSize,
    end: offset + size,
  );
}

Uint8List _readAt(RandomAccessFile file, int offset, int length) {
  file.setPositionSync(offset);
  return Uint8List.fromList(file.readSync(length));
}

int _zeroIndex(List<int> bytes, int start) {
  for (var index = start; index < bytes.length; index++) {
    if (bytes[index] == 0) {
      return index;
    }
  }
  return -1;
}

int _terminatedTextEnd(List<int> bytes, int start, int encoding) {
  if (encoding != 1 && encoding != 2) {
    return _zeroIndex(bytes, start);
  }
  for (var index = start; index + 1 < bytes.length; index += 2) {
    if (bytes[index] == 0 && bytes[index + 1] == 0) {
      return index;
    }
  }
  return -1;
}

String _imageMime(List<int> bytes, String declared) {
  if (bytes.length >= 8 &&
      bytes[0] == 0x89 &&
      ascii.decode(bytes.sublist(1, 4), allowInvalid: true) == 'PNG') {
    return 'image/png';
  }
  if (bytes.length >= 3 && bytes[0] == 0xff && bytes[1] == 0xd8) {
    return 'image/jpeg';
  }
  if (bytes.length >= 6 && ascii.decode(bytes.sublist(0, 3)) == 'GIF') {
    return 'image/gif';
  }
  if (bytes.length >= 12 && ascii.decode(bytes.sublist(8, 12)) == 'WEBP') {
    return 'image/webp';
  }
  return declared.isEmpty ? 'image/jpeg' : declared;
}

int _synchsafe(List<int> bytes, int offset) =>
    ((bytes[offset] & 0x7f) << 21) |
    ((bytes[offset + 1] & 0x7f) << 14) |
    ((bytes[offset + 2] & 0x7f) << 7) |
    (bytes[offset + 3] & 0x7f);

int _u32(List<int> bytes, int offset) =>
    ByteData.sublistView(Uint8List.fromList(bytes)).getUint32(offset);

int _u32le(List<int> bytes, int offset) => ByteData.sublistView(
  Uint8List.fromList(bytes),
).getUint32(offset, Endian.little);

int _u64(List<int> bytes, int offset) =>
    ByteData.sublistView(Uint8List.fromList(bytes)).getUint64(offset);

const _mp4Containers = {
  'moov',
  'trak',
  'mdia',
  'minf',
  'stbl',
  'udta',
  'meta',
  'ilst',
};

typedef _Box = ({String type, int payloadStart, int end});

typedef _Id3Metadata = ({
  EmbeddedArtwork? artwork,
  List<EmbeddedChapterMetadata> chapters,
  EmbeddedTextMetadata text,
});
