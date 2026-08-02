import 'package:freezed_annotation/freezed_annotation.dart';

part 'audiobook_metadata_extractor.freezed.dart';

@freezed
abstract class ImportedAudiobookMetadata with _$ImportedAudiobookMetadata {
  const factory ImportedAudiobookMetadata({
    String? title,
    String? author,
    String? series,
    String? narrator,
    int? year,
  }) = _ImportedAudiobookMetadata;
}

abstract interface class AudiobookMetadataExtractor {
  Future<ImportedAudiobookMetadata> extract(String audioFilePath);
}
