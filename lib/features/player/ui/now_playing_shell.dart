import 'package:flutter/material.dart';

import '../cubits/player_cubits.dart';
import 'widgets/now_playing_bar.dart';

class NowPlayingShell extends StatelessWidget {
  const NowPlayingShell({
    required this.child,
    required this.state,
    required this.behavior,
    super.key,
  });

  final Widget child;
  final PlayerState state;
  final ({
    bool showMiniPlayer,
    VoidCallback onOpenPlayer,
    VoidCallback onTogglePlayback,
  })
  behavior;

  @override
  Widget build(BuildContext context) {
    final book = state.book;
    return Column(
      children: [
        Expanded(child: child),
        if (behavior.showMiniPlayer &&
            book != null &&
            state.status != PlayerStatus.failure)
          NowPlayingBar(
            state: state,
            book: book,
            onOpen: behavior.onOpenPlayer,
            onTogglePlayback: behavior.onTogglePlayback,
          ),
      ],
    );
  }
}
