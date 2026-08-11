import 'package:freezed_annotation/freezed_annotation.dart';

import 'listening_status.dart';
import 'audio_track.dart';
import 'audio_chapter.dart';
part 'audiobook.freezed.dart';
part 'audiobook.g.dart';

@freezed
abstract class Audiobook with _$Audiobook {
  const factory Audiobook({
    required String id,
    required String title,
    required String filePath,
    required int durationMs,
    required DateTime addedAt,

    @Default('') String metadataId,
    @Default('') String author,
    @Default('') String series,
    @Default('') String narrator,
    int? year,
    @Default('Imported') String folder,

    String? artworkPath,
    @Default(false) bool artworkScanned,

    @Default(0) int positionMs,
    DateTime? lastPlayedAt,
    @Default(1.0) double playbackSpeed,
    @Default(false) bool isFavorite,
    ListeningStatus? statusOverride,
    double? seriesPosition,
    DateTime? completedAt,

    @Default(<AudioTrack>[]) List<AudioTrack> tracks,
    @Default(<AudioChapter>[]) List<AudioChapter> chapters,
  }) = _Audiobook;
  factory Audiobook.fromJson(Map<String, dynamic> json) =>
      _$AudiobookFromJson(json);
}
