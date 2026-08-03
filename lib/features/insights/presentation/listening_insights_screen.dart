import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/presentation/formatters.dart';
import 'listening_insights_cubit.dart';
import 'listening_insights_state.dart';

class ListeningInsightsScreen extends StatelessWidget {
  const ListeningInsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Listening insights')),
      body: BlocBuilder<ListeningInsightsCubit, ListeningInsightsState>(
        builder: (context, state) {
          if (state.status == ListeningInsightsStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == ListeningInsightsStatus.failure) {
            return Center(
              child: Text(state.message ?? 'Could not load insights.'),
            );
          }
          final booksById = {for (final book in state.books) book.id: book};
          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
            children: [
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _InsightCard(
                    label: 'All-time listening',
                    value: formatDuration(state.totalListening),
                    icon: Icons.headphones_rounded,
                  ),
                  _InsightCard(
                    label: 'Last 7 days',
                    value: formatDuration(state.lastSevenDays),
                    icon: Icons.calendar_view_week_rounded,
                  ),
                  _InsightCard(
                    label: 'Books completed',
                    value: '${state.completedBooks}',
                    icon: Icons.check_circle_outline_rounded,
                  ),
                  _InsightCard(
                    label: 'Active days',
                    value: '${state.activeDays}',
                    icon: Icons.local_fire_department_outlined,
                  ),
                ],
              ),
              const SizedBox(height: 28),
              Text(
                'Recent sessions',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              if (state.sessions.isEmpty)
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Text('Your listening history will appear here.'),
                  ),
                )
              else
                for (final session in state.sessions.take(50))
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.graphic_eq_rounded),
                      title: Text(
                        booksById[session.bookId]?.title ?? 'Removed book',
                      ),
                      subtitle: Text(
                        '${session.startedAt.toLocal()} · ${formatDuration(Duration(milliseconds: session.listenedMs))}',
                      ),
                      trailing: Text('${session.speed}×'),
                    ),
                  ),
            ],
          );
        },
      ),
    );
  }
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
