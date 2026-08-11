import 'package:flutter/material.dart';

import '../../../../core/presentation/book_cover.dart';
import '../../../library/models/library_models.dart';
import '../../cubits/player_cubits.dart';
import 'now_playing_details.dart';
import 'now_playing_playback_control.dart';

class NowPlayingBar extends StatelessWidget {
  const NowPlayingBar({
    required this.state,
    required this.book,
    required this.onOpen,
    required this.onTogglePlayback,
    super.key,
  });

  final PlayerState state;
  final Audiobook book;
  final VoidCallback onOpen;
  final VoidCallback onTogglePlayback;

  @override
  Widget build(BuildContext context) {
    final progress = state.chapterDuration > Duration.zero
        ? (state.chapterPosition.inMilliseconds /
                  state.chapterDuration.inMilliseconds)
              .clamp(0.0, 1.0)
        : 0.0;
    return Material(
      color: Theme.of(context).colorScheme.surfaceContainer,
      elevation: 12,
      child: SafeArea(
        top: false,
        child: InkWell(
          onTap: onOpen,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LinearProgressIndicator(value: progress, minHeight: 2),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 8, 10),
                child: Row(
                  children: [
                    BookCover(
                      title: book.title,
                      artworkPath: book.artworkPath,
                      layout: const (
                        size: 44,
                        heightFactor: 1,
                        imageFit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: NowPlayingDetails(state: state, book: book),
                    ),
                    NowPlayingPlaybackControl(
                      status: state.status,
                      isPlaying: state.isPlaying,
                      onTogglePlayback: onTogglePlayback,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
