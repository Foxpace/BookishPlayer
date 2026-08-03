import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'embedded_audio_metadata_reader.freezed.dart';
part 'embedded_audio_metadata_id3.dart';
part 'embedded_audio_metadata_text_formats.dart';
part 'embedded_audio_metadata_artwork.dart';
part 'embedded_audio_metadata_binary.dart';

@freezed
abstract class EmbeddedArtwork with _$EmbeddedArtwork {
  const factory EmbeddedArtwork({
    required Uint8List bytes,
    required String mimeType,
  }) = _EmbeddedArtwork;
}

@freezed
abstract class EmbeddedChapterMetadata with _$EmbeddedChapterMetadata {
  const factory EmbeddedChapterMetadata({
    required String title,
    required int startMs,
  }) = _EmbeddedChapterMetadata;
}

@freezed
abstract class EmbeddedTextMetadata with _$EmbeddedTextMetadata {
  const factory EmbeddedTextMetadata({
    String? title,
    String? author,
    String? series,
    String? narrator,
    int? year,
  }) = _EmbeddedTextMetadata;
}

EmbeddedTextMetadata readEmbeddedTextMetadata(File source) {
  RandomAccessFile? file;
  try {
    file = source.openSync();
    final length = file.lengthSync();
    if (length < 4) {
      return const EmbeddedTextMetadata();
    }
    final signature = _readAt(file, 0, length < 12 ? length : 12);
    if (signature.length >= 3 &&
        ascii.decode(signature.sublist(0, 3)) == 'ID3') {
      return _readId3(file, 0)?.text ?? const EmbeddedTextMetadata();
    }
    if (signature.length >= 4 &&
        ascii.decode(signature.sublist(0, 4)) == 'fLaC') {
      return _readFlacTextMetadata(file, length);
    }
    if (signature.length >= 12 &&
        ascii.decode(signature.sublist(4, 8)) == 'ftyp') {
      return _readMp4TextMetadata(file, length);
    }
    if (signature.length >= 12 &&
        ascii.decode(signature.sublist(0, 4)) == 'RIFF' &&
        ascii.decode(signature.sublist(8, 12)) == 'WAVE') {
      return _readWaveTextMetadata(file, length);
    }
    if (signature.length >= 4 &&
        ascii.decode(signature.sublist(0, 4)) == 'OggS') {
      return _readOggTextMetadata(file, length);
    }
  } catch (_) {
    return const EmbeddedTextMetadata();
  } finally {
    file?.closeSync();
  }
  return const EmbeddedTextMetadata();
}

EmbeddedArtwork? readEmbeddedArtwork(File source) {
  RandomAccessFile? file;
  try {
    file = source.openSync();
    final length = file.lengthSync();
    if (length < 4) {
      return null;
    }
    final signature = _readAt(file, 0, length < 12 ? length : 12);
    if (signature.length >= 3 &&
        ascii.decode(signature.sublist(0, 3)) == 'ID3') {
      return _readId3(file, 0)?.artwork;
    }
    if (signature.length >= 4 &&
        ascii.decode(signature.sublist(0, 4)) == 'fLaC') {
      return _readFlacArtwork(file, length);
    }
    if (signature.length >= 12 &&
        ascii.decode(signature.sublist(4, 8)) == 'ftyp') {
      return _scanMp4Artwork(file, 0, length, 0);
    }
    if (signature.length >= 12 &&
        ascii.decode(signature.sublist(0, 4)) == 'RIFF' &&
        ascii.decode(signature.sublist(8, 12)) == 'WAVE') {
      return _readWaveId3Artwork(file, length);
    }
    if (signature.length >= 4 &&
        ascii.decode(signature.sublist(0, 4)) == 'OggS') {
      return _readOggArtwork(file, length);
    }
    return null;
  } catch (_) {
    return null;
  } finally {
    file?.closeSync();
  }
}

List<EmbeddedChapterMetadata> readEmbeddedChapters(File source) {
  RandomAccessFile? file;
  try {
    file = source.openSync();
    final header = _readAt(file, 0, 3);
    if (header.length != 3 || ascii.decode(header) != 'ID3') {
      return const [];
    }
    return _readId3(file, 0)?.chapters ?? const [];
  } catch (_) {
    return const [];
  } finally {
    file?.closeSync();
  }
}
