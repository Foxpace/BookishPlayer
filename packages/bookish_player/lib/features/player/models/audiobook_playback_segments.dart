part of 'playback_segments.dart';

extension AudiobookPlaybackSegments on Audiobook {
  List<PlaybackSegment> get playbackSegments {
    final tracks = playableTracks;
    if (tracks.isEmpty) {
      return const [];
    }

    // A single file can contain many chapter markers. Play it as one source
    // so the decoder keeps running when the position crosses a chapter.
    if (tracks.length == 1) {
      final track = tracks.single;
      return [
        PlaybackSegment(
          id: 'track-${track.id}',
          track: track,
          title: track.title,
          globalStartMs: 0,
          sourceStartMs: 0,
          durationMs: track.durationMs,
        ),
      ];
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
