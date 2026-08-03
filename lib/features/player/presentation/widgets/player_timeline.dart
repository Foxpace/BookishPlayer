part of '../player_screen.dart';

class _Timeline extends StatefulWidget {
  const _Timeline({required this.state});

  final PlayerState state;

  @override
  State<_Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<_Timeline> {
  double? _dragValue;

  @override
  void didUpdateWidget(covariant _Timeline oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.state.currentChapterIndex !=
            widget.state.currentChapterIndex ||
        oldWidget.state.chapterDuration != widget.state.chapterDuration) {
      _dragValue = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.state;
    final max = state.chapterDuration.inMilliseconds.toDouble().clamp(
      1.0,
      double.infinity,
    );
    final value =
        (_dragValue ?? state.chapterPosition.inMilliseconds.toDouble()).clamp(
          0.0,
          max,
        );
    return Column(
      children: [
        if (state.currentChapter case final chapter?) ...[
          Row(
            children: [
              Expanded(
                child: Text(
                  chapter.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${state.currentChapterIndex + 1} / ${state.chapterCount}',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
        Slider(
          value: value,
          max: max,
          secondaryTrackValue: state.chapterBufferedPosition.inMilliseconds
              .toDouble()
              .clamp(0.0, max),
          onChangeStart: (next) => setState(() => _dragValue = next),
          onChanged: (next) => setState(() => _dragValue = next),
          onChangeEnd: (next) {
            setState(() => _dragValue = null);
            context.read<PlayerCubit>().seekWithinChapter(
              Duration(milliseconds: next.round()),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                formatDuration(state.chapterPosition),
                style: Theme.of(context).textTheme.labelMedium,
              ),
              Text(
                formatRemaining(state.chapterPosition, state.chapterDuration),
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
