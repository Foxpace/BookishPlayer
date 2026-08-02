import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'embedded_audio_metadata_reader.freezed.dart';

@freezed
abstract class EmbeddedArtwork with _$EmbeddedArtwork {
  const factory EmbeddedArtwork({
    required Uint8List bytes,
    required String mimeType,
  }) = _EmbeddedArtwork;
}

@freezed
abstract class EmbeddedChapterMetadata with _$EmbeddedChapterMetadata {
  const factory EmbeddedChapterMetadata({
    required String title,
    required int startMs,
  }) = _EmbeddedChapterMetadata;
}

@freezed
abstract class EmbeddedTextMetadata with _$EmbeddedTextMetadata {
  const factory EmbeddedTextMetadata({
    String? title,
    String? author,
    String? series,
    String? narrator,
    int? year,
  }) = _EmbeddedTextMetadata;
}

EmbeddedTextMetadata readEmbeddedTextMetadata(File source) {
  RandomAccessFile? file;
  try {
    file = source.openSync();
    final length = file.lengthSync();
    if (length < 4) {
      return const EmbeddedTextMetadata();
    }
    final signature = _readAt(file, 0, length < 12 ? length : 12);
    if (signature.length >= 3 &&
        ascii.decode(signature.sublist(0, 3)) == 'ID3') {
      return _readId3(file, 0)?.text ?? const EmbeddedTextMetadata();
    }
    if (signature.length >= 4 &&
        ascii.decode(signature.sublist(0, 4)) == 'fLaC') {
      return _readFlacTextMetadata(file, length);
    }
    if (signature.length >= 12 &&
        ascii.decode(signature.sublist(4, 8)) == 'ftyp') {
      return _readMp4TextMetadata(file, length);
    }
    if (signature.length >= 12 &&
        ascii.decode(signature.sublist(0, 4)) == 'RIFF' &&
        ascii.decode(signature.sublist(8, 12)) == 'WAVE') {
      return _readWaveTextMetadata(file, length);
    }
    if (signature.length >= 4 &&
        ascii.decode(signature.sublist(0, 4)) == 'OggS') {
      return _readOggTextMetadata(file, length);
    }
  } catch (_) {
    return const EmbeddedTextMetadata();
  } finally {
    file?.closeSync();
  }
  return const EmbeddedTextMetadata();
}

EmbeddedArtwork? readEmbeddedArtwork(File source) {
  RandomAccessFile? file;
  try {
    file = source.openSync();
    final length = file.lengthSync();
    if (length < 4) {
      return null;
    }
    final signature = _readAt(file, 0, length < 12 ? length : 12);
    if (signature.length >= 3 &&
        ascii.decode(signature.sublist(0, 3)) == 'ID3') {
      return _readId3(file, 0)?.artwork;
    }
    if (signature.length >= 4 &&
        ascii.decode(signature.sublist(0, 4)) == 'fLaC') {
      return _readFlacArtwork(file, length);
    }
    if (signature.length >= 12 &&
        ascii.decode(signature.sublist(4, 8)) == 'ftyp') {
      return _scanMp4Artwork(file, 0, length, 0);
    }
    if (signature.length >= 12 &&
        ascii.decode(signature.sublist(0, 4)) == 'RIFF' &&
        ascii.decode(signature.sublist(8, 12)) == 'WAVE') {
      return _readWaveId3Artwork(file, length);
    }
    if (signature.length >= 4 &&
        ascii.decode(signature.sublist(0, 4)) == 'OggS') {
      return _readOggArtwork(file, length);
    }
    return null;
  } catch (_) {
    return null;
  } finally {
    file?.closeSync();
  }
}

List<EmbeddedChapterMetadata> readEmbeddedChapters(File source) {
  RandomAccessFile? file;
  try {
    file = source.openSync();
    final header = _readAt(file, 0, 3);
    if (header.length != 3 || ascii.decode(header) != 'ID3') {
      return const [];
    }
    return _readId3(file, 0)?.chapters ?? const [];
  } catch (_) {
    return const [];
  } finally {
    file?.closeSync();
  }
}

