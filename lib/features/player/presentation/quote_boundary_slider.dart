import 'package:flutter/material.dart';

import '../../../core/presentation/formatters.dart';

class QuoteRangeSlider extends StatelessWidget {
  const QuoteRangeSlider({
    required this.start,
    required this.end,
    required this.chapterDuration,
    required this.enabled,
    required this.onStartChanged,
    required this.onEndChanged,
    super.key,
  });

  final Duration start;
  final Duration end;
  final Duration chapterDuration;
  final bool enabled;
  final ValueChanged<Duration> onStartChanged;
  final ValueChanged<Duration> onEndChanged;

  @override
  Widget build(BuildContext context) {
    final maximum = chapterDuration.inMilliseconds
        .toDouble()
        .clamp(1, double.infinity)
        .toDouble();
    final startValue = start.inMilliseconds
        .toDouble()
        .clamp(0, maximum)
        .toDouble();
    final endValue = end.inMilliseconds
        .toDouble()
        .clamp(startValue, maximum)
        .toDouble();
    return Semantics(
      label: 'Quote time range',
      value: '${formatDuration(start)} to ${formatDuration(end)}',
      child: SizedBox(
        height: 72,
        child: SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 7,
            rangeThumbShape: const RoundRangeSliderThumbShape(
              enabledThumbRadius: 13,
            ),
            rangeValueIndicatorShape:
                const PaddleRangeSliderValueIndicatorShape(),
          ),
          child: RangeSlider(
            values: RangeValues(startValue, endValue),
            max: maximum,
            labels: RangeLabels(formatDuration(start), formatDuration(end)),
            onChanged: enabled ? (next) => _updateOneBoundary(next) : null,
          ),
        ),
      ),
    );
  }

  void _updateOneBoundary(RangeValues next) {
    final nextStart = next.start.round();
    final nextEnd = next.end.round();
    final startDelta = (nextStart - start.inMilliseconds).abs();
    final endDelta = (nextEnd - end.inMilliseconds).abs();
    if (startDelta == 0 && endDelta == 0) {
      return;
    }
    if (startDelta >= endDelta) {
      onStartChanged(Duration(milliseconds: nextStart));
    } else {
      onEndChanged(Duration(milliseconds: nextEnd));
    }
  }
}
