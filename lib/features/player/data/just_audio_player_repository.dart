import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path/path.dart' as p;

import '../../library/domain/audiobook.dart';
import '../domain/audio_player_repository.dart';

class JustAudioPlayerRepository implements AudioPlayerRepository {
  JustAudioPlayerRepository(this._player);

  final AudioPlayer _player;
  List<PlaybackSegment> _segments = const [];
  var _offsetsMs = const [0];
  var _totalDurationMs = 0;

  Future<void> configure() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
  }

  @override
  Stream<Duration> get positionStream => _player.positionStream.map(
    (position) => position + Duration(milliseconds: _currentOffsetMs),
  );

  @override
  Stream<Duration> get bufferedPositionStream => _player.bufferedPositionStream
      .map((position) => position + Duration(milliseconds: _currentOffsetMs));

  @override
  Stream<Duration?> get durationStream => _player.durationStream.map(
    (_) => Duration(milliseconds: _totalDurationMs),
  );

  @override
  Stream<bool> get playingStream => _player.playingStream;

  @override
  Stream<bool> get completedStream => _player.processingStateStream
      .map((state) => state == ProcessingState.completed)
      .distinct();

  @override
  Duration get position =>
      _player.position + Duration(milliseconds: _currentOffsetMs);

  @override
  bool get isPlaying => _player.playing;

  @override
  Future<Duration> probeDuration(String path) async {
    final probe = AudioPlayer();
    try {
      return await probe.setFilePath(path, tag: durationProbeMediaItem(path)) ??
          Duration.zero;
    } finally {
      await probe.dispose();
    }
  }

  @override
  Future<void> load(Audiobook book) async {
    _segments = buildPlaybackSegments(book);
    _offsetsMs = _segments.map((segment) => segment.globalStartMs).toList();
    _totalDurationMs = book.playableTracks.fold(
      0,
      (total, track) => total + track.durationMs,
    );
    final initial = _locationFor(Duration(milliseconds: book.positionMs));
    await _player.setAudioSources(
      _segments.map((segment) {
        final item = MediaItem(
          id: '${book.id}:${segment.id}',
          title: book.title,
          album: book.title,
          artist: book.author.isEmpty ? null : book.author,
          displayTitle: book.title,
          displaySubtitle: segment.title,
          duration: Duration(milliseconds: segment.durationMs),
          artUri: book.artworkPath == null ? null : Uri.file(book.artworkPath!),
        );
        final source = AudioSource.file(segment.track.filePath);
        if (segment.sourceStartMs == 0 &&
            segment.durationMs == segment.track.durationMs) {
          return AudioSource.file(segment.track.filePath, tag: item);
        }
        return ClippingAudioSource(
          child: source,
          start: Duration(milliseconds: segment.sourceStartMs),
          end: Duration(
            milliseconds: segment.sourceStartMs + segment.durationMs,
          ),
          duration: Duration(milliseconds: segment.durationMs),
          tag: item,
        );
      }).toList(),
      initialIndex: initial.index,
      initialPosition: initial.position,
    );
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> seek(Duration position) {
    final location = _locationFor(position);
    return _player.seek(location.position, index: location.index);
  }

  @override
  Future<void> setSpeed(double speed) => _player.setSpeed(speed);

  @override
  Future<void> dispose() => _player.dispose();

  int get _currentOffsetMs {
    final index = _player.currentIndex ?? 0;
    return index < _offsetsMs.length ? _offsetsMs[index] : 0;
  }

  ({int index, Duration position}) _locationFor(Duration globalPosition) {
    if (_segments.isEmpty) {
      return (index: 0, position: globalPosition);
    }
    final milliseconds = globalPosition.inMilliseconds
        .clamp(0, _totalDurationMs)
        .toInt();
    var index = _segments.length - 1;
    for (var candidate = 0; candidate < _segments.length; candidate++) {
      final end = _offsetsMs[candidate] + _segments[candidate].durationMs;
      if (milliseconds < end) {
        index = candidate;
        break;
      }
    }
    return (
      index: index,
      position: Duration(milliseconds: milliseconds - _offsetsMs[index]),
    );
  }
}

class PlaybackSegment {
  const PlaybackSegment({
    required this.id,
    required this.track,
    required this.title,
    required this.globalStartMs,
    required this.sourceStartMs,
    required this.durationMs,
  });

  final String id;
  final AudioTrack track;
  final String title;
  final int globalStartMs;
  final int sourceStartMs;
  final int durationMs;
}

/// Builds the same chapter-relative timeline used by the player UI, while
/// retaining enough information to clip chapters out of their physical files.
List<PlaybackSegment> buildPlaybackSegments(Audiobook book) {
  final tracks = book.playableTracks;
  final totalDurationMs = tracks.fold(
    0,
    (total, track) => total + track.durationMs,
  );
  if (tracks.isEmpty) {
    return const [];
  }

  // Keep unknown-duration files playable. They cannot be clipped reliably,
  // but the decoder can still discover their duration after loading.
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

  final chapters = [...book.chapters]
    ..sort((a, b) => a.startMs.compareTo(b.startMs));
  final chapterRanges = <({int index, String title, int start, int end})>[];
  if (chapters.isEmpty) {
    for (var index = 0, start = 0; index < tracks.length; index++) {
      final track = tracks[index];
      chapterRanges.add((
        index: index,
        title: track.title,
        start: start,
        end: start + track.durationMs,
      ));
      start += track.durationMs;
    }
  } else {
    for (var index = 0; index < chapters.length; index++) {
      final start = index == 0
          ? 0
          : chapters[index].startMs.clamp(0, totalDurationMs).toInt();
      final end = index + 1 < chapters.length
          ? chapters[index + 1].startMs.clamp(start, totalDurationMs).toInt()
          : totalDurationMs;
      if (end > start) {
        chapterRanges.add((
          index: index,
          title: chapters[index].title,
          start: start,
          end: end,
        ));
      }
    }
  }

  final segments = <PlaybackSegment>[];
  var trackStart = 0;
  for (final track in tracks) {
    final trackEnd = trackStart + track.durationMs;
    for (final chapter in chapterRanges) {
      final start = chapter.start > trackStart ? chapter.start : trackStart;
      final end = chapter.end < trackEnd ? chapter.end : trackEnd;
      if (end <= start) {
        continue;
      }
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
    trackStart = trackEnd;
  }
  return segments;
}

/// Gives short-lived metadata probes a safe, lightweight source tag.
MediaItem durationProbeMediaItem(String path) => MediaItem(
  id: 'bookish-duration-probe:${Uri.file(path)}',
  title: p.basenameWithoutExtension(path),
);
