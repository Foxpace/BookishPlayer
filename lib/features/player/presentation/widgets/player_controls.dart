part of '../player_screen.dart';

class _Transport extends StatelessWidget {
  const _Transport({required this.state});

  final PlayerState state;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PlayerCubit>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          key: const ValueKey('previous-chapter-slot'),
          child: IconButton(
            tooltip: 'Previous chapter',
            onPressed: state.book?.chapters.isNotEmpty == true
                ? cubit.previousChapter
                : null,
            color: Colors.white,
            icon: const Icon(Icons.skip_previous_rounded, size: 38),
          ),
        ),
        Expanded(
          key: const ValueKey('rewind-slot'),
          child: _SkipButton(
            label: '${state.playback.rewindSeconds}',
            onPressed: () =>
                cubit.skipBy(Duration(seconds: -state.playback.rewindSeconds)),
          ),
        ),
        Expanded(
          key: const ValueKey('playback-slot'),
          child: SizedBox(
            height: 72,
            child: OverflowBox(
              minWidth: 0,
              minHeight: 0,
              maxWidth: 72,
              maxHeight: 72,
              child: SizedBox.square(
                dimension: 72,
                child: FilledButton(
                  onPressed: state.status == PlayerStatus.ready
                      ? cubit.togglePlayback
                      : null,
                  style: FilledButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: EdgeInsets.zero,
                  ),
                  child: state.status == PlayerStatus.loading
                      ? const SizedBox.square(
                          dimension: 26,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Icon(
                          state.isPlaying
                              ? Icons.pause_rounded
                              : Icons.play_arrow_rounded,
                          size: 40,
                        ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          key: const ValueKey('forward-slot'),
          child: _SkipButton(
            label: '${state.playback.forwardSeconds}',
            flipIcon: true,
            onPressed: () =>
                cubit.skipBy(Duration(seconds: state.playback.forwardSeconds)),
          ),
        ),
        Expanded(
          key: const ValueKey('next-chapter-slot'),
          child: IconButton(
            tooltip: 'Next chapter',
            onPressed: state.book?.chapters.isNotEmpty == true
                ? cubit.nextChapter
                : null,
            color: Colors.white,
            icon: const Icon(Icons.skip_next_rounded, size: 38),
          ),
        ),
      ],
    );
  }
}

class _SpeedButton extends StatelessWidget {
  const _SpeedButton({required this.speed});

  final double speed;

  static const speeds = [0.75, 1.0, 1.25, 1.5, 1.75, 2.0];

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<double>(
      tooltip: 'Playback speed',
      initialValue: speed,
      onSelected: context.read<PlayerCubit>().changeSpeed,
      itemBuilder: (_) => speeds
          .map(
            (value) => PopupMenuItem(
              value: value,
              child: Text('${_presetName(value)} · $value×'),
            ),
          )
          .toList(),
      child: _ToolVisual(
        icon: Icons.speed_rounded,
        label: '${speed == .75 ? '0.75' : speed.toStringAsFixed(1)}×',
      ),
    );
  }

  String _presetName(double value) => switch (value) {
    .75 => 'Relaxed',
    1.0 => 'Natural',
    1.25 => 'Focused',
    1.5 => 'Brisk',
    1.75 => 'Fast',
    _ => 'Very fast',
  };
}

class _PlayerTools extends StatelessWidget {
  const _PlayerTools({
    required this.state,
    required this.onPickAudioOutput,
    required this.onChapters,
    required this.onTimer,
    required this.onNotes,
    required this.onQuote,
  });

  final PlayerState state;
  final VoidCallback? onPickAudioOutput;
  final VoidCallback? onChapters;
  final VoidCallback onTimer;
  final VoidCallback onNotes;
  final VoidCallback onQuote;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ToolButton(
            tooltip: 'Choose audio output',
            onPressed: onPickAudioOutput,
            child: const _ToolVisual(
              icon: Icons.speaker_group_outlined,
              label: 'Output',
            ),
          ),
        ),
        Expanded(child: _SpeedButton(speed: state.speed)),
        Expanded(
          child: _ToolButton(
            tooltip: 'Transcribe a quote',
            onPressed: onQuote,
            child: const _ToolVisual(
              icon: Icons.format_quote_rounded,
              label: 'Quote',
            ),
          ),
        ),
        Expanded(
          child: _ToolButton(
            tooltip: 'Chapters',
            onPressed: onChapters,
            child: const _ToolVisual(
              icon: Icons.format_list_numbered_rounded,
              label: 'Chapters',
            ),
          ),
        ),
        Expanded(
          child: _ToolButton(
            tooltip: 'Sleep timer',
            onPressed: onTimer,
            child: _ToolVisual(
              icon: Icons.timer_outlined,
              label: 'Timer',
              showBadge: state.sleepTimerType != null,
            ),
          ),
        ),
        Expanded(
          child: _ToolButton(
            tooltip: 'Notes and bookmarks',
            onPressed: onNotes,
            child: _ToolVisual(
              icon: Icons.note_alt_outlined,
              label: 'Notes',
              badgeLabel: state.notes.isEmpty ? null : '${state.notes.length}',
            ),
          ),
        ),
      ],
    );
  }
}

class _ToolButton extends StatelessWidget {
  const _ToolButton({
    required this.tooltip,
    required this.onPressed,
    required this.child,
  });

  final String tooltip;
  final VoidCallback? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Opacity(opacity: onPressed == null ? .38 : 1, child: child),
      ),
    );
  }
}

class _ToolVisual extends StatelessWidget {
  const _ToolVisual({
    required this.icon,
    required this.label,
    this.showBadge = false,
    this.badgeLabel,
  });

  final IconData icon;
  final String label;
  final bool showBadge;
  final String? badgeLabel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Badge(
            isLabelVisible: showBadge || badgeLabel != null,
            label: badgeLabel == null ? null : Text(badgeLabel!),
            child: Icon(icon, size: 27),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}
