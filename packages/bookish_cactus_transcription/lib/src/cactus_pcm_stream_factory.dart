import 'dart:io';
import 'dart:typed_data';

import 'package:ffmpeg_kit_flutter_new_audio/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new_audio/ffmpeg_kit_config.dart';
import 'package:ffmpeg_kit_flutter_new_audio/return_code.dart';

import 'cactus_models.dart';

typedef CactusPcmDecoder =
    Stream<Uint8List> Function({
      required CactusAudioTrack track,
      required Duration start,
      required Duration duration,
    });

class CactusPcmStreamFactory {
  const CactusPcmStreamFactory([this._decoder = decodeCactusPcmWithFfmpeg]);

  final CactusPcmDecoder _decoder;

  Stream<Uint8List> createStream(
    CactusAudioSource source,
    Duration start,
    Duration end,
  ) async* {
    var trackOffset = Duration.zero;
    var decodedAudio = false;

    for (final track in source.tracks) {
      final trackEnd = trackOffset + Duration(milliseconds: track.durationMs);
      final overlapStart = start > trackOffset ? start : trackOffset;
      final overlapEnd = end < trackEnd ? end : trackEnd;

      if (overlapEnd > overlapStart) {
        decodedAudio = true;
        yield* _decoder(
          track: track,
          start: overlapStart - trackOffset,
          duration: overlapEnd - overlapStart,
        );
      }

      trackOffset = trackEnd;
      if (trackOffset >= end) {
        break;
      }
    }

    if (!decodedAudio) {
      throw const CactusTranscriptionException(
        'The selected range contains no audio.',
      );
    }
  }
}

Stream<Uint8List> decodeCactusPcmWithFfmpeg({
  required CactusAudioTrack track,
  required Duration start,
  required Duration duration,
}) async* {
  final pipePath = await FFmpegKitConfig.registerNewFFmpegPipe();
  if (pipePath == null) {
    throw const CactusTranscriptionException(
      'Could not open the audio decoder stream.',
    );
  }

  try {
    yield* _decodePipe(
      pipePath: pipePath,
      arguments: buildCactusPcmArguments(
        inputPath: track.filePath,
        outputPath: pipePath,
        start: start,
        duration: duration,
      ),
    );
  } finally {
    await FFmpegKitConfig.closeFFmpegPipe(pipePath);
  }
}

Stream<Uint8List> _decodePipe({
  required String pipePath,
  required List<String> arguments,
}) async* {
  final sessionFuture = FFmpegKit.executeWithArguments(arguments);

  await for (final bytes in File(pipePath).openRead()) {
    if (bytes.isNotEmpty) {
      yield Uint8List.fromList(bytes);
    }
  }

  final session = await sessionFuture;
  final returnCode = await session.getReturnCode();
  if (ReturnCode.isSuccess(returnCode) == false) {
    final output = await session.getOutput();
    throw CactusTranscriptionException(
      'Could not decode the selected audio. ${output ?? ''}'.trim(),
    );
  }
}

List<String> buildCactusPcmArguments({
  required String inputPath,
  required String outputPath,
  required Duration start,
  required Duration duration,
}) => [
  '-hide_banner',
  '-loglevel',
  'error',
  '-nostdin',
  '-y',
  '-ss',
  _formatSeconds(start),
  '-i',
  inputPath,
  '-t',
  _formatSeconds(duration),
  '-map',
  '0:a:0',
  '-vn',
  '-sn',
  '-dn',
  '-ac',
  '1',
  '-ar',
  '16000',
  '-c:a',
  'pcm_s16le',
  '-f',
  's16le',
  outputPath,
];

String _formatSeconds(Duration value) =>
    (value.inMicroseconds / Duration.microsecondsPerSecond).toStringAsFixed(3);
