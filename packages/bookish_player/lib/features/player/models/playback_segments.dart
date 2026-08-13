import 'package:audio_service/audio_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart' as p;

import '../../library/models/library_models.dart';

part 'playback_segments.freezed.dart';
part 'audiobook_playback_segments.dart';

typedef _ChapterRange = ({int index, String title, int start, int end});

@freezed
abstract class PlaybackSegment with _$PlaybackSegment {
  const factory PlaybackSegment({
    required String id,
    required AudioTrack track,
    required String title,
    required int globalStartMs,
    required int sourceStartMs,
    required int durationMs,
  }) = _PlaybackSegment;
}

List<PlaybackSegment> _fallbackSegments(List<AudioTrack> tracks) => [
  for (final track in tracks)
    PlaybackSegment(
      id: 'track-${track.id}',
      track: track,
      title: track.title,
      globalStartMs: 0,
      sourceStartMs: 0,
      durationMs: track.durationMs,
    ),
];

List<PlaybackSegment> _intersectingSegments(
  List<AudioTrack> tracks,
  List<_ChapterRange> ranges,
) {
  final segments = <PlaybackSegment>[];
  var trackStart = 0;

  for (final track in tracks) {
    final trackEnd = trackStart + track.durationMs;

    for (final chapter in ranges) {
      final segment = _intersectChapterWithTrack(
        chapter,
        track,
        trackStart,
        trackEnd,
      );
      if (segment != null) {
        segments.add(segment);
      }
    }

    trackStart = trackEnd;
  }

  return segments;
}

PlaybackSegment? _intersectChapterWithTrack(
  _ChapterRange chapter,
  AudioTrack track,
  int trackStart,
  int trackEnd,
) {
  final start = chapter.start > trackStart ? chapter.start : trackStart;
  final end = chapter.end < trackEnd ? chapter.end : trackEnd;
  if (end <= start) {
    return null;
  }

  return PlaybackSegment(
    id: 'chapter-${chapter.index}:${track.id}:$start',
    track: track,
    title: chapter.title,
    globalStartMs: start,
    sourceStartMs: start - trackStart,
    durationMs: end - start,
  );
}

List<_ChapterRange> _chapterRanges(
  Audiobook book,
  List<AudioTrack> tracks,
  int totalDurationMs,
) {
  final chapters = [...book.chapters]
    ..sort((a, b) => a.startMs.compareTo(b.startMs));
  if (chapters.isEmpty) {
    return _trackRanges(tracks);
  }

  final ranges = <_ChapterRange>[];
  for (var index = 0; index < chapters.length; index++) {
    final start = index == 0
        ? 0
        : chapters[index].startMs.clamp(0, totalDurationMs).toInt();
    final end = index + 1 < chapters.length
        ? chapters[index + 1].startMs.clamp(start, totalDurationMs).toInt()
        : totalDurationMs;
    if (end > start) {
      ranges.add((
        index: index,
        title: chapters[index].title,
        start: start,
        end: end,
      ));
    }
  }

  return ranges;
}

List<_ChapterRange> _trackRanges(List<AudioTrack> tracks) {
  final ranges = <_ChapterRange>[];
  var start = 0;

  for (var index = 0; index < tracks.length; index++) {
    final track = tracks[index];
    ranges.add((
      index: index,
      title: track.title,
      start: start,
      end: start + track.durationMs,
    ));
    start += track.durationMs;
  }

  return ranges;
}

MediaItem durationProbeMediaItem(String path) => MediaItem(
  id: 'bookish-duration-probe:${Uri.file(path)}',
  title: p.basenameWithoutExtension(path),
);
