import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../../../library/models/library_models.dart';
import '../../cubits/player_cubits.dart';

class NowPlayingDetails extends StatelessWidget {
  const NowPlayingDetails({required this.state, required this.book, super.key});

  final PlayerState state;
  final Audiobook book;

  @override
  Widget build(BuildContext context) {
    final status = state.isPlaying
        ? S.of(context).playing
        : S.of(context).paused;
    final chapterTitle = state.currentChapter?.title;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          book.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 2),
        Text(
          chapterTitle == null ? status : '$status · $chapterTitle',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