_Id3Metadata? _readId3(RandomAccessFile file, int offset) {
  final header = _readAt(file, offset, 10);
  if (header.length != 10 || ascii.decode(header.sublist(0, 3)) != 'ID3') {
    return null;
  }
  final version = header[3];
  if (version < 2 || version > 4) {
    return null;
  }
  final tagSize = _synchsafe(header, 6);
  if (tagSize <= 0 || tagSize > 64 * 1024 * 1024) {
    return null;
  }
  final bytes = _readAt(file, offset + 10, tagSize);
  var cursor = 0;
  EmbeddedArtwork? artwork;
  final chapters = <EmbeddedChapterMetadata>[];
  final text = <String, String>{};
  while (cursor + (version == 2 ? 6 : 10) <= bytes.length) {
    final idLength = version == 2 ? 3 : 4;
    final id = ascii.decode(
      bytes.sublist(cursor, cursor + idLength),
      allowInvalid: true,
    );
    if (id.codeUnits.every((value) => value == 0)) {
      break;
    }
    final size = version == 2
        ? (bytes[cursor + 3] << 16) |
              (bytes[cursor + 4] << 8) |
              bytes[cursor + 5]
        : version == 4
        ? _synchsafe(bytes, cursor + 4)
        : _u32(bytes, cursor + 4);
    final payloadStart = cursor + (version == 2 ? 6 : 10);
    if (size <= 0 || payloadStart + size > bytes.length) {
      break;
    }
    final payload = Uint8List.sublistView(
      bytes,
      payloadStart,
      payloadStart + size,
    );
    if (artwork == null && (id == 'APIC' || id == 'PIC')) {
      artwork = _decodeId3Artwork(payload, version);
    } else if (id == 'CHAP') {
      final chapter = _decodeId3Chapter(payload, version);
      if (chapter != null) {
        chapters.add(chapter);
      }
    } else if (_id3TextFrames.containsKey(id)) {
      final value = _cleanText(_decodeText(payload));
      if (value != null) {
        text.putIfAbsent(_id3TextFrames[id]!, () => value);
      }
    } else if (id == 'TXXX' || id == 'TXX') {
      final entry = _decodeId3UserText(payload);
      if (entry != null) {
        text.putIfAbsent(entry.key, () => entry.value);
      }
    }
    cursor = payloadStart + size;
  }
  chapters.sort((a, b) => a.startMs.compareTo(b.startMs));
  return _Id3Metadata(
    artwork: artwork,
    chapters: chapters,
    text: _metadataFromTags(text),
  );
}

MapEntry<String, String>? _decodeId3UserText(Uint8List bytes) {
  if (bytes.length < 3) {
    return null;
  }
  final encoding = bytes.first;
  final end = _terminatedTextEnd(bytes, 1, encoding);
  if (end < 0) {
    return null;
  }
  final terminatorLength = encoding == 1 || encoding == 2 ? 2 : 1;
  final description = _cleanText(
    _decodeText([encoding, ...bytes.sublist(1, end)]),
  );
  final valueStart = end + terminatorLength;
  if (description == null || valueStart >= bytes.length) {
    return null;
  }
  final value = _cleanText(
    _decodeText([encoding, ...bytes.sublist(valueStart)]),
  );
  if (value == null) {
    return null;
  }
  return MapEntry(description.toUpperCase().replaceAll(' ', '_'), value);
}

EmbeddedArtwork? _decodeId3Artwork(Uint8List bytes, int version) {
  if (bytes.length < 5) {
    return null;
  }
  final encoding = bytes[0];
  var cursor = 1;
  String mimeType;
  if (version == 2) {
    mimeType = switch (ascii.decode(bytes.sublist(1, 4)).toUpperCase()) {
      'PNG' => 'image/png',
      'GIF' => 'image/gif',
      _ => 'image/jpeg',
    };
    cursor = 4;
  } else {
    final mimeEnd = _zeroIndex(bytes, cursor);
    if (mimeEnd < 0) {
      return null;
    }
    mimeType = latin1.decode(bytes.sublist(cursor, mimeEnd));
    cursor = mimeEnd + 1;
  }
  if (cursor >= bytes.length) {
    return null;
  }
  cursor++; // Picture type.
  final descriptionEnd = _terminatedTextEnd(bytes, cursor, encoding);
  if (descriptionEnd < 0) {
    return null;
  }
  cursor = descriptionEnd + (encoding == 1 || encoding == 2 ? 2 : 1);
  if (cursor >= bytes.length) {
    return null;
  }
  final image = Uint8List.fromList(bytes.sublist(cursor));
  return EmbeddedArtwork(bytes: image, mimeType: _imageMime(image, mimeType));
}

