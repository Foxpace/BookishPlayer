import 'package:material_ui/material_ui.dart';

import '../../../core/presentation/bottom_overlay_space.dart';
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
    final miniPlayerBook =
        behavior.showMiniPlayer && state.status != PlayerStatus.failure
        ? book
        : null;
    final bottomOverlayHeight = miniPlayerBook != null
        ? NowPlayingBar.contentHeight + MediaQuery.paddingOf(context).bottom
        : 0.0;
    return Stack(
      children: [
        Positioned.fill(
          child: BottomOverlaySpace(height: bottomOverlayHeight, child: child),
        ),
        if (miniPlayerBook != null)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: NowPlayingBar(
              state: state,
              book: miniPlayerBook,
              onOpen: behavior.onOpenPlayer,
              onTogglePlayback: behavior.onTogglePlayback,
            ),
          ),
      ],
    );
  }
}
