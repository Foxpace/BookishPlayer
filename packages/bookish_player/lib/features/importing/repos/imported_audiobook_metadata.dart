part of 'audiobook_metadata_extractor.dart';

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
