import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';
part 'embedded_audio_metadata.freezed.dart';

@freezed
abstract class EmbeddedArtwork with _$EmbeddedArtwork {
  const factory EmbeddedArtwork({
    required Uint8List bytes,
    required String mimeType,
  }) = _EmbeddedArtwork;
}
