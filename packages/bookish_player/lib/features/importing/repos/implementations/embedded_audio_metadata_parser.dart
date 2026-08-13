import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'embedded_audio_metadata.dart';
import 'embedded_audio_metadata_artwork.dart';
import 'embedded_audio_metadata_binary.dart';
import 'embedded_audio_metadata_id3.dart';
import 'embedded_audio_metadata_ogg_artwork.dart';
import 'embedded_audio_metadata_text_formats.dart';
import 'embedded_chapter_metadata.dart';
import 'embedded_text_metadata.dart';

abstract class EmbeddedAudioMetadataParser {
  const EmbeddedAudioMetadataParser(this.file, this.fileLength);

  factory EmbeddedAudioMetadataParser.forFile(RandomAccessFile file) {
    final length = file.lengthSync();
    final signature = readMetadataBytes(file, 0, length < 12 ? length : 12);

    if (_containsAscii(signature, 'ID3')) {
      return _Id3MetadataParser(file, length);
    }
    if (_containsAscii(signature, 'fLaC')) {
      return _FlacMetadataParser(file, length);
    }
    if (_containsAscii(signature, 'ftyp', offset: 4)) {
      return _Mp4MetadataParser(file, length);
    }
    if (_containsAscii(signature, 'RIFF') &&
        _containsAscii(signature, 'WAVE', offset: 8)) {
      return _WaveMetadataParser(file, length);
    }
    if (_containsAscii(signature, 'OggS')) {
      return _OggMetadataParser(file, length);
    }
    return _UnsupportedMetadataParser(file, length);
  }

  final RandomAccessFile file;
  final int fileLength;

  EmbeddedTextMetadata readText();

  EmbeddedArtwork? readArtwork();

  List<EmbeddedChapterMetadata> readChapters() => const [];
}

class _Id3MetadataParser extends EmbeddedAudioMetadataParser {
  const _Id3MetadataParser(super.file, super.fileLength);

  Id3Metadata? get _metadata => readId3Metadata(file, 0);

  @override
  EmbeddedTextMetadata readText() =>
      _metadata?.text ?? const EmbeddedTextMetadata();

  @override
  EmbeddedArtwork? readArtwork() => _metadata?.artwork;

  @override
  List<EmbeddedChapterMetadata> readChapters() =>
      _metadata?.chapters ?? const [];
}

class _FlacMetadataParser extends EmbeddedAudioMetadataParser {
  const _FlacMetadataParser(super.file, super.fileLength);

  @override
  EmbeddedTextMetadata readText() => readFlacTextMetadata(file, fileLength);

  @override
  EmbeddedArtwork? readArtwork() => readFlacArtwork(file, fileLength);
}

class _Mp4MetadataParser extends EmbeddedAudioMetadataParser {
  const _Mp4MetadataParser(super.file, super.fileLength);

  @override
  EmbeddedTextMetadata readText() => readMp4TextMetadata(file, fileLength);

  @override
  EmbeddedArtwork? readArtwork() => scanMp4Artwork(file, 0, fileLength, 0);
}

class _WaveMetadataParser extends EmbeddedAudioMetadataParser {
  const _WaveMetadataParser(super.file, super.fileLength);

  @override
  EmbeddedTextMetadata readText() => readWaveTextMetadata(file, fileLength);

  @override
  EmbeddedArtwork? readArtwork() => readWaveId3Artwork(file, fileLength);
}

class _OggMetadataParser extends EmbeddedAudioMetadataParser {
  const _OggMetadataParser(super.file, super.fileLength);

  @override
  EmbeddedTextMetadata readText() => readOggTextMetadata(file, fileLength);

  @override
  EmbeddedArtwork? readArtwork() => readOggArtwork(file, fileLength);
}

class _UnsupportedMetadataParser extends EmbeddedAudioMetadataParser {
  const _UnsupportedMetadataParser(super.file, super.fileLength);

  @override
  EmbeddedTextMetadata readText() => const EmbeddedTextMetadata();

  @override
  EmbeddedArtwork? readArtwork() => null;
}

bool _containsAscii(Uint8List bytes, String value, {int offset = 0}) {
  final end = offset + value.length;
  if (offset < 0 || end > bytes.length) {
    return false;
  }

  return ascii.decode(bytes.sublist(offset, end), allowInvalid: true) == value;
}
