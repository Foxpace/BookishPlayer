import 'dart:io';

import 'package:ffmpeg_kit_flutter_new_audio/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new_audio/return_code.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'cactus_models.dart';
import 'transcription_chunking.dart';

typedef _TrackOverlap = ({Duration start, Duration end});

class CactusAudioClipFactory {
  const CactusAudioClipFactory();

  Future<List<File>> createClips(
    CactusAudioSource source,
    Duration start,
    Duration end,
  ) async {
    final directory = await getTemporaryDirectory();
    final clips = <File>[];

    try {
      return await _createTrackClips(
        tracks: source.tracks,
        start: start,
        end: end,
        directory: directory,
        clips: clips,
      );
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        _deleteClipsAndReturnError(clips, error),
        stackTrace,
      );
    }
  }

  Future<List<File>> _createTrackClips({
    required List<CactusAudioTrack> tracks,
    required Duration start,
    required Duration end,
    required Directory directory,
    required List<File> clips,
  }) async {
    var trackOffset = Duration.zero;
    var clipIndex = 0;

    for (var index = 0; index < tracks.length; index++) {
      final track = tracks[index];
      final trackDuration = Duration(milliseconds: track.durationMs);
      final trackEnd = trackOffset + trackDuration;

      final overlap = _trackOverlap(start, end, trackOffset, trackEnd);
      if (overlap != null) {
        clipIndex = await _appendTrackClips(
          track: (
            value: track,
            index: index,
            offset: trackOffset,
            overlap: overlap,
          ),
          destination: (directory: directory, clips: clips),
          initialClipIndex: clipIndex,
        );
      }

      trackOffset = trackEnd;
      if (trackOffset >= end) {
        break;
      }
    }

    return clips;
  }

  _TrackOverlap? _trackOverlap(
    Duration requestedStart,
    Duration requestedEnd,
    Duration trackStart,
    Duration trackEnd,
  ) {
    final start = requestedStart > trackStart ? requestedStart : trackStart;
    final end = requestedEnd < trackEnd ? requestedEnd : trackEnd;

    return end > start ? (start: start, end: end) : null;
  }

  Future<int> _appendTrackClips({
    required ({
      CactusAudioTrack value,
      int index,
      Duration offset,
      _TrackOverlap overlap,
    })
    track,
    required ({Directory directory, List<File> clips}) destination,
    required int initialClipIndex,
  }) async {
    var clipIndex = initialClipIndex;
    final chunks = planTranscriptionChunks(
      start: track.overlap.start,
      end: track.overlap.end,
    );

    for (final chunk in chunks) {
      final output = await _createAudioClip(
        track: (value: track.value, index: track.index, offset: track.offset),
        range: (start: chunk.start, end: chunk.end),
        destination: (directory: destination.directory, clipIndex: clipIndex++),
      );
      destination.clips.add(output);
    }

    return clipIndex;
  }

  Future<File> _createAudioClip({
    required ({CactusAudioTrack value, int index, Duration offset}) track,
    required ({Duration start, Duration end}) range,
    required ({Directory directory, int clipIndex}) destination,
  }) async {
    final localStart = range.start - track.offset;
    final localDuration = range.end - range.start;
    final output = File(
      p.join(
        destination.directory.path,
        'bookish_quote_${DateTime.now().microsecondsSinceEpoch}_${track.index}_${destination.clipIndex}.wav',
      ),
    );

    final session = await FFmpegKit.executeWithArguments([
      '-y',
      '-i',
      track.value.filePath,
      '-ss',
      _formatSeconds(localStart),
      '-t',
      _formatSeconds(localDuration),
      '-vn',
      '-ac',
      '1',
      '-ar',
      '16000',
      '-c:a',
      'pcm_s16le',
      output.path,
    ]);
    final returnCode = await session.getReturnCode();

    if (ReturnCode.isSuccess(returnCode) == false) {
      final outputText = await session.getOutput();
      throw CactusTranscriptionException(
        'Could not prepare the selected audio. ${outputText ?? ''}'.trim(),
      );
    }

    return output;
  }

  Object _deleteClipsAndReturnError(List<File> clips, Object error) {
    for (final clip in clips) {
      if (clip.existsSync()) {
        clip.deleteSync();
      }
    }

    return error;
  }

  String _formatSeconds(Duration value) =>
      (value.inMicroseconds / Duration.microsecondsPerSecond).toStringAsFixed(
        3,
      );
}
