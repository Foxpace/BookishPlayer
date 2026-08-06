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
    if (overlap > 0) {
      merged.addAll(words.skip(overlap));
      continue;
    }
    final approximateOverlap = _approximateOverlap(merged, words);
    if (approximateOverlap > 0) {
      merged.removeRange(merged.length - approximateOverlap, merged.length);
    }
    merged.addAll(words);
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

int _approximateOverlap(List<String> previous, List<String> next) {
  final previousLimit = math.min(12, previous.length);
  final nextLimit = math.min(12, next.length);
  var bestPreviousLength = 0;
  var bestCoverage = 0;
  var bestSimilarity = 0.0;
  for (
    var previousLength = 1;
    previousLength <= previousLimit;
    previousLength++
  ) {
    final previousWords = previous.sublist(previous.length - previousLength);
    final previousPhrase = _normalizedPhrase(previousWords);
    for (var nextLength = 1; nextLength <= nextLimit; nextLength++) {
      final nextWords = next.sublist(0, nextLength);
      final nextPhrase = _normalizedPhrase(nextWords);
      final coverage = math.min(previousPhrase.length, nextPhrase.length);
      if (coverage < 6 ||
          (previousLength == 1 &&
              nextLength == 1 &&
              previousPhrase == nextPhrase)) {
        continue;
      }
      final similarity = _similarity(previousPhrase, nextPhrase);
      final sharedWords = previousWords
          .map(_normalized)
          .where(nextWords.map(_normalized).contains)
          .toSet()
          .length;
      final reliable =
          similarity >= 0.88 ||
          (similarity >= 0.72 && sharedWords >= 2) ||
          (previousLength == 1 &&
              nextLength == 1 &&
              similarity >= 0.8 &&
              coverage >= 6);
      if (!reliable ||
          coverage < bestCoverage ||
          (coverage == bestCoverage && similarity <= bestSimilarity)) {
        continue;
      }
      bestPreviousLength = previousLength;
      bestCoverage = coverage;
      bestSimilarity = similarity;
    }
  }
  return bestPreviousLength;
}

String _normalizedPhrase(Iterable<String> words) =>
    words.map(_normalized).join();

double _similarity(String first, String second) {
  final longest = math.max(first.length, second.length);
  if (longest == 0) {
    return 1;
  }
  return 1 - (_editDistance(first, second) / longest);
}

int _editDistance(String first, String second) {
  var previous = List<int>.generate(second.length + 1, (index) => index);
  for (var firstIndex = 0; firstIndex < first.length; firstIndex++) {
    final current = <int>[firstIndex + 1];
    for (var secondIndex = 0; secondIndex < second.length; secondIndex++) {
      final substitution =
          previous[secondIndex] +
          (first[firstIndex] == second[secondIndex] ? 0 : 1);
      current.add(
        math.min(
          substitution,
          math.min(previous[secondIndex + 1] + 1, current.last + 1),
        ),
      );
    }
    previous = current;
  }
  return previous.last;
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
