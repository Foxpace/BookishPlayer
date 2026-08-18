import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../../cubits/listening_insights_state.dart';
import '../../models/insights_period.dart';
import 'recent_activity_card.dart';

class ListeningActivitySection extends StatelessWidget {
  const ListeningActivitySection({
    required this.state,
    required this.locale,
    required this.onPeriodSelected,
    super.key,
  });

  final ListeningInsightsState state;
  final String locale;
  final ValueChanged<InsightsPeriod> onPeriodSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final activity = state.activityByPeriod[state.selectedPeriod];
    final periodTitle = switch (state.selectedPeriod) {
      InsightsPeriod.week => l10n.lastSevenDays,
      InsightsPeriod.month => l10n.lastThirtyDays,
      InsightsPeriod.year => l10n.lastTwelveMonths,
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.listeningActivity,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10),
        SegmentedButton<InsightsPeriod>(
          showSelectedIcon: false,
          segments: [
            ButtonSegment(value: InsightsPeriod.week, label: Text(l10n.week)),
            ButtonSegment(value: InsightsPeriod.month, label: Text(l10n.month)),
            ButtonSegment(value: InsightsPeriod.year, label: Text(l10n.year)),
          ],
          selected: {state.selectedPeriod},
          onSelectionChanged: (selection) => onPeriodSelected(selection.single),
        ),
        const SizedBox(height: 16),
        Text(periodTitle, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 6),
        if (state.totalListening == Duration.zero)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(l10n.emptyListeningHistory),
            ),
          )
        else if (activity != null)
          RecentActivityCard(
            activity: activity.buckets,
            locale: locale,
            totalListening: activity.totalListening,
            listeningLabel: l10n.listeningTime,
          ),
      ],
    );
  }
}
