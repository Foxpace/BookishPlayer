part of 'embedded_audio_metadata_reader.dart';

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
  return (artwork: artwork, chapters: chapters, text: _metadataFromTags(text));
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
