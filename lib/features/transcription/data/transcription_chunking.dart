import 'dart:math' as math;

typedef TranscriptionChunk = ({Duration start, Duration end});

const transcriptionChunkLength = Duration(seconds: 25);
const transcriptionChunkOverlap = Duration(seconds: 1);

List<TranscriptionChunk> planTranscriptionChunks({
  required Duration start,
  required Duration end,
  Duration maximumLength = transcriptionChunkLength,
  Duration overlap = transcriptionChunkOverlap,
}) {
  final durationMs = (end - start).inMilliseconds;
  if (durationMs <= 0) {
    return const [];
  }

  final maximumMs = maximumLength.inMilliseconds;
  final overlapMs = overlap.inMilliseconds;
  if (maximumMs <= 0 || overlapMs < 0 || overlapMs >= maximumMs) {
    throw ArgumentError('Chunk length must be positive and exceed overlap.');
  }
  if (durationMs <= maximumMs) {
    return [(start: start, end: end)];
  }

  final stepMs = maximumMs - overlapMs;
  final chunkCount = math.max(
    2,
    (durationMs - overlapMs + stepMs - 1) ~/ stepMs,
  );
  final chunkLengthMs =
      (durationMs + overlapMs * (chunkCount - 1)) ~/ chunkCount;
  final chunks = <TranscriptionChunk>[];
  for (var index = 0; index < chunkCount; index++) {
    final localStartMs = index * (chunkLengthMs - overlapMs);
    final localEndMs = index == chunkCount - 1
        ? durationMs
        : math.min(durationMs, localStartMs + chunkLengthMs);
    chunks.add((
      start: start + Duration(milliseconds: localStartMs),
      end: start + Duration(milliseconds: localEndMs),
    ));
  }
  return chunks;
}

String mergeTranscriptionParts(Iterable<String> parts) {
  final merged = <String>[];
  for (final part in parts) {
    final words = part.trim().split(RegExp(r'\s+'))
      ..removeWhere((word) => word.isEmpty);
    if (words.isEmpty) {
      continue;
    }
    final overlap = _wordOverlap(merged, words);
    merged.addAll(words.skip(overlap));
  }
  return merged.join(' ').trim();
}

int _wordOverlap(List<String> previous, List<String> next) {
  final limit = math.min(12, math.min(previous.length, next.length));
  for (var length = limit; length >= 2; length--) {
    var matches = true;
    for (var index = 0; index < length; index++) {
      if (_normalized(previous[previous.length - length + index]) !=
          _normalized(next[index])) {
        matches = false;
        break;
      }
    }
    if (matches) {
      return length;
    }
  }
  return 0;
}

String _normalized(String word) {
  const punctuation = '.,!?;:"\'“”‘’()[]{}—–-…';
  var start = 0;
  var end = word.length;
  while (start < end && punctuation.contains(word[start])) {
    start++;
  }
  while (end > start && punctuation.contains(word[end - 1])) {
    end--;
  }
  return word.substring(start, end).toLowerCase();
}
