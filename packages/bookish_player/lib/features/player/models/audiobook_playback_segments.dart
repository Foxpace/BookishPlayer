part of 'playback_segments.dart';

extension AudiobookPlaybackSegments on Audiobook {
  List<PlaybackSegment> get playbackSegments {
    final tracks = playableTracks;
    if (tracks.isEmpty) {
      return const [];
    }

    final totalDurationMs = tracks.fold(
      0,
      (total, track) => total + track.durationMs,
    );
    if (totalDurationMs <= 0) {
      return _fallbackSegments(tracks);
    }

    final ranges = _chapterRanges(this, tracks, totalDurationMs);
    return _intersectingSegments(tracks, ranges);
  }
}
