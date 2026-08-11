import 'package:flutter/material.dart';

import '../../../library/models/library_models.dart';
import '../../cubits/player_cubits.dart';
import '../../cubits/player_ui_intents.dart';
import 'player_controls.dart';
import 'player_timeline.dart';

class PlayerDetails extends StatelessWidget {
  const PlayerDetails({
    required this.state,
    required this.presentation,
    required this.intents,
    required this.actions,
    super.key,
  });

  final PlayerState state;
  final ({Audiobook book, bool compact}) presentation;
  final PlayerPlaybackIntents intents;
  final ({
    ValueChanged<Duration> onTimelineSeek,
    VoidCallback? onPickAudioOutput,
    VoidCallback? onChapters,
    VoidCallback onTimer,
    VoidCallback onNotes,
    VoidCallback onQuote,
  })
  actions;

  @override
  Widget build(BuildContext context) {
    final (:book, :compact) = presentation;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          book.title,
          maxLines: 2,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
            height: 1.2,
          ),
        ),
        SizedBox(height: compact ? 18 : 26),
        PlayerTimeline(state: state, onSeek: actions.onTimelineSeek),
        SizedBox(height: compact ? 12 : 18),
        PlayerTransport(state: state, intents: intents),
        SizedBox(height: compact ? 10 : 18),
        PlayerTools(
          state: state,
          actions: (
            onSpeedChanged: intents.changeSpeed,
            onPickAudioOutput: actions.onPickAudioOutput,
            onChapters: actions.onChapters,
            onTimer: actions.onTimer,
            onNotes: actions.onNotes,
            onQuote: actions.onQuote,
          ),
        ),
      ],
    );
  }
}
