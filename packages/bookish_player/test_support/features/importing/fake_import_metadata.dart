import 'package:bookish_player/features/importing/repos/audiobook_metadata_extractor.dart';

class FakeImportMetadata implements AudiobookMetadataExtractor {
  const FakeImportMetadata(this.metadata);
  final ImportedAudiobookMetadata metadata;
  @override
  Future<ImportedAudiobookMetadata> extract(String audioFilePath) async =>
      metadata;
}
