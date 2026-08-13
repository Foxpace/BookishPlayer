import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../../cubits/player_cubits.dart';

class SleepTimerSheet extends StatelessWidget {
  const SleepTimerSheet({
    required this.state,
    required this.onSetDuration,
    required this.onEndOfChapter,
    required this.onCancel,
    super.key,
  });

  final PlayerState state;
  final ValueChanged<Duration> onSetDuration;
  final VoidCallback onEndOfChapter;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 4, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).sleepTimer,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
            if (state.sleepTimerType != null) ...[
              const SizedBox(height: 6),
              Text(
                _activeTimerLabel(context),
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ],
            const SizedBox(height: 16),
            _TimerDurationChoices(onSelected: onSetDuration),
            const SizedBox(height: 10),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.skip_next_rounded),
              title: Text(S.of(context).endOfChapter),
              subtitle: Text(S.of(context).endOfChapterDescription),
              enabled: state.book?.chapters.isNotEmpty ?? false,
              onTap: onEndOfChapter,
            ),
            if (state.sleepTimerType != null)
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: onCancel,
                  child: Text(S.of(context).turnOffTimer),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _activeTimerLabel(BuildContext context) {
    if (state.sleepTimerType == SleepTimerType.endOfChapter) {
      return S.of(context).stopsAtEndOfChapter;
    }
    final minutes = state.sleepRemainingMinutes;
    return minutes == null
        ? S.of(context).timerActive
        : S.of(context).minutesRemaining(minutes);
  }
}

class _TimerDurationChoices extends StatelessWidget {
  const _TimerDurationChoices({required this.onSelected});

  final ValueChanged<Duration> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [15, 30, 45, 60]
          .map(
            (minutes) => ActionChip(
              label: Text(S.of(context).minutesShort(minutes)),
              onPressed: () => onSelected(Duration(minutes: minutes)),
            ),
          )
          .toList(),
    );
  }
}
