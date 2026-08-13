import 'package:flutter/material.dart';

import '../../cubits/player_cubits.dart';

class ChapterTile extends StatelessWidget {
  const ChapterTile({
    required this.chapter,
    required this.status,
    required this.onTap,
    super.key,
  });

  final PlayerChapter chapter;
  final ({int index, Duration position, bool active}) status;
  final VoidCallback onTap;

  double get _progress {
    final end = chapter.start + chapter.duration;
    if (status.position <= chapter.start || chapter.duration == Duration.zero) {
      return 0;
    }
    if (status.position >= end) {
      return 1;
    }
    return ((status.position - chapter.start).inMilliseconds /
            chapter.duration.inMilliseconds)
        .clamp(0, 1);
  }

  @override
  Widget build(BuildContext context) {
    final progress = _progress;
    return Card(
      color: status.active
          ? Theme.of(context).colorScheme.primaryContainer
          : null,
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(child: Text('${status.index + 1}')),
        title: Text(
          chapter.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: LinearProgressIndicator(value: progress),
        ),
        trailing: Text('${(progress * 100).round()}%'),
      ),
    );
  }
}
