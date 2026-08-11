import 'package:bookish_player/features/transcription/repos/implementations/transcription_chunking.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Transcription chunking', () {
    group('planTranscriptionChunks', () {
      test(
        'Given the transcription chunking, When its behavior is exercised, Then leaves short ranges as one clip',
        () {
          // WHEN
          final chunks = planTranscriptionChunks(
            start: const Duration(seconds: 10),
            end: const Duration(seconds: 30),
          );

          // THEN
          expect(chunks, [
            (
              start: const Duration(seconds: 10),
              end: const Duration(seconds: 30),
            ),
          ]);
        },
      );

      test(
        'Given the transcription chunking, When its behavior is exercised, Then covers long ranges with short overlapping clips',
        () {
          // WHEN
          final chunks = planTranscriptionChunks(
            start: Duration.zero,
            end: const Duration(minutes: 2),
          );

          // THEN
          expect(chunks.first.start, Duration.zero);
          expect(chunks.last.end, const Duration(minutes: 2));
          for (final chunk in chunks) {
            expect(
              chunk.end - chunk.start,
              lessThanOrEqualTo(transcriptionChunkLength),
            );
          }
          for (var index = 1; index < chunks.length; index++) {
            expect(
              chunks[index - 1].end - chunks[index].start,
              transcriptionChunkOverlap,
            );
          }
        },
      );
    });

    group('mergeTranscriptionParts', () {
      test(
        'Given the transcription chunking, When its behavior is exercised, Then removes words repeated by overlapping audio',
        () {
          // THEN
          expect(
            mergeTranscriptionParts([
              'The story starts on a quiet night.',
              'a quiet night and everything changes.',
            ]),
            'The story starts on a quiet night. and everything changes.',
          );
        },
      );

      test(
        'Given the transcription chunking, When its behavior is exercised, Then keeps unrelated adjacent parts intact',
        () {
          // THEN
          expect(
            mergeTranscriptionParts(['First sentence.', 'Then another one.']),
            'First sentence. Then another one.',
          );
        },
      );

      test(
        'Given the transcription chunking, When its behavior is exercised, Then keeps a single deliberately repeated word',
        () {
          // THEN
          expect(
            mergeTranscriptionParts([
              'It was difficult.',
              'Difficult choices followed.',
            ]),
            'It was difficult. Difficult choices followed.',
          );
        },
      );

      test(
        'Given the transcription chunking, When its behavior is exercised, Then aligns overlapping phrases when one word is transcribed differently',
        () {
          // THEN
          expect(
            mergeTranscriptionParts([
              'The story ended on a quiet night.',
              'on a quiet knight before dawn.',
            ]),
            'The story ended on a quiet knight before dawn.',
          );
        },
      );

      test(
        'Given the transcription chunking, When its behavior is exercised, Then uses the complete word when a chunk ends partway through it',
        () {
          // THEN
          expect(
            mergeTranscriptionParts([
              'They walked around the for',
              'around the forest before dawn.',
            ]),
            'They walked around the forest before dawn.',
          );
        },
      );
    });
  });
}
