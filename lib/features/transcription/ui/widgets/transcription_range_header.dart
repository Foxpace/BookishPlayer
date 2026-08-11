import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../../models/quote_time_range.dart';
import 'transcription_range_card.dart';

class TranscriptionRangeHeader extends StatelessWidget {
  const TranscriptionRangeHeader({
    required this.chapterTitle,
    required this.range,
    super.key,
  });

  final String? chapterTitle;
  final QuoteTimeRange range;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).transcribeQuote,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 6),
        Text(
          S.of(context).transcriptionRangeDescription,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 16),
        TranscriptionRangeCard(chapterTitle: chapterTitle, range: range),
      ],
    );
  }
}
