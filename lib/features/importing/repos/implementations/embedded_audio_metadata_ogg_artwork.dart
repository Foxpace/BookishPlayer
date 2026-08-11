import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'embedded_audio_metadata.dart';
import 'embedded_audio_metadata_artwork.dart';
import 'embedded_audio_metadata_binary.dart';

EmbeddedArtwork? readOggArtwork(RandomAccessFile file, int fileLength) {
  var offset = 0;
  final packet = BytesBuilder(copy: false);

  while (offset + 27 <= fileLength && offset < 64 * 1024 * 1024) {
    final header = readMetadataBytes(file, offset, 27);
    if (ascii.decode(header.sublist(0, 4), allowInvalid: true) != 'OggS') {
      return null;
    }

    final segmentCount = header[26];
    final lacing = readMetadataBytes(file, offset + 27, segmentCount);
    final bodyLength = lacing.fold<int>(0, (total, value) => total + value);
    final bodyStart = offset + 27 + segmentCount;
    if (bodyStart + bodyLength > fileLength) {
      return null;
    }

    final body = readMetadataBytes(file, bodyStart, bodyLength);
    var bodyCursor = 0;

    for (final segmentLength in lacing) {
      packet.add(body.sublist(bodyCursor, bodyCursor + segmentLength));
      bodyCursor += segmentLength;

      if (segmentLength < 255) {
        final artwork = _artworkFromPacket(packet.takeBytes());
        if (artwork != null) {
          return artwork;
        }
      }
    }

    offset = bodyStart + bodyLength;
  }

  return null;
}

EmbeddedArtwork? _artworkFromPacket(Uint8List packet) {
  if (packet.length > 32 * 1024 * 1024) {
    return null;
  }

  return _decodeOggCommentArtwork(packet);
}

EmbeddedArtwork? _decodeOggCommentArtwork(Uint8List packet) {
  final start = _oggCommentStart(packet);
  if (start == null || start + 4 > packet.length) {
    return null;
  }

  var cursor = start;
  final vendorLength = readUint32LittleEndian(packet, cursor);
  cursor += 4 + vendorLength;
  if (cursor + 4 > packet.length) {
    return null;
  }

  final count = readUint32LittleEndian(packet, cursor);
  cursor += 4;
  final cover = _readOggCoverComments(packet, cursor, count);
  if (cover.artwork != null) {
    return cover.artwork;
  }

  final rawCover = cover.rawCover;
  if (rawCover == null) {
    return null;
  }

  try {
    return _decodeCoverArt(rawCover, cover.mimeType);
  } catch (_) {
    return null;
  }
}

int? _oggCommentStart(Uint8List packet) {
  final isVorbis =
      packet.length >= 7 &&
      packet[0] == 3 &&
      ascii.decode(packet.sublist(1, 7), allowInvalid: true) == 'vorbis';
  final isOpus =
      packet.length >= 8 &&
      ascii.decode(packet.sublist(0, 8), allowInvalid: true) == 'OpusTags';

  if (isVorbis == false && isOpus == false) {
    return null;
  }

  return isVorbis ? 7 : 8;
}

({EmbeddedArtwork? artwork, String? rawCover, String? mimeType})
_readOggCoverComments(Uint8List packet, int start, int count) {
  var cursor = start;
  String? rawCover;
  String? coverMime;

  for (var index = 0; index < count && cursor + 4 <= packet.length; index++) {
    final length = readUint32LittleEndian(packet, cursor);
    cursor += 4;

    if (length > packet.length - cursor) {
      return (artwork: null, rawCover: null, mimeType: null);
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
      return _decodeMetadataBlockPicture(value);
    }

    if (key == 'COVERART') {
      rawCover = value;
    } else if (key == 'COVERARTMIME') {
      coverMime = value;
    }
  }

  return (artwork: null, rawCover: rawCover, mimeType: coverMime);
}

({EmbeddedArtwork? artwork, String? rawCover, String? mimeType})
_decodeMetadataBlockPicture(String value) {
  try {
    return (
      artwork: decodeFlacPicture(base64.decode(value)),
      rawCover: null,
      mimeType: null,
    );
  } catch (_) {
    return (artwork: null, rawCover: null, mimeType: null);
  }
}

EmbeddedArtwork _decodeCoverArt(String rawCover, String? coverMime) {
  final image = base64.decode(rawCover);

  return EmbeddedArtwork(
    bytes: image,
    mimeType: detectEmbeddedImageMime(image, coverMime ?? ''),
  );
}
