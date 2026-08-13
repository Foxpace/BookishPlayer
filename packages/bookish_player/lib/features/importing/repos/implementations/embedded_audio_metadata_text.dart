import 'embedded_text_metadata.dart';

EmbeddedTextMetadata embeddedTextMetadataFromTags(Map<String, String> tags) {
  String? first(List<String> keys) {
    for (final key in keys) {
      final value = cleanEmbeddedText(tags[key]);
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

String? cleanEmbeddedText(String? value) {
  final cleaned = value?.replaceAll('\u0000', '').trim();
  return cleaned == null || cleaned.isEmpty ? null : cleaned;
}
