import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bookish_player/features/importing/data/metadata_audiobook_artwork_extractor.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('extracts embedded MP4/M4B cover artwork to durable storage', () async {
    final temporary = await Directory.systemTemp.createTemp(
      'bookish_artwork_test_',
    );
    final book = File('${temporary.path}/book.m4b');
    final covers = '${temporary.path}/covers';
    final imageBytes = base64Decode(
      'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNk+A8AAQUBAScY42YAAAAASUVORK5CYII=',
    );

    try {
      final data = _box('data', [
        0,
        0,
        0,
        13, // iTunes PNG data type.
        0,
        0,
        0,
        0, // locale.
        ...imageBytes,
      ]);
      final cover = _box('covr', data);
      final metadata = _box('meta', [0, 0, 0, 0, ..._box('ilst', cover)]);
      final movie = _box('moov', _box('udta', metadata));
      final fileType = _box('ftyp', ascii.encode('M4B 0000M4B '));
      await book.writeAsBytes([...fileType, ...movie]);

      final artworkPath = extractArtworkToDirectory(book.path, covers);

      expect(artworkPath, isNotNull);
      expect(artworkPath, endsWith('.png'));
      expect(File(artworkPath!).readAsBytesSync(), imageBytes);
    } finally {
      await temporary.delete(recursive: true);
    }
  });

  test('extracts ID3 APIC cover artwork without a metadata plugin', () async {
    final temporary = await Directory.systemTemp.createTemp(
      'bookish_id3_artwork_test_',
    );
    final book = File('${temporary.path}/book.mp3');
    final covers = '${temporary.path}/covers';
    final imageBytes = base64Decode(
      'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNk+A8AAQUBAScY42YAAAAASUVORK5CYII=',
    );

    try {
      final picturePayload = <int>[
        0,
        ...latin1.encode('image/png'),
        0,
        3,
        0,
        ...imageBytes,
      ];
      final frame = <int>[
        ...ascii.encode('APIC'),
        ..._u32(picturePayload.length),
        0,
        0,
        ...picturePayload,
      ];
      await book.writeAsBytes([
        ...ascii.encode('ID3'),
        3,
        0,
        0,
        ..._synchsafe(frame.length),
        ...frame,
      ]);

      final artworkPath = extractArtworkToDirectory(book.path, covers);

      expect(artworkPath, isNotNull);
      expect(artworkPath, endsWith('.png'));
      expect(File(artworkPath!).readAsBytesSync(), imageBytes);
    } finally {
      await temporary.delete(recursive: true);
    }
  });

  test('extracts Opus comment cover artwork without a metadata plugin', () async {
    final temporary = await Directory.systemTemp.createTemp(
      'bookish_opus_artwork_test_',
    );
    final book = File('${temporary.path}/book.opus');
    final covers = '${temporary.path}/covers';
    final imageBytes = base64Decode(
      'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNk+A8AAQUBAScY42YAAAAASUVORK5CYII=',
    );

    try {
      final comment = utf8.encode('COVERART=${base64Encode(imageBytes)}');
      final packet = <int>[
        ...ascii.encode('OpusTags'),
        ..._u32le(0),
        ..._u32le(1),
        ..._u32le(comment.length),
        ...comment,
      ];
      await book.writeAsBytes([
        ...ascii.encode('OggS'),
        0,
        0,
        ...List.filled(20, 0),
        1,
        packet.length,
        ...packet,
      ]);

      final artworkPath = extractArtworkToDirectory(book.path, covers);

      expect(artworkPath, isNotNull);
      expect(artworkPath, endsWith('.png'));
      expect(File(artworkPath!).readAsBytesSync(), imageBytes);
    } finally {
      await temporary.delete(recursive: true);
    }
  });
}

List<int> _box(String type, List<int> payload) => [
  ..._u32(payload.length + 8),
  ...ascii.encode(type),
  ...payload,
];

List<int> _u32(int value) {
  final data = ByteData(4)..setUint32(0, value);
  return data.buffer.asUint8List();
}

List<int> _synchsafe(int value) => [
  (value >> 21) & 0x7f,
  (value >> 14) & 0x7f,
  (value >> 7) & 0x7f,
  value & 0x7f,
];

List<int> _u32le(int value) {
  final data = ByteData(4)..setUint32(0, value, Endian.little);
  return data.buffer.asUint8List();
}
