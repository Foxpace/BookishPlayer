import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bookish_player/features/importing/repos/implementations/embedded_metadata.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Embedded audio metadata reader', () {
    late Directory directory;

    setUp(() async {
      directory = await Directory.systemTemp.createTemp('bookish-metadata-');
    });

    tearDown(() => directory.delete(recursive: true));

    test(
      'Given the embedded audio metadata reader, When its behavior is exercised, Then reads conservative text metadata from ID3 tags',
      () async {
        // GIVEN
        final file = await _taggedId3Fixture(directory);

        // WHEN
        final metadata = readEmbeddedTextMetadata(file);

        // THEN
        expect(metadata.title, 'A Wizard of Earthsea');
        expect(metadata.author, 'Ursula K. Le Guin');
        expect(metadata.series, 'Earthsea');
        expect(metadata.narrator, 'Rob Inglis');
        expect(metadata.year, 1968);
      },
    );

    test(
      'Given the embedded audio metadata reader, When its behavior is exercised, Then does not infer metadata from missing or unrelated tags',
      () async {
        // GIVEN
        final file = await _unrelatedId3Fixture(directory);

        // WHEN
        final metadata = readEmbeddedTextMetadata(file);

        // THEN
        expect(metadata.title, isNull);
        expect(metadata.author, isNull);
        expect(metadata.series, isNull);
        expect(metadata.narrator, isNull);
        expect(metadata.year, isNull);
      },
    );

    test(
      'Given the embedded audio metadata reader, When its behavior is exercised, Then reads explicit metadata atoms from M4B files',
      () async {
        // GIVEN
        final file = await _taggedM4bFixture(directory);

        // WHEN
        final metadata = readEmbeddedTextMetadata(file);

        // THEN
        expect(metadata.title, 'The Left Hand of Darkness');
        expect(metadata.author, 'Ursula K. Le Guin');
        expect(metadata.series, 'Hainish Cycle');
        expect(metadata.narrator, 'George Guidall');
        expect(metadata.year, 1969);
      },
    );
  });
}

Future<File> _taggedId3Fixture(Directory directory) =>
    _writeId3Fixture(directory, [
      ..._textFrame('TIT2', 'A Wizard of Earthsea'),
      ..._textFrame('TPE2', 'Ursula K. Le Guin'),
      ..._userTextFrame('SERIES', 'Earthsea'),
      ..._userTextFrame('NARRATOR', 'Rob Inglis'),
      ..._textFrame('TDRC', '1968-01-01'),
    ], padding: 32);

Future<File> _unrelatedId3Fixture(Directory directory) => _writeId3Fixture(
  directory,
  [..._textFrame('TALB', 'An Album Name'), ..._textFrame('TDRC', 'not a year')],
);

Future<File> _writeId3Fixture(
  Directory directory,
  List<int> frames, {
  int padding = 0,
}) async {
  final file = File('${directory.path}/book.mp3');
  await file.writeAsBytes([
    ...ascii.encode('ID3'),
    3,
    0,
    0,
    ..._synchsafe(frames.length),
    ...frames,
    ...List<int>.filled(padding, 0),
  ]);
  return file;
}

Future<File> _taggedM4bFixture(Directory directory) async {
  final file = File('${directory.path}/book.m4b');
  final ilst = _box('ilst', [
    ..._mp4Item('©nam', 'The Left Hand of Darkness'),
    ..._mp4Item('aART', 'Ursula K. Le Guin'),
    ..._mp4Item('©grp', 'Hainish Cycle'),
    ..._mp4Item('©day', '1969'),
    ..._mp4Freeform('NARRATOR', 'George Guidall'),
  ]);
  await file.writeAsBytes([
    ..._box('ftyp', ascii.encode('M4B \u0000\u0000\u0000\u0000')),
    ..._box('moov', [
      ..._box('udta', [
        ..._box('meta', [0, 0, 0, 0, ...ilst]),
      ]),
    ]),
  ]);
  return file;
}

List<int> _textFrame(String id, String value) =>
    _frame(id, [3, ...utf8.encode(value)]);

List<int> _userTextFrame(String description, String value) =>
    _frame('TXXX', [3, ...utf8.encode(description), 0, ...utf8.encode(value)]);

List<int> _frame(String id, List<int> payload) => [
  ...ascii.encode(id),
  ..._u32(payload.length),
  0,
  0,
  ...payload,
];

List<int> _u32(int value) {
  final bytes = ByteData(4)..setUint32(0, value);
  return bytes.buffer.asUint8List();
}

List<int> _synchsafe(int value) => [
  (value >> 21) & 0x7f,
  (value >> 14) & 0x7f,
  (value >> 7) & 0x7f,
  value & 0x7f,
];

List<int> _mp4Item(String type, String value) =>
    _box(type, _box('data', [0, 0, 0, 1, 0, 0, 0, 0, ...utf8.encode(value)]));

List<int> _mp4Freeform(String name, String value) => _box('----', [
  ..._box('mean', [0, 0, 0, 0, ...utf8.encode('com.apple.iTunes')]),
  ..._box('name', [0, 0, 0, 0, ...utf8.encode(name)]),
  ..._box('data', [0, 0, 0, 1, 0, 0, 0, 0, ...utf8.encode(value)]),
]);

List<int> _box(String type, List<int> payload) => [
  ..._u32(payload.length + 8),
  ...latin1.encode(type),
  ...payload,
];
