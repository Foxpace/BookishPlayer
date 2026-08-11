import 'package:flutter/material.dart';

import '../../../library/models/library_models.dart';
import '../../cubits/player_cubits.dart';
import '../../cubits/player_ui_intents.dart';
import 'player_artwork.dart';
import 'player_details.dart';

class PlayerContent extends StatelessWidget {
  const PlayerContent({
    required this.state,
    required this.book,
    required this.intents,
    required this.actions,
    super.key,
  });

  final PlayerState state;
  final Audiobook book;
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
    return LayoutBuilder(
      builder: (context, constraints) {
        final landscape = constraints.maxWidth > constraints.maxHeight;
        final artwork = PlayerArtwork(book: book);
        final details = PlayerDetails(
          state: state,
          presentation: (book: book, compact: landscape),
          intents: intents,
          actions: actions,
        );
        return landscape
            ? Padding(
                padding: const EdgeInsets.fromLTRB(28, 8, 28, 12),
                child: Row(
                  children: [
                    Expanded(flex: 4, child: artwork),
                    const SizedBox(width: 28),
                    Expanded(flex: 7, child: _LandscapeDetails(child: details)),
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.fromLTRB(28, 18, 28, 22),
                child: Column(
                  children: [
                    Expanded(child: artwork),
                    const SizedBox(height: 24),
                    details,
                  ],
                ),
              );
      },
    );
  }
}

class _LandscapeDetails extends StatelessWidget {
  const _LandscapeDetails({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: SizedBox(width: constraints.maxWidth, child: child),
        ),
      ),
    );
  }
}