EmbeddedChapterMetadata? _decodeId3Chapter(Uint8List bytes, int version) {
  final idEnd = _zeroIndex(bytes, 0);
  if (idEnd < 0 || idEnd + 17 > bytes.length) {
    return null;
  }
  final startMs = _u32(bytes, idEnd + 1);
  final title = _readId3ChapterTitle(bytes, idEnd + 17, version);
  return EmbeddedChapterMetadata(
    title: title?.trim().isNotEmpty == true ? title!.trim() : 'Chapter',
    startMs: startMs,
  );
}

String? _readId3ChapterTitle(Uint8List bytes, int start, int version) {
  var cursor = start;
  while (cursor + (version == 2 ? 6 : 10) <= bytes.length) {
    final idLength = version == 2 ? 3 : 4;
    final id = ascii.decode(
      bytes.sublist(cursor, cursor + idLength),
      allowInvalid: true,
    );
    final size = version == 2
        ? (bytes[cursor + 3] << 16) |
              (bytes[cursor + 4] << 8) |
              bytes[cursor + 5]
        : version == 4
        ? _synchsafe(bytes, cursor + 4)
        : _u32(bytes, cursor + 4);
    final payloadStart = cursor + (version == 2 ? 6 : 10);
    if (size <= 0 || payloadStart + size > bytes.length) {
      return null;
    }
    if ((id == 'TIT2' || id == 'TT2') && size > 1) {
      return _decodeText(bytes.sublist(payloadStart, payloadStart + size));
    }
    cursor = payloadStart + size;
  }
  return null;
}

String _decodeText(List<int> bytes) {
  if (bytes.isEmpty) {
    return '';
  }
  final encoding = bytes.first;
  final payload = bytes.sublist(1);
  if (encoding == 0) {
    return latin1.decode(payload).replaceAll('\u0000', '');
  }
  if (encoding == 3) {
    return utf8.decode(payload, allowMalformed: true).replaceAll('\u0000', '');
  }
  if (payload.length < 2) {
    return '';
  }
  final littleEndian =
      encoding == 1 && payload[0] == 0xff && payload[1] == 0xfe;
  final start = encoding == 1 ? 2 : 0;
  final codes = <int>[];
  for (var index = start; index + 1 < payload.length; index += 2) {
    codes.add(
      littleEndian
          ? payload[index] | (payload[index + 1] << 8)
          : (payload[index] << 8) | payload[index + 1],
    );
  }
  return String.fromCharCodes(codes.where((code) => code != 0));
}

EmbeddedTextMetadata _metadataFromTags(Map<String, String> tags) {
  String? first(List<String> keys) {
    for (final key in keys) {
      final value = _cleanText(tags[key]);
      if (value != null) {
        return value;
      }
    }
    return null;
  }

  final rawYear = first(const ['YEAR', 'DATE', 'ORIGINALDATE']);
  final yearMatch = rawYear == null
      ? null
      : RegExp(r'(?<!\d)(1\d{3}|2\d{3})(?!\d)').firstMatch(rawYear);
  final year = int.tryParse(yearMatch?.group(1) ?? '');
  return EmbeddedTextMetadata(
    title: first(const ['TITLE']),
    author: first(const ['AUTHOR', 'ALBUMARTIST', 'ALBUM_ARTIST', 'ARTIST']),
    series: first(const ['SERIES', 'SERIES_NAME', 'GROUPING']),
    narrator: first(const ['NARRATOR', 'NARRATED_BY']),
    year: year != null && year >= 1000 && year <= 2999 ? year : null,
  );
}

String? _cleanText(String? value) {
  final cleaned = value?.replaceAll('\u0000', '').trim();
  return cleaned == null || cleaned.isEmpty ? null : cleaned;
}

const _id3TextFrames = <String, String>{
  'TIT2': 'TITLE',
  'TT2': 'TITLE',
  'TPE1': 'ARTIST',
  'TP1': 'ARTIST',
  'TPE2': 'ALBUMARTIST',
  'TP2': 'ALBUMARTIST',
  'TIT1': 'GROUPING',
  'TT1': 'GROUPING',
  'TDRC': 'DATE',
  'TYER': 'YEAR',
  'TYE': 'YEAR',
};

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
  return _Box(
    latin1.decode(header.sublist(4, 8), allowInvalid: true),
    offset + headerSize,
    offset + size,
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

class _Box {
  const _Box(this.type, this.payloadStart, this.end);

  final String type;
  final int payloadStart;
  final int end;
}

class _Id3Metadata {
  const _Id3Metadata({
    required this.artwork,
    required this.chapters,
    required this.text,
  });

  final EmbeddedArtwork? artwork;
  final List<EmbeddedChapterMetadata> chapters;
  final EmbeddedTextMetadata text;
}
