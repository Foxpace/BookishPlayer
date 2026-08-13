import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'embedded_audio_metadata.dart';
import 'embedded_audio_metadata_binary.dart';
import 'embedded_audio_metadata_id3.dart';

EmbeddedArtwork? scanMp4Artwork(
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
    final box = readMetadataBox(file, offset, end);
    if (box == null) {
      break;
    }

    if (box.type == 'covr') {
      final artwork = _readMp4Cover(file, box.payloadStart, box.end);
      if (artwork != null) {
        return artwork;
      }
    }

    if (embeddedMp4Containers.contains(box.type)) {
      final childStart = box.payloadStart + (box.type == 'meta' ? 4 : 0);
      final artwork = scanMp4Artwork(file, childStart, box.end, depth + 1);
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
    final box = readMetadataBox(file, offset, end);
    if (box == null) {
      return null;
    }

    if (box.type == 'data' && box.end - box.payloadStart > 8) {
      final header = readMetadataBytes(file, box.payloadStart, 8);
      final length = box.end - box.payloadStart - 8;
      if (header.length != 8 || length <= 0 || length > 32 * 1024 * 1024) {
        return null;
      }

      final image = readMetadataBytes(file, box.payloadStart + 8, length);
      final type = readUint32(header, 0) & 0xffffff;
      final declared = switch (type) {
        13 => 'image/jpeg',
        14 => 'image/png',
        27 => 'image/bmp',
        _ => '',
      };

      return EmbeddedArtwork(
        bytes: image,
        mimeType: detectEmbeddedImageMime(image, declared),
      );
    }

    offset = box.end;
  }

  return null;
}

EmbeddedArtwork? readFlacArtwork(RandomAccessFile file, int fileLength) {
  var offset = 4;

  while (offset + 4 <= fileLength) {
    final header = readMetadataBytes(file, offset, 4);
    final isLast = header[0] & 0x80 != 0;
    final type = header[0] & 0x7f;
    final length = (header[1] << 16) | (header[2] << 8) | header[3];
    offset += 4;

    if (length < 0 || offset + length > fileLength) {
      return null;
    }

    if (type == 6 && length <= 32 * 1024 * 1024) {
      final picture = decodeFlacPicture(
        readMetadataBytes(file, offset, length),
      );
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

EmbeddedArtwork? decodeFlacPicture(Uint8List bytes) {
  if (bytes.length < 32) {
    return null;
  }

  var cursor = 4; // Picture type.
  final mimeLength = readUint32(bytes, cursor);
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

  final descriptionLength = readUint32(bytes, cursor);
  cursor += 4 + descriptionLength;

  if (cursor + 20 > bytes.length) {
    return null;
  }

  cursor += 16; // Width, height, depth and indexed-color count.
  final imageLength = readUint32(bytes, cursor);
  cursor += 4;

  if (imageLength <= 0 || imageLength > bytes.length - cursor) {
    return null;
  }

  final image = Uint8List.fromList(bytes.sublist(cursor, cursor + imageLength));

  return EmbeddedArtwork(
    bytes: image,
    mimeType: detectEmbeddedImageMime(image, mime),
  );
}

EmbeddedArtwork? readWaveId3Artwork(RandomAccessFile file, int fileLength) {
  var offset = 12;

  while (offset + 8 <= fileLength) {
    final header = readMetadataBytes(file, offset, 8);
    final type = ascii.decode(header.sublist(0, 4), allowInvalid: true);
    final length = readUint32LittleEndian(header, 4);
    final payloadStart = offset + 8;

    if (length < 0 || payloadStart + length > fileLength) {
      return null;
    }

    if (type.toLowerCase() == 'id3 ') {
      return readId3Metadata(file, payloadStart)?.artwork;
    }

    offset = payloadStart + length + (length.isOdd ? 1 : 0);
  }

  return null;
}
