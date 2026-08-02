import 'dart:io';

import 'package:injectable/injectable.dart';

import '../domain/audiobook_metadata_extractor.dart';
import 'embedded_audio_metadata_reader.dart';

@LazySingleton(as: AudiobookMetadataExtractor)
class EmbeddedAudiobookMetadataExtractor implements AudiobookMetadataExtractor {
  @override
  Future<ImportedAudiobookMetadata> extract(String audioFilePath) async {
    final metadata = readEmbeddedTextMetadata(File(audioFilePath));
    return ImportedAudiobookMetadata(
      title: metadata.title,
      author: metadata.author,
      series: metadata.series,
      narrator: metadata.narrator,
      year: metadata.year,
    );
  }
}
