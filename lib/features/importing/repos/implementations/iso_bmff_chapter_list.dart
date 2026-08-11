import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import '../../../library/models/library_models.dart';
import 'iso_bmff_m4b_chapter_parser.dart';

typedef _DecodedChapterEntry = ({AudioChapter chapter, int nextCursor});

extension ChapterListReader on IsoBmffM4bChapterParser {
  Future<List<AudioChapter>> readChapterList(
    RandomAccessFile file,
    int start,
    int end,
  ) async {
    final length = end - start;
    if (length < 5 || length > 4 * 1024 * 1024) {
      return const [];
    }
    await file.setPosition(start);
    final bytes = Uint8List.fromList(await file.read(length));
    // Standard chpl has 4-byte full-box flags, 4 reserved bytes, then count.
    // Some encoders omit the reserved word, so support both layouts.
    return _decodeEntries(bytes, 8) ?? _decodeEntries(bytes, 4) ?? const [];
  }

  List<AudioChapter>? _decodeEntries(Uint8List bytes, int countOffset) {
    if (countOffset >= bytes.length) {
      return null;
    }
    final count = bytes[countOffset];
    if (count == 0 || count > 250) {
      return null;
    }

    var cursor = countOffset + 1;
    final chapters = <AudioChapter>[];

    for (var index = 0; index < count; index++) {
      final entry = _decodeEntry(bytes, cursor, index);
      if (entry == null) {
        return null;
      }

      chapters.add(entry.chapter);
      cursor = entry.nextCursor;
    }

    return _hasOrderedStarts(chapters) ? chapters : null;
  }

  _DecodedChapterEntry? _decodeEntry(Uint8List bytes, int cursor, int index) {
    if (cursor + 9 > bytes.length) {
      return null;
    }

    final startMs = _chapterUint64(bytes, cursor) ~/ 10000;
    final titleLengthOffset = cursor + 8;
    final titleLength = bytes[titleLengthOffset];
    final titleStart = titleLengthOffset + 1;
    final nextCursor = titleStart + titleLength;
    if (nextCursor > bytes.length) {
      return null;
    }

    final rawTitle = utf8
        .decode(bytes.sublist(titleStart, nextCursor), allowMalformed: true)
        .trim();
    final chapter = AudioChapter(
      title: rawTitle.isEmpty ? 'Chapter ${index + 1}' : rawTitle,
      startMs: startMs,
    );

    return (chapter: chapter, nextCursor: nextCursor);
  }

  bool _hasOrderedStarts(List<AudioChapter> chapters) {
    for (var index = 1; index < chapters.length; index++) {
      if (chapters[index].startMs < chapters[index - 1].startMs) {
        return false;
      }
    }

    return true;
  }
}

int _chapterUint64(List<int> bytes, int offset) =>
    ByteData.sublistView(Uint8List.fromList(bytes)).getUint64(offset);
