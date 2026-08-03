part of 'iso_bmff_m4b_chapter_parser.dart';

extension _ChapterList on IsoBmffM4bChapterParser {
  Future<List<AudioChapter>> _readChapterList(
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
      if (cursor + 9 > bytes.length) {
        return null;
      }
      final startMs = _u64(bytes, cursor) ~/ 10000;
      cursor += 8;
      final titleLength = bytes[cursor++];
      if (cursor + titleLength > bytes.length) {
        return null;
      }
      final rawTitle = utf8
          .decode(
            bytes.sublist(cursor, cursor + titleLength),
            allowMalformed: true,
          )
          .trim();
      cursor += titleLength;
      chapters.add(
        AudioChapter(
          title: rawTitle.isEmpty ? 'Chapter ${index + 1}' : rawTitle,
          startMs: startMs,
        ),
      );
    }
    for (var index = 1; index < chapters.length; index++) {
      if (chapters[index].startMs < chapters[index - 1].startMs) {
        return null;
      }
    }
    return chapters;
  }
}
