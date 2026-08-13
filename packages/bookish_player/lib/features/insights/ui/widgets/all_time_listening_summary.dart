import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../../../../core/presentation/formatters.dart';
import 'insight_card.dart';

class AllTimeListeningSummary extends StatelessWidget {
  const AllTimeListeningSummary({
    required this.totalListening,
    required this.completedBooks,
    required this.activeDays,
    required this.locale,
    super.key,
  });

  final Duration totalListening;
  final int completedBooks;
  final int activeDays;
  final String locale;

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final numberFormat = NumberFormat.decimalPattern(locale);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.allTimeListening,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            InsightCard(
              label: l10n.listeningTime,
              value: formatDuration(totalListening),
              icon: Icons.headphones_rounded,
            ),
            InsightCard(
              label: l10n.booksCompleted,
              value: numberFormat.format(completedBooks),
              icon: Icons.check_circle_outline_rounded,
            ),
            InsightCard(
              label: l10n.activeDays,
              value: numberFormat.format(activeDays),
              icon: Icons.local_fire_department_outlined,
            ),
          ],
        ),
      ],
    );
  }
}
