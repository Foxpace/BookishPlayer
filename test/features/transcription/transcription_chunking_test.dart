import 'package:bookish_player/features/transcription/data/transcription_chunking.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('planTranscriptionChunks', () {
    test('leaves short ranges as one clip', () {
      final chunks = planTranscriptionChunks(
        start: const Duration(seconds: 10),
        end: const Duration(seconds: 30),
      );

      expect(chunks, [
        (start: const Duration(seconds: 10), end: const Duration(seconds: 30)),
      ]);
    });

    test('covers long ranges with short overlapping clips', () {
      final chunks = planTranscriptionChunks(
        start: Duration.zero,
        end: const Duration(minutes: 2),
      );

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
    });
  });

  group('mergeTranscriptionParts', () {
    test('removes words repeated by overlapping audio', () {
      expect(
        mergeTranscriptionParts([
          'The story starts on a quiet night.',
          'a quiet night and everything changes.',
        ]),
        'The story starts on a quiet night. and everything changes.',
      );
    });

    test('keeps unrelated adjacent parts intact', () {
      expect(
        mergeTranscriptionParts(['First sentence.', 'Then another one.']),
        'First sentence. Then another one.',
      );
    });
  });
}
