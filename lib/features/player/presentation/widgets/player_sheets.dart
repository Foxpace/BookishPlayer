part of '../player_screen.dart';

class _PlayerTopButton extends StatelessWidget {
  const _PlayerTopButton({
    required this.tooltip,
    required this.onPressed,
    required this.icon,
  });

  final String tooltip;
  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.square(
        dimension: 44,
        child: IconButton.filledTonal(
          tooltip: tooltip,
          onPressed: onPressed,
          padding: EdgeInsets.zero,
          icon: Icon(icon, size: 24),
        ),
      ),
    );
  }
}

class _SleepTimerSheet extends StatelessWidget {
  const _SleepTimerSheet();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerCubit, PlayerState>(
      builder: (context, state) {
        final cubit = context.read<PlayerCubit>();
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 4, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sleep timer',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (state.sleepTimerType != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    _activeTimerLabel(state),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [15, 30, 45, 60]
                      .map(
                        (minutes) => ActionChip(
                          label: Text('$minutes min'),
                          onPressed: () {
                            cubit.setSleepTimer(Duration(minutes: minutes));
                            Navigator.pop(context);
                          },
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 10),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.skip_next_rounded),
                  title: const Text('End of chapter'),
                  subtitle: const Text('Stop at the next chapter boundary'),
                  enabled: state.book?.chapters.isNotEmpty ?? false,
                  onTap: () {
                    cubit.sleepAtEndOfChapter();
                    Navigator.pop(context);
                  },
                ),
                if (state.sleepTimerType != null)
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        cubit.cancelSleepTimer();
                        Navigator.pop(context);
                      },
                      child: const Text('Turn off timer'),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _activeTimerLabel(PlayerState state) {
    if (state.sleepTimerType == SleepTimerType.endOfChapter) {
      return 'Stops at end of chapter';
    }
    final remaining = state.sleepEndsAt?.difference(DateTime.now());
    if (remaining == null) {
      return 'Timer active';
    }
    final minutes =
        remaining.inMinutes + (remaining.inSeconds % 60 > 0 ? 1 : 0);
    return 'About $minutes minutes remaining';
  }
}

class _ChaptersSheet extends StatefulWidget {
  const _ChaptersSheet({required this.chapters});

  final List<PlayerChapter> chapters;

  @override
  State<_ChaptersSheet> createState() => _ChaptersSheetState();
}

class _ChaptersSheetState extends State<_ChaptersSheet> {
  int? _seekingIndex;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * .65,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 4, 24, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Chapters',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.separated(
                  itemCount: widget.chapters.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final chapter = widget.chapters[index];
                    return ListTile(
                      enabled: _seekingIndex == null,
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(child: Text('${index + 1}')),
                      title: Text(chapter.title),
                      subtitle: Text(
                        'Length ${formatDuration(chapter.duration)}',
                      ),
                      trailing: _seekingIndex == index
                          ? const SizedBox.square(
                              dimension: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : null,
                      onTap: () => _selectChapter(index, chapter),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectChapter(int index, PlayerChapter chapter) async {
    if (_seekingIndex != null) {
      return;
    }
    setState(() => _seekingIndex = index);
    try {
      await context.read<PlayerCubit>().seek(chapter.start);
      if (mounted) {
        Navigator.pop(context);
      }
    } finally {
      if (mounted) {
        setState(() => _seekingIndex = null);
      }
    }
  }
}
