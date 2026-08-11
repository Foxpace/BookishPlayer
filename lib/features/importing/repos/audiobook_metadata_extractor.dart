import 'package:freezed_annotation/freezed_annotation.dart';

part 'audiobook_metadata_extractor.freezed.dart';
part 'imported_audiobook_metadata.dart';

abstract interface class AudiobookMetadataExtractor {
  Future<ImportedAudiobookMetadata> extract(String audioFilePath);
}
