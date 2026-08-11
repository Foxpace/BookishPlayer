import 'package:flutter/material.dart';

import '../../../../core/presentation/formatters.dart';
import '../../cubits/player_cubits.dart';

class PlayerTimeline extends StatefulWidget {
  const PlayerTimeline({required this.state, required this.onSeek, super.key});

  final PlayerState state;
  final ValueChanged<Duration> onSeek;

  @override
  State<PlayerTimeline> createState() => _TimelineState();
}

class _TimelineState extends State<PlayerTimeline> {
  double? _dragValue;

  @override
  void didUpdateWidget(covariant PlayerTimeline oldWidget) {
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
          _ChapterTimelineHeader(
            title: chapter.title,
            current: state.currentChapterIndex + 1,
            count: state.chapterCount,
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
          onChangeEnd: (next) async {
            setState(() => _dragValue = null);
            widget.onSeek(Duration(milliseconds: next.round()));
          },
        ),
        _TimelinePositionLabels(
          position: state.chapterPosition,
          duration: state.chapterDuration,
          speed: state.speed,
        ),
      ],
    );
  }
}

class _ChapterTimelineHeader extends StatelessWidget {
  const _ChapterTimelineHeader({
    required this.title,
    required this.current,
    required this.count,
  });

  final String title;
  final int current;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          '$current / $count',
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _TimelinePositionLabels extends StatelessWidget {
  const _TimelinePositionLabels({
    required this.position,
    required this.duration,
    required this.speed,
  });

  final Duration position;
  final Duration duration;
  final double speed;

  @override
  Widget build(BuildContext context) {
    final remaining = Duration(
      milliseconds: ((duration - position).inMilliseconds / speed).round(),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            formatDuration(position),
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Text(
            '-${formatDuration(remaining)}',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
