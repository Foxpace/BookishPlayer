import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../../cubits/player_cubits.dart';
import '../../cubits/player_ui_intents.dart';
import 'player_play_pause_button.dart';
import 'skip_button.dart';

class PlayerTransport extends StatelessWidget {
  const PlayerTransport({
    required this.state,
    required this.intents,
    super.key,
  });

  final PlayerState state;
  final PlayerPlaybackIntents intents;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          key: const ValueKey('previous-chapter-slot'),
          child: IconButton(
            tooltip: S.of(context).previousChapter,
            onPressed: state.book?.chapters.isNotEmpty == true
                ? intents.previousChapter
                : null,
            color: Colors.white,
            icon: const Icon(Icons.skip_previous_rounded, size: 38),
          ),
        ),
        Expanded(
          key: const ValueKey('rewind-slot'),
          child: SkipButton(
            label: '${state.playback.rewindSeconds}',
            onPressed: () => intents.skipBy(
              Duration(seconds: -state.playback.rewindSeconds),
            ),
          ),
        ),
        Expanded(
          key: const ValueKey('playback-slot'),
          child: PlayerPlayPauseButton(
            state: state,
            onPressed: intents.togglePlayback,
          ),
        ),
        Expanded(
          key: const ValueKey('forward-slot'),
          child: SkipButton(
            label: '${state.playback.forwardSeconds}',
            flipIcon: true,
            onPressed: () => intents.skipBy(
              Duration(seconds: state.playback.forwardSeconds),
            ),
          ),
        ),
        Expanded(
          key: const ValueKey('next-chapter-slot'),
          child: IconButton(
            tooltip: S.of(context).nextChapter,
            onPressed: state.book?.chapters.isNotEmpty == true
                ? intents.nextChapter
                : null,
            color: Colors.white,
            icon: const Icon(Icons.skip_next_rounded, size: 38),
          ),
        ),
      ],
    );
  }
}
