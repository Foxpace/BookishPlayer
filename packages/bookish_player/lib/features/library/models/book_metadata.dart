import 'package:freezed_annotation/freezed_annotation.dart';

import 'audio_chapter.dart';
import 'audiobook.dart';

import 'audiobook_metadata_copying.dart';
part 'book_metadata.freezed.dart';
part 'book_metadata.g.dart';

@freezed
abstract class BookMetadata with _$BookMetadata {
  const factory BookMetadata({
    required String id,
    required String fingerprint,
    required String title,
    required int durationMs,
    required DateTime createdAt,

    String? activeBookId,
    @Default('') String author,
    @Default('') String series,
    @Default('') String narrator,
    int? year,
    @Default('Imported') String folder,
    double? seriesPosition,
    DateTime? completedAt,

    String? artworkPath,
    @Default(false) bool artworkScanned,
    @Default(<AudioChapter>[]) List<AudioChapter> chapters,
  }) = _BookMetadata;

  factory BookMetadata.fromJson(Map<String, dynamic> json) =>
      _$BookMetadataFromJson(json);
}

String bookMetadataFingerprint({
  required String title,
  required String author,
  required int durationMs,
}) => '${_normalized(title)}|${_normalized(author)}|$durationMs';

BookMetadata metadataForBook(
  Audiobook book, {
  String? metadataId,
  DateTime? createdAt,
}) => book.toBookMetadata(metadataId: metadataId, createdAt: createdAt);

String _normalized(String value) =>
    value.trim().toLowerCase().replaceAll(RegExp(r'\s+'), ' ');
