import 'package:bookish_player/features/importing/repos/audiobook_artwork_extractor.dart';

class FakeImportArtwork implements AudiobookArtworkExtractor {
  @override
  Future<String?> extract(String audioFilePath) async => null;
}
