import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../core/localization/generated/l10n.dart';
import '../../../core/presentation/diagnostic_failure_view.dart';
import '../../../core/presentation/formatters.dart';
import '../application/listening_activity.dart';
import 'listening_insights_cubit.dart';
import 'listening_insights_state.dart';

class ListeningInsightsScreen extends StatelessWidget {
  const ListeningInsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final locale = Localizations.localeOf(context).toString();
    return Scaffold(
      appBar: AppBar(title: Text(l10n.listeningInsightsTitle)),
      body: BlocBuilder<ListeningInsightsCubit, ListeningInsightsState>(
        builder: (context, state) {
          if (state.status == ListeningInsightsStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == ListeningInsightsStatus.failure) {
            return DiagnosticFailureView.fromMessage(
              message: state.message ?? l10n.couldNotLoadInsights,
              onRetry: context.read<ListeningInsightsCubit>().load,
            );
          }
          final activity = state.activityByPeriod[state.selectedPeriod];
          final periodTitle = switch (state.selectedPeriod) {
            InsightsPeriod.week => l10n.lastSevenDays,
            InsightsPeriod.month => l10n.lastThirtyDays,
            InsightsPeriod.year => l10n.lastTwelveMonths,
          };
          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
            children: [
              Text(
                l10n.allTimeListening,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _InsightCard(
                    label: l10n.listeningTime,
                    value: formatDuration(state.totalListening),
                    icon: Icons.headphones_rounded,
                  ),
                  _InsightCard(
                    label: l10n.booksCompleted,
                    value: NumberFormat.decimalPattern(
                      locale,
                    ).format(state.completedBooks),
                    icon: Icons.check_circle_outline_rounded,
                  ),
                  _InsightCard(
                    label: l10n.activeDays,
                    value: NumberFormat.decimalPattern(
                      locale,
                    ).format(state.activeDays),
                    icon: Icons.local_fire_department_outlined,
                  ),
                ],
              ),
              const SizedBox(height: 28),
              Text(
                l10n.listeningActivity,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: SegmentedButton<InsightsPeriod>(
                  showSelectedIcon: false,
                  segments: [
                    ButtonSegment(
                      value: InsightsPeriod.week,
                      label: Text(l10n.week),
                    ),
                    ButtonSegment(
                      value: InsightsPeriod.month,
                      label: Text(l10n.month),
                    ),
                    ButtonSegment(
                      value: InsightsPeriod.year,
                      label: Text(l10n.year),
                    ),
                  ],
                  selected: {state.selectedPeriod},
                  onSelectionChanged: (selection) => context
                      .read<ListeningInsightsCubit>()
                      .selectPeriod(selection.single),
                ),
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
                _RecentActivityCard(
                  activity: activity.buckets,
                  locale: locale,
                  totalListening: activity.totalListening,
                  listeningLabel: l10n.listeningTime,
                ),
            ],
          );
        },
      ),
    );
  }
}

class _RecentActivityCard extends StatelessWidget {
  const _RecentActivityCard({
    required this.activity,
    required this.locale,
    required this.totalListening,
    required this.listeningLabel,
  });

  final List<ListeningActivityBucket> activity;
  final String locale;
  final Duration totalListening;
  final String listeningLabel;

  @override
  Widget build(BuildContext context) {
    final maxListeningMs = activity.fold<int>(
      0,
      (maximum, bucket) => bucket.listening.inMilliseconds > maximum
          ? bucket.listening.inMilliseconds
          : maximum,
    );
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.calendar_view_week_rounded),
              title: Text(
                formatDuration(totalListening),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              subtitle: Text(listeningLabel),
            ),
            const Divider(height: 16),
            for (var index = 0; index < activity.length; index++) ...[
              _ActivityBucketRow(
                startDate: activity[index].startDate,
                endDate: activity[index].endDate,
                listening: activity[index].listening,
                maxListeningMs: maxListeningMs,
                locale: locale,
              ),
              if (index != activity.length - 1) const Divider(height: 16),
            ],
          ],
        ),
      ),
    );
  }
}

class _ActivityBucketRow extends StatelessWidget {
  const _ActivityBucketRow({
    required this.startDate,
    required this.endDate,
    required this.listening,
    required this.maxListeningMs,
    required this.locale,
  });

  final DateTime startDate;
  final DateTime endDate;
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
          child: Text(_formatBucketLabel(startDate, endDate, locale)),
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

String _formatBucketLabel(DateTime start, DateTime end, String locale) {
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

class _InsightCard extends StatelessWidget {
  const _InsightCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon),
              const SizedBox(height: 14),
              Text(value, style: Theme.of(context).textTheme.titleLarge),
              Text(label, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}
