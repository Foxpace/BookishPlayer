import 'dart:io';
import 'dart:isolate';

import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../domain/audiobook_artwork_extractor.dart';
import 'embedded_audio_metadata_reader.dart';

@LazySingleton(as: AudiobookArtworkExtractor)
class MetadataAudiobookArtworkExtractor implements AudiobookArtworkExtractor {
  @override
  Future<String?> extract(String audioFilePath) async {
    final support = await getApplicationSupportDirectory();
    final coversDirectory = p.join(support.path, 'covers');
    return Isolate.run(
      () => extractArtworkToDirectory(audioFilePath, coversDirectory),
    );
  }
}

/// Public for focused parser tests; app code uses [AudiobookArtworkExtractor].
String? extractArtworkToDirectory(
  String audioFilePath,
  String coversDirectory,
) {
  try {
    final artwork = readEmbeddedArtwork(File(audioFilePath));
    if (artwork == null || artwork.bytes.isEmpty) {
      return null;
    }

    final directory = Directory(coversDirectory)..createSync(recursive: true);
    final extension = _extensionForMimeType(artwork.mimeType);
    final filename = '${p.basenameWithoutExtension(audioFilePath)}$extension';
    final output = File(p.join(directory.path, filename));
    output.writeAsBytesSync(artwork.bytes, flush: true);
    return output.path;
  } catch (_) {
    // Unsupported/corrupt tags must not prevent importing playable audio.
    return null;
  }
}

String _extensionForMimeType(String mimeType) {
  final normalized = mimeType.toLowerCase();
  if (normalized.contains('png')) {
    return '.png';
  }
  if (normalized.contains('webp')) {
    return '.webp';
  }
  if (normalized.contains('gif')) {
    return '.gif';
  }
  return '.jpg';
}
