part of 'embedded_audio_metadata_reader.dart';

EmbeddedTextMetadata _readMp4TextMetadata(
  RandomAccessFile file,
  int fileLength,
) {
  final tags = <String, String>{};
  _scanMp4Text(file, 0, fileLength, 0, tags);
  return _metadataFromTags(tags);
}

void _scanMp4Text(
  RandomAccessFile file,
  int start,
  int end,
  int depth,
  Map<String, String> tags,
) {
  if (depth > 12) {
    return;
  }
  var offset = start;
  while (offset + 8 <= end) {
    final box = _readBox(file, offset, end);
    if (box == null) {
      return;
    }
    final tagKey = _mp4TextAtoms[box.type];
    if (tagKey != null) {
      final value = _readMp4ItemText(file, box.payloadStart, box.end);
      if (value != null) {
        tags.putIfAbsent(tagKey, () => value);
      }
    } else if (box.type == '----') {
      final entry = _readMp4FreeformText(file, box.payloadStart, box.end);
      if (entry != null) {
        tags.putIfAbsent(entry.key, () => entry.value);
      }
    }
    if (_mp4Containers.contains(box.type)) {
      final childStart = box.payloadStart + (box.type == 'meta' ? 4 : 0);
      _scanMp4Text(file, childStart, box.end, depth + 1, tags);
    }
    offset = box.end;
  }
}

String? _readMp4ItemText(RandomAccessFile file, int start, int end) {
  var offset = start;
  while (offset + 8 <= end) {
    final box = _readBox(file, offset, end);
    if (box == null) {
      return null;
    }
    if (box.type == 'data' && box.end - box.payloadStart > 8) {
      return _cleanText(
        utf8.decode(
          _readAt(file, box.payloadStart + 8, box.end - box.payloadStart - 8),
          allowMalformed: true,
        ),
      );
    }
    offset = box.end;
  }
  return null;
}

MapEntry<String, String>? _readMp4FreeformText(
  RandomAccessFile file,
  int start,
  int end,
) {
  String? name;
  String? value;
  var offset = start;
  while (offset + 8 <= end) {
    final box = _readBox(file, offset, end);
    if (box == null) {
      return null;
    }
    if (box.type == 'name' && box.end - box.payloadStart > 4) {
      name = _cleanText(
        utf8.decode(
          _readAt(file, box.payloadStart + 4, box.end - box.payloadStart - 4),
          allowMalformed: true,
        ),
      );
    } else if (box.type == 'data' && box.end - box.payloadStart > 8) {
      value = _cleanText(
        utf8.decode(
          _readAt(file, box.payloadStart + 8, box.end - box.payloadStart - 8),
          allowMalformed: true,
        ),
      );
    }
    offset = box.end;
  }
  if (name == null || value == null) {
    return null;
  }
  return MapEntry(name.toUpperCase().replaceAll(' ', '_'), value);
}

EmbeddedTextMetadata _readFlacTextMetadata(
  RandomAccessFile file,
  int fileLength,
) {
  var offset = 4;
  while (offset + 4 <= fileLength) {
    final header = _readAt(file, offset, 4);
    final isLast = header[0] & 0x80 != 0;
    final type = header[0] & 0x7f;
    final length = (header[1] << 16) | (header[2] << 8) | header[3];
    offset += 4;
    if (offset + length > fileLength) {
      break;
    }
    if (type == 4) {
      return _metadataFromTags(
        _decodeVorbisComments(_readAt(file, offset, length)),
      );
    }
    offset += length;
    if (isLast) {
      break;
    }
  }
  return const EmbeddedTextMetadata();
}

EmbeddedTextMetadata _readWaveTextMetadata(
  RandomAccessFile file,
  int fileLength,
) {
  var offset = 12;
  while (offset + 8 <= fileLength) {
    final header = _readAt(file, offset, 8);
    final type = ascii.decode(header.sublist(0, 4), allowInvalid: true);
    final length = _u32le(header, 4);
    final payloadStart = offset + 8;
    if (payloadStart + length > fileLength) {
      break;
    }
    if (type.toLowerCase() == 'id3 ') {
      return _readId3(file, payloadStart)?.text ?? const EmbeddedTextMetadata();
    }
    offset = payloadStart + length + (length.isOdd ? 1 : 0);
  }
  return const EmbeddedTextMetadata();
}

EmbeddedTextMetadata _readOggTextMetadata(
  RandomAccessFile file,
  int fileLength,
) {
  var offset = 0;
  final packet = BytesBuilder(copy: false);
  while (offset + 27 <= fileLength && offset < 64 * 1024 * 1024) {
    final header = _readAt(file, offset, 27);
    if (ascii.decode(header.sublist(0, 4), allowInvalid: true) != 'OggS') {
      break;
    }
    final segmentCount = header[26];
    final lacing = _readAt(file, offset + 27, segmentCount);
    final bodyLength = lacing.fold<int>(0, (total, value) => total + value);
    final bodyStart = offset + 27 + segmentCount;
    if (bodyStart + bodyLength > fileLength) {
      break;
    }
    final body = _readAt(file, bodyStart, bodyLength);
    var bodyCursor = 0;
    for (final segmentLength in lacing) {
      packet.add(body.sublist(bodyCursor, bodyCursor + segmentLength));
      bodyCursor += segmentLength;
      if (segmentLength < 255) {
        final bytes = packet.takeBytes();
        final comments = _decodeOggComments(bytes);
        if (comments != null) {
          return _metadataFromTags(comments);
        }
      }
    }
    offset = bodyStart + bodyLength;
  }
  return const EmbeddedTextMetadata();
}

Map<String, String>? _decodeOggComments(Uint8List packet) {
  final isVorbis =
      packet.length >= 7 &&
      packet[0] == 3 &&
      ascii.decode(packet.sublist(1, 7), allowInvalid: true) == 'vorbis';
  final isOpus =
      packet.length >= 8 &&
      ascii.decode(packet.sublist(0, 8), allowInvalid: true) == 'OpusTags';
  if (!isVorbis && !isOpus) {
    return null;
  }
  return _decodeVorbisComments(packet, offset: isVorbis ? 7 : 8);
}

Map<String, String> _decodeVorbisComments(Uint8List bytes, {int offset = 0}) {
  final tags = <String, String>{};
  var cursor = offset;
  if (cursor + 4 > bytes.length) {
    return tags;
  }
  final vendorLength = _u32le(bytes, cursor);
  cursor += 4 + vendorLength;
  if (cursor + 4 > bytes.length) {
    return tags;
  }
  final count = _u32le(bytes, cursor);
  cursor += 4;
  for (var index = 0; index < count && cursor + 4 <= bytes.length; index++) {
    final length = _u32le(bytes, cursor);
    cursor += 4;
    if (length > bytes.length - cursor) {
      break;
    }
    final comment = utf8.decode(
      bytes.sublist(cursor, cursor + length),
      allowMalformed: true,
    );
    cursor += length;
    final separator = comment.indexOf('=');
    if (separator <= 0) {
      continue;
    }
    final key = comment.substring(0, separator).toUpperCase();
    final value = _cleanText(comment.substring(separator + 1));
    if (value != null) {
      tags.putIfAbsent(key, () => value);
    }
  }
  return tags;
}

const _mp4TextAtoms = <String, String>{
  '©nam': 'TITLE',
  'aART': 'ALBUMARTIST',
  '©ART': 'ARTIST',
  '©grp': 'GROUPING',
  '©day': 'DATE',
};
