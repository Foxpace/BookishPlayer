import 'package:freezed_annotation/freezed_annotation.dart';
part 'embedded_text_metadata.freezed.dart';

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
