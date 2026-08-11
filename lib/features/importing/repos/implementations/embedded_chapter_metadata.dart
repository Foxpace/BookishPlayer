import 'package:freezed_annotation/freezed_annotation.dart';
part 'embedded_chapter_metadata.freezed.dart';

@freezed
abstract class EmbeddedChapterMetadata with _$EmbeddedChapterMetadata {
  const factory EmbeddedChapterMetadata({
    required String title,
    required int startMs,
  }) = _EmbeddedChapterMetadata;
}
