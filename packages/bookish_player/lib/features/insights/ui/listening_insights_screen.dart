import 'package:flutter/material.dart';

import '../../../core/localization/generated/l10n.dart';
import '../../../core/presentation/app_message.dart';
import '../../../core/presentation/bookish_scaffold.dart';
import '../../../core/presentation/diagnostic_failure_view.dart';
import '../cubits/listening_insights_state.dart';
import '../cubits/listening_insights_status.dart';
import '../models/insights_period.dart';
import 'widgets/all_time_listening_summary.dart';
import 'widgets/listening_activity_section.dart';

class ListeningInsightsScreen extends StatelessWidget {
  const ListeningInsightsScreen({
    required this.state,
    required this.onRetry,
    required this.onPeriodSelected,
    super.key,
  });

  final ListeningInsightsState state;
  final VoidCallback onRetry;
  final ValueChanged<InsightsPeriod> onPeriodSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final locale = Localizations.localeOf(context).toString();
    return BookishScaffold(
      appBar: AppBar(title: Text(l10n.listeningInsightsTitle)),
      body: switch (state.status) {
        ListeningInsightsStatus.loading => const Center(
          child: CircularProgressIndicator(),
        ),
        ListeningInsightsStatus.failure => DiagnosticFailureView.fromMessage(
          message:
              state.message?.localize(context) ?? l10n.couldNotLoadInsights,
          onRetry: onRetry,
        ),
        ListeningInsightsStatus.ready => ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
          children: [
            AllTimeListeningSummary(
              totalListening: state.totalListening,
              completedBooks: state.completedBooks,
              activeDays: state.activeDays,
              streakDays: state.streakDays,
            ),
            const SizedBox(height: 28),
            ListeningActivitySection(
              state: state,
              locale: locale,
              onPeriodSelected: onPeriodSelected,
            ),
          ],
        ),
      },
    );
  }
}
