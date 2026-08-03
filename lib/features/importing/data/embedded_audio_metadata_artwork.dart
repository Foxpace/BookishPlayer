part of 'embedded_audio_metadata_reader.dart';

EmbeddedArtwork? _scanMp4Artwork(
  RandomAccessFile file,
  int start,
  int end,
  int depth,
) {
  if (depth > 12) {
    return null;
  }
  var offset = start;
  while (offset + 8 <= end) {
    final box = _readBox(file, offset, end);
    if (box == null) {
      break;
    }
    if (box.type == 'covr') {
      final artwork = _readMp4Cover(file, box.payloadStart, box.end);
      if (artwork != null) {
        return artwork;
      }
    }
    if (_mp4Containers.contains(box.type)) {
      final childStart = box.payloadStart + (box.type == 'meta' ? 4 : 0);
      final artwork = _scanMp4Artwork(file, childStart, box.end, depth + 1);
      if (artwork != null) {
        return artwork;
      }
    }
    offset = box.end;
  }
  return null;
}

EmbeddedArtwork? _readMp4Cover(RandomAccessFile file, int start, int end) {
  var offset = start;
  while (offset + 8 <= end) {
    final box = _readBox(file, offset, end);
    if (box == null) {
      return null;
    }
    if (box.type == 'data' && box.end - box.payloadStart > 8) {
      final header = _readAt(file, box.payloadStart, 8);
      final length = box.end - box.payloadStart - 8;
      if (header.length != 8 || length <= 0 || length > 32 * 1024 * 1024) {
        return null;
      }
      final image = _readAt(file, box.payloadStart + 8, length);
      final type = _u32(header, 0) & 0xffffff;
      final declared = switch (type) {
        13 => 'image/jpeg',
        14 => 'image/png',
        27 => 'image/bmp',
        _ => '',
      };
      return EmbeddedArtwork(
        bytes: image,
        mimeType: _imageMime(image, declared),
      );
    }
    offset = box.end;
  }
  return null;
}

EmbeddedArtwork? _readFlacArtwork(RandomAccessFile file, int fileLength) {
  var offset = 4;
  while (offset + 4 <= fileLength) {
    final header = _readAt(file, offset, 4);
    final isLast = header[0] & 0x80 != 0;
    final type = header[0] & 0x7f;
    final length = (header[1] << 16) | (header[2] << 8) | header[3];
    offset += 4;
    if (length < 0 || offset + length > fileLength) {
      return null;
    }
    if (type == 6 && length <= 32 * 1024 * 1024) {
      final picture = _decodeFlacPicture(_readAt(file, offset, length));
      if (picture != null) {
        return picture;
      }
    }
    offset += length;
    if (isLast) {
      break;
    }
  }
  return null;
}

EmbeddedArtwork? _decodeFlacPicture(Uint8List bytes) {
  if (bytes.length < 32) {
    return null;
  }
  var cursor = 4; // Picture type.
  final mimeLength = _u32(bytes, cursor);
  cursor += 4;
  if (mimeLength > bytes.length - cursor) {
    return null;
  }
  final mime = utf8.decode(
    bytes.sublist(cursor, cursor + mimeLength),
    allowMalformed: true,
  );
  cursor += mimeLength;
  if (cursor + 4 > bytes.length) {
    return null;
  }
  final descriptionLength = _u32(bytes, cursor);
  cursor += 4 + descriptionLength;
  if (cursor + 20 > bytes.length) {
    return null;
  }
  cursor += 16; // Width, height, depth and indexed-color count.
  final imageLength = _u32(bytes, cursor);
  cursor += 4;
  if (imageLength <= 0 || imageLength > bytes.length - cursor) {
    return null;
  }
  final image = Uint8List.fromList(bytes.sublist(cursor, cursor + imageLength));
  return EmbeddedArtwork(bytes: image, mimeType: _imageMime(image, mime));
}

EmbeddedArtwork? _readWaveId3Artwork(RandomAccessFile file, int fileLength) {
  var offset = 12;
  while (offset + 8 <= fileLength) {
    final header = _readAt(file, offset, 8);
    final type = ascii.decode(header.sublist(0, 4), allowInvalid: true);
    final length = _u32le(header, 4);
    final payloadStart = offset + 8;
    if (length < 0 || payloadStart + length > fileLength) {
      return null;
    }
    if (type.toLowerCase() == 'id3 ') {
      return _readId3(file, payloadStart)?.artwork;
    }
    offset = payloadStart + length + (length.isOdd ? 1 : 0);
  }
  return null;
}

EmbeddedArtwork? _readOggArtwork(RandomAccessFile file, int fileLength) {
  var offset = 0;
  final packet = BytesBuilder(copy: false);
  while (offset + 27 <= fileLength && offset < 64 * 1024 * 1024) {
    final header = _readAt(file, offset, 27);
    if (ascii.decode(header.sublist(0, 4), allowInvalid: true) != 'OggS') {
      return null;
    }
    final segmentCount = header[26];
    final lacing = _readAt(file, offset + 27, segmentCount);
    final bodyLength = lacing.fold<int>(0, (total, value) => total + value);
    final bodyStart = offset + 27 + segmentCount;
    if (bodyStart + bodyLength > fileLength) {
      return null;
    }
    final body = _readAt(file, bodyStart, bodyLength);
    var bodyCursor = 0;
    for (final segmentLength in lacing) {
      packet.add(body.sublist(bodyCursor, bodyCursor + segmentLength));
      bodyCursor += segmentLength;
      if (segmentLength < 255) {
        final bytes = packet.takeBytes();
        if (bytes.length <= 32 * 1024 * 1024) {
          final artwork = _decodeOggCommentArtwork(bytes);
          if (artwork != null) {
            return artwork;
          }
        }
      }
    }
    offset = bodyStart + bodyLength;
  }
  return null;
}

EmbeddedArtwork? _decodeOggCommentArtwork(Uint8List packet) {
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
  var cursor = isVorbis ? 7 : 8;
  if (cursor + 4 > packet.length) {
    return null;
  }
  final vendorLength = _u32le(packet, cursor);
  cursor += 4 + vendorLength;
  if (cursor + 4 > packet.length) {
    return null;
  }
  final count = _u32le(packet, cursor);
  cursor += 4;
  String? rawCover;
  String? coverMime;
  for (var index = 0; index < count && cursor + 4 <= packet.length; index++) {
    final length = _u32le(packet, cursor);
    cursor += 4;
    if (length > packet.length - cursor) {
      return null;
    }
    final comment = utf8.decode(
      packet.sublist(cursor, cursor + length),
      allowMalformed: true,
    );
    cursor += length;
    final separator = comment.indexOf('=');
    if (separator < 0) {
      continue;
    }
    final key = comment.substring(0, separator).toUpperCase();
    final value = comment.substring(separator + 1);
    if (key == 'METADATA_BLOCK_PICTURE') {
      try {
        return _decodeFlacPicture(base64.decode(value));
      } catch (_) {
        return null;
      }
    }
    if (key == 'COVERART') {
      rawCover = value;
    } else if (key == 'COVERARTMIME') {
      coverMime = value;
    }
  }
  if (rawCover == null) {
    return null;
  }
  try {
    final image = base64.decode(rawCover);
    return EmbeddedArtwork(
      bytes: image,
      mimeType: _imageMime(image, coverMime ?? ''),
    );
  } catch (_) {
    return null;
  }
}
