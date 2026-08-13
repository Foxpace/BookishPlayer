import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../../../../core/presentation/formatters.dart';

class QuoteRangeSlider extends StatelessWidget {
  const QuoteRangeSlider({
    required this.range,
    required this.behavior,
    super.key,
  });

  final ({Duration start, Duration end, Duration chapterDuration}) range;
  final ({
    bool enabled,
    ValueChanged<Duration> onStartChanged,
    ValueChanged<Duration> onEndChanged,
  })
  behavior;

  @override
  Widget build(BuildContext context) {
    final maximum = range.chapterDuration.inMilliseconds
        .toDouble()
        .clamp(1, double.infinity)
        .toDouble();
    final startValue = range.start.inMilliseconds
        .toDouble()
        .clamp(0, maximum)
        .toDouble();
    final endValue = range.end.inMilliseconds
        .toDouble()
        .clamp(startValue, maximum)
        .toDouble();
    return Semantics(
      label: S.of(context).quoteTimeRange,
      value: S
          .of(context)
          .rangeAccessibilityValue(
            formatDuration(range.start),
            formatDuration(range.end),
          ),
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
            labels: RangeLabels(
              formatDuration(range.start),
              formatDuration(range.end),
            ),
            onChanged: behavior.enabled
                ? (next) => _updateOneBoundary(next)
                : null,
          ),
        ),
      ),
    );
  }

  void _updateOneBoundary(RangeValues next) {
    final nextStart = next.start.round();
    final nextEnd = next.end.round();
    final startDelta = (nextStart - range.start.inMilliseconds).abs();
    final endDelta = (nextEnd - range.end.inMilliseconds).abs();
    if (startDelta == 0 && endDelta == 0) {
      return;
    }
    if (startDelta >= endDelta) {
      behavior.onStartChanged(Duration(milliseconds: nextStart));
    } else {
      behavior.onEndChanged(Duration(milliseconds: nextEnd));
    }
  }
}
