import 'package:freezed_annotation/freezed_annotation.dart';

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

enum ListeningStatus { wantToListen, notStarted, inProgress, finished }

extension AudiobookProgress on Audiobook {
  ListeningStatus get listeningStatus {
    if (completedAt != null) {
      return ListeningStatus.finished;
    }
    if (statusOverride case final override?) {
      return override;
    }
    if (positionMs <= 0) {
      return ListeningStatus.notStarted;
    }
    if (durationMs > 0 && positionMs >= durationMs - 30000) {
      return ListeningStatus.finished;
    }
    return ListeningStatus.inProgress;
  }

  bool get isFinished => listeningStatus == ListeningStatus.finished;

  Duration get remainingDuration {
    final remainingMs = (durationMs - positionMs).clamp(0, durationMs);
    return Duration(milliseconds: remainingMs);
  }

  List<AudioTrack> get playableTracks =>
      tracks.isEmpty
            ? [
                AudioTrack(
                  id: id,
                  title: title,
                  filePath: filePath,
                  durationMs: durationMs,
                  order: 0,
                ),
              ]
            : [...tracks]
        ..sort((a, b) => a.order.compareTo(b.order));
}

@freezed
abstract class AudioTrack with _$AudioTrack {
  const factory AudioTrack({
    required String id,
    required String title,
    required String filePath,
    required int durationMs,
    required int order,
  }) = _AudioTrack;

  factory AudioTrack.fromJson(Map<String, dynamic> json) =>
      _$AudioTrackFromJson(json);
}

@freezed
abstract class AudioChapter with _$AudioChapter {
  const factory AudioChapter({required String title, required int startMs}) =
      _AudioChapter;

  factory AudioChapter.fromJson(Map<String, dynamic> json) =>
      _$AudioChapterFromJson(json);
}
