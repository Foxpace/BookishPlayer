import 'dart:io';

import 'embedded_audio_metadata.dart';
import 'embedded_audio_metadata_parser.dart';
import 'embedded_chapter_metadata.dart';
import 'embedded_text_metadata.dart';

EmbeddedTextMetadata readEmbeddedTextMetadata(File source) {
  try {
    return _readMetadata(source, (parser) => parser.readText());
  } catch (_) {
    return const EmbeddedTextMetadata();
  }
}

EmbeddedArtwork? readEmbeddedArtwork(File source) {
  try {
    return _readMetadata(source, (parser) => parser.readArtwork());
  } catch (_) {
    return null;
  }
}

List<EmbeddedChapterMetadata> readEmbeddedChapters(File source) {
  try {
    return _readMetadata(source, (parser) => parser.readChapters());
  } catch (_) {
    return const [];
  }
}

T _readMetadata<T>(
  File source,
  T Function(EmbeddedAudioMetadataParser parser) read,
) {
  final file = source.openSync();
  try {
    return read(EmbeddedAudioMetadataParser.forFile(file));
  } finally {
    file.closeSync();
  }
}
