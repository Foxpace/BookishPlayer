import 'package:path/path.dart' as p;

String audiobookTitleFromFilename(String filename) {
  final raw = p
      .basenameWithoutExtension(filename)
      .replaceAll(RegExp('[_-]+'), ' ')
      .trim();
  if (raw.isEmpty) {
    return 'Untitled audiobook';
  }
  return raw
      .split(RegExp(r'\s+'))
      .map(
        (word) => word.isEmpty
            ? word
            : '${word[0].toUpperCase()}${word.substring(1)}',
      )
      .join(' ');
}
