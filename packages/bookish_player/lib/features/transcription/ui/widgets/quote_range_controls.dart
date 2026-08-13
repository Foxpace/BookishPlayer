import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../../../../core/presentation/formatters.dart';
import '../../models/quote_time_range.dart';
import 'quote_preset_chips.dart';
import 'quote_range_shift_buttons.dart';
import 'quote_range_slider.dart';

class QuoteRangeControls extends StatelessWidget {
  const QuoteRangeControls({
    required this.range,
    required this.configuration,
    required this.actions,
    super.key,
  });

  final QuoteTimeRange range;
  final ({Duration chapterDuration, bool enabled}) configuration;
  final ({
    ValueChanged<Duration> onStartChanged,
    ValueChanged<Duration> onEndChanged,
    ValueChanged<Duration> onPreset,
    ValueChanged<Duration> onShift,
  })
  actions;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(S.of(context).fromPosition(formatDuration(range.start))),
            Text(S.of(context).toPosition(formatDuration(range.end))),
          ],
        ),
        QuoteRangeSlider(
          range: (
            start: range.start,
            end: range.end,
            chapterDuration: configuration.chapterDuration,
          ),
          behavior: (
            enabled: configuration.enabled,
            onStartChanged: actions.onStartChanged,
            onEndChanged: actions.onEndChanged,
          ),
        ),
        QuotePresetChips(
          enabled: configuration.enabled,
          onSelected: actions.onPreset,
        ),
        const SizedBox(height: 10),
        QuoteRangeShiftButtons(
          enabled: configuration.enabled,
          onShift: actions.onShift,
        ),
      ],
    );
  }
}
