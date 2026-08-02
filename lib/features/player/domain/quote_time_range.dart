import 'dart:math' as math;

class QuoteTimeRange {
  const QuoteTimeRange._({
    required this.chapterDurationMs,
    required this.startMs,
    required this.endMs,
  });

  factory QuoteTimeRange.initial({
    required Duration chapterDuration,
    required Duration anchor,
    Duration defaultLength = const Duration(seconds: 30),
  }) {
    final maximum = math.max(1, chapterDuration.inMilliseconds);
    final minimum = math.min(1000, maximum);
    final end = anchor.inMilliseconds.clamp(minimum, maximum);
    final start = math.max(0, end - defaultLength.inMilliseconds);
    return QuoteTimeRange._(
      chapterDurationMs: maximum,
      startMs: start,
      endMs: end,
    );
  }

  final int chapterDurationMs;
  final int startMs;
  final int endMs;

  int get minimumLengthMs => math.min(1000, chapterDurationMs);
  int get lengthMs => endMs - startMs;
  Duration get start => Duration(milliseconds: startMs);
  Duration get end => Duration(milliseconds: endMs);

  QuoteTimeRange withPreset(Duration length) {
    final requested = math.max(minimumLengthMs, length.inMilliseconds);
    return _copy(startMs: math.max(0, endMs - requested), endMs: endMs);
  }

  QuoteTimeRange withStart(Duration value) => _copy(
    startMs: value.inMilliseconds.clamp(0, endMs - minimumLengthMs),
    endMs: endMs,
  );

  QuoteTimeRange withEnd(Duration value) => _copy(
    startMs: startMs,
    endMs: value.inMilliseconds.clamp(
      startMs + minimumLengthMs,
      chapterDurationMs,
    ),
  );

  QuoteTimeRange shift(Duration delta) {
    final duration = lengthMs;
    var shiftedStart = startMs + delta.inMilliseconds;
    var shiftedEnd = endMs + delta.inMilliseconds;
    if (shiftedStart < 0) {
      shiftedStart = 0;
      shiftedEnd = duration;
    }
    if (shiftedEnd > chapterDurationMs) {
      shiftedEnd = chapterDurationMs;
      shiftedStart = chapterDurationMs - duration;
    }
    return _copy(startMs: shiftedStart, endMs: shiftedEnd);
  }

  QuoteTimeRange _copy({required int startMs, required int endMs}) {
    assert(startMs >= 0);
    assert(endMs <= chapterDurationMs);
    assert(endMs > startMs);
    return QuoteTimeRange._(
      chapterDurationMs: chapterDurationMs,
      startMs: startMs,
      endMs: endMs,
    );
  }
}
