import 'package:flutter/material.dart';

import '../../../../core/presentation/formatters.dart';
import '../../models/listening_activity.dart';
import 'activity_bucket_row.dart';

class RecentActivityCard extends StatelessWidget {
  const RecentActivityCard({
    required this.activity,
    required this.locale,
    required this.totalListening,
    required this.listeningLabel,
    super.key,
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
              ActivityBucketRow(
                range: (
                  start: activity[index].startDate,
                  end: activity[index].endDate,
                ),
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
