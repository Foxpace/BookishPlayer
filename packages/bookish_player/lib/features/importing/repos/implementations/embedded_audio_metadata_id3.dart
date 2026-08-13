import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'embedded_audio_metadata.dart';
import 'embedded_audio_metadata_binary.dart';
import 'embedded_audio_metadata_text.dart';
import 'embedded_chapter_metadata.dart';

Id3Metadata? readId3Metadata(RandomAccessFile file, int offset) {
  final header = readMetadataBytes(file, offset, 10);
  final tag = _parseId3Header(header);
  if (tag == null) {
    return null;
  }

  final bytes = readMetadataBytes(file, offset + 10, tag.size);
  final frames = _readId3Frames(bytes, tag.version);
  frames.chapters.sort((a, b) => a.startMs.compareTo(b.startMs));

  return (
    artwork: frames.artwork,
    chapters: frames.chapters,
    text: embeddedTextMetadataFromTags(frames.text),
  );
}

({int version, int size})? _parseId3Header(Uint8List header) {
  if (header.length != 10 || ascii.decode(header.sublist(0, 3)) != 'ID3') {
    return null;
  }

  final version = header[3];
  if (version < 2 || version > 4) {
    return null;
  }

  final tagSize = decodeSynchsafeInteger(header, 6);
  if (tagSize <= 0 || tagSize > 64 * 1024 * 1024) {
    return null;
  }

  return (version: version, size: tagSize);
}

({
  EmbeddedArtwork? artwork,
  List<EmbeddedChapterMetadata> chapters,
  Map<String, String> text,
})
_readId3Frames(Uint8List bytes, int version) {
  var cursor = 0;
  EmbeddedArtwork? artwork;
  final chapters = <EmbeddedChapterMetadata>[];
  final text = <String, String>{};

  while (cursor + (version == 2 ? 6 : 10) <= bytes.length) {
    final frame = _readId3FrameHeader(bytes, cursor, version);
    if (frame == null) {
      break;
    }

    final payload = Uint8List.sublistView(
      bytes,
      frame.payloadStart,
      frame.payloadStart + frame.size,
    );
    final id = frame.id;

    if (artwork == null && (id == 'APIC' || id == 'PIC')) {
      artwork = _decodeId3Artwork(payload, version);
    } else if (id == 'CHAP') {
      final chapter = _decodeId3Chapter(payload, version);
      if (chapter != null) {
        chapters.add(chapter);
      }
    } else if (_id3TextFrames.containsKey(id)) {
      final value = cleanEmbeddedText(_decodeText(payload));
      final key = _id3TextFrames[id];
      if (value != null && key != null) {
        text.putIfAbsent(key, () => value);
      }
    } else if (id == 'TXXX' || id == 'TXX') {
      final entry = _decodeId3UserText(payload);
      if (entry != null) {
        text.putIfAbsent(entry.key, () => entry.value);
      }
    }

    cursor = frame.payloadStart + frame.size;
  }

  return (artwork: artwork, chapters: chapters, text: text);
}

({String id, int size, int payloadStart})? _readId3FrameHeader(
  Uint8List bytes,
  int cursor,
  int version,
) {
  final idLength = version == 2 ? 3 : 4;
  final id = ascii.decode(
    bytes.sublist(cursor, cursor + idLength),
    allowInvalid: true,
  );
  if (id.codeUnits.every((value) => value == 0)) {
    return null;
  }

  final size = version == 2
      ? (bytes[cursor + 3] << 16) | (bytes[cursor + 4] << 8) | bytes[cursor + 5]
      : version == 4
      ? decodeSynchsafeInteger(bytes, cursor + 4)
      : readUint32(bytes, cursor + 4);
  final payloadStart = cursor + (version == 2 ? 6 : 10);
  if (size <= 0 || payloadStart + size > bytes.length) {
    return null;
  }

  return (id: id, size: size, payloadStart: payloadStart);
}

MapEntry<String, String>? _decodeId3UserText(Uint8List bytes) {
  if (bytes.length < 3) {
    return null;
  }

  final encoding = bytes.first;
  final end = metadataTerminatedTextEnd(bytes, 1, encoding);
  if (end < 0) {
    return null;
  }

  final terminatorLength = encoding == 1 || encoding == 2 ? 2 : 1;
  final description = cleanEmbeddedText(
    _decodeText([encoding, ...bytes.sublist(1, end)]),
  );
  final valueStart = end + terminatorLength;
  if (description == null || valueStart >= bytes.length) {
    return null;
  }

  final value = cleanEmbeddedText(
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
    final mimeEnd = metadataZeroIndex(bytes, cursor);
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
  final descriptionEnd = metadataTerminatedTextEnd(bytes, cursor, encoding);
  if (descriptionEnd < 0) {
    return null;
  }

  cursor = descriptionEnd + (encoding == 1 || encoding == 2 ? 2 : 1);
  if (cursor >= bytes.length) {
    return null;
  }

  final image = Uint8List.fromList(bytes.sublist(cursor));
  return EmbeddedArtwork(
    bytes: image,
    mimeType: detectEmbeddedImageMime(image, mimeType),
  );
}

EmbeddedChapterMetadata? _decodeId3Chapter(Uint8List bytes, int version) {
  final idEnd = metadataZeroIndex(bytes, 0);
  if (idEnd < 0 || idEnd + 17 > bytes.length) {
    return null;
  }

  final startMs = readUint32(bytes, idEnd + 1);
  final title = _readId3ChapterTitle(bytes, idEnd + 17, version);
  final cleanTitle = title?.trim();

  return EmbeddedChapterMetadata(
    title: cleanTitle == null || cleanTitle.isEmpty ? 'Chapter' : cleanTitle,
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
        ? decodeSynchsafeInteger(bytes, cursor + 4)
        : readUint32(bytes, cursor + 4);
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
