import 'package:audio_service/audio_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart' as p;

import '../../library/domain/audiobook.dart';

part 'playback_segments.freezed.dart';

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

List<PlaybackSegment> buildPlaybackSegments(Audiobook book) {
  final tracks = book.playableTracks;
  final totalDurationMs = tracks.fold(
    0,
    (total, track) => total + track.durationMs,
  );
  if (tracks.isEmpty) {
    return const [];
  }
  if (totalDurationMs <= 0) {
    return [
      for (var index = 0; index < tracks.length; index++)
        PlaybackSegment(
          id: 'track-${tracks[index].id}',
          track: tracks[index],
          title: tracks[index].title,
          globalStartMs: 0,
          sourceStartMs: 0,
          durationMs: tracks[index].durationMs,
        ),
    ];
  }
  final ranges = _chapterRanges(book, tracks, totalDurationMs);
  final segments = <PlaybackSegment>[];
  var trackStart = 0;
  for (final track in tracks) {
    final trackEnd = trackStart + track.durationMs;
    for (final chapter in ranges) {
      final start = chapter.start > trackStart ? chapter.start : trackStart;
      final end = chapter.end < trackEnd ? chapter.end : trackEnd;
      if (end > start) {
        segments.add(
          PlaybackSegment(
            id: 'chapter-${chapter.index}:${track.id}:$start',
            track: track,
            title: chapter.title,
            globalStartMs: start,
            sourceStartMs: start - trackStart,
            durationMs: end - start,
          ),
        );
      }
    }
    trackStart = trackEnd;
  }
  return segments;
}

List<({int index, String title, int start, int end})> _chapterRanges(
  Audiobook book,
  List<AudioTrack> tracks,
  int totalDurationMs,
) {
  final chapters = [...book.chapters]
    ..sort((a, b) => a.startMs.compareTo(b.startMs));
  final ranges = <({int index, String title, int start, int end})>[];
  if (chapters.isEmpty) {
    for (var index = 0, start = 0; index < tracks.length; index++) {
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

MediaItem durationProbeMediaItem(String path) => MediaItem(
  id: 'bookish-duration-probe:${Uri.file(path)}',
  title: p.basenameWithoutExtension(path),
);
