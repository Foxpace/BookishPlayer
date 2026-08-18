import 'dart:typed_data';

import 'package:bookish_cactus_transcription/src/cactus_models.dart';
import 'package:bookish_cactus_transcription/src/cactus_pcm_stream_factory.dart';
import 'package:test/test.dart';

void main() {
  group('Cactus PCM stream factory', () {
    test(
      'Given late audio, When PCM is requested, Then its range is decoded',
      () async {
        // GIVEN
        final requests = <({String path, Duration start, Duration duration})>[];
        final factory = CactusPcmStreamFactory(({
          required track,
          required start,
          required duration,
        }) async* {
          requests.add((
            path: track.filePath,
            start: start,
            duration: duration,
          ));
          yield Uint8List.fromList([1, 2, 3, 4]);
        });

        // WHEN
        final bytes = await factory
            .createStream(
              const CactusAudioSource(
                tracks: [
                  CactusAudioTrack(filePath: 'long.m4b', durationMs: 7200000),
                ],
              ),
              const Duration(minutes: 90),
              const Duration(minutes: 90, seconds: 20),
            )
            .expand((chunk) => chunk)
            .toList();

        // THEN
        expect(requests, [
          (
            path: 'long.m4b',
            start: const Duration(minutes: 90),
            duration: const Duration(seconds: 20),
          ),
        ]);
        expect(bytes, [1, 2, 3, 4]);
      },
    );

    test(
      'Given two tracks, When PCM is requested, Then one stream is emitted',
      () async {
        // GIVEN
        final requests = <({String path, Duration start, Duration duration})>[];
        final factory = CactusPcmStreamFactory(({
          required track,
          required start,
          required duration,
        }) async* {
          requests.add((
            path: track.filePath,
            start: start,
            duration: duration,
          ));
          yield Uint8List.fromList([requests.length]);
        });

        // WHEN
        final bytes = await factory
            .createStream(
              const CactusAudioSource(
                tracks: [
                  CactusAudioTrack(filePath: 'one.m4a', durationMs: 60000),
                  CactusAudioTrack(filePath: 'two.m4a', durationMs: 60000),
                ],
              ),
              const Duration(seconds: 50),
              const Duration(seconds: 70),
            )
            .expand((chunk) => chunk)
            .toList();

        // THEN
        expect(requests, [
          (
            path: 'one.m4a',
            start: const Duration(seconds: 50),
            duration: const Duration(seconds: 10),
          ),
          (
            path: 'two.m4a',
            start: Duration.zero,
            duration: const Duration(seconds: 10),
          ),
        ]);
        expect(bytes, [1, 2]);
      },
    );

    test(
      'Given no audio, When PCM is requested, Then a typed error is emitted',
      () async {
        // GIVEN
        const factory = CactusPcmStreamFactory();

        // WHEN
        final operation = factory
            .createStream(
              const CactusAudioSource(
                tracks: [
                  CactusAudioTrack(filePath: 'short.m4a', durationMs: 1000),
                ],
              ),
              const Duration(seconds: 2),
              const Duration(seconds: 3),
            )
            .drain<void>();

        // THEN
        await expectLater(
          operation,
          throwsA(isA<CactusTranscriptionException>()),
        );
      },
    );
  });

  test(
    'Given late audio, When FFmpeg args are built, Then PCM seek is used',
    () {
      // GIVEN
      const inputPath = 'book.m4b';
      const outputPath = '/tmp/audio.pipe';

      // WHEN
      final arguments = buildCactusPcmArguments(
        inputPath: inputPath,
        outputPath: outputPath,
        start: const Duration(hours: 4, seconds: 5),
        duration: const Duration(seconds: 20),
      );

      // THEN
      expect(arguments.indexOf('-ss'), lessThan(arguments.indexOf('-i')));
      expect(arguments[arguments.indexOf('-ss') + 1], '14405.000');
      expect(arguments[arguments.indexOf('-t') + 1], '20.000');
      expect(arguments, containsAllInOrder(['-ac', '1', '-ar', '16000']));
      expect(arguments, containsAllInOrder(['-f', 's16le', outputPath]));
    },
  );
}
