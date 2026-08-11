import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/presentation/formatters.dart';

class ActivityBucketRow extends StatelessWidget {
  const ActivityBucketRow({
    required this.range,
    required this.listening,
    required this.maxListeningMs,
    required this.locale,
    super.key,
  });

  final ({DateTime start, DateTime end}) range;
  final Duration listening;
  final int maxListeningMs;
  final String locale;

  @override
  Widget build(BuildContext context) {
    final progress = maxListeningMs == 0
        ? 0.0
        : listening.inMilliseconds / maxListeningMs;
    return Row(
      children: [
        SizedBox(
          width: 92,
          child: Text(formatBucketLabel(range.start, range.end, locale)),
        ),
        Expanded(
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 8,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          width: 58,
          child: Text(
            formatDuration(listening),
            textAlign: TextAlign.end,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}

String formatBucketLabel(DateTime start, DateTime end, String locale) {
  if (start == end) {
    return DateFormat.MMMd(locale).format(start);
  }
  if (start.day == 1 && end.day >= 28) {
    return DateFormat.MMM(locale).format(start);
  }
  if (start.month == end.month) {
    return '${DateFormat.MMM(locale).format(start)} ${start.day}–${end.day}';
  }
  return '${DateFormat.Md(locale).format(start)}–${DateFormat.Md(locale).format(end)}';
}
