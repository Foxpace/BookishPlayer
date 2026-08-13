import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../../cubits/player_cubits.dart';

class NowPlayingPlaybackControl extends StatelessWidget {
  const NowPlayingPlaybackControl({
    required this.status,
    required this.isPlaying,
    required this.onTogglePlayback,
    super.key,
  });

  final PlayerStatus status;
  final bool isPlaying;
  final VoidCallback onTogglePlayback;

  @override
  Widget build(BuildContext context) {
    if (status == PlayerStatus.loading) {
      return const Padding(
        padding: EdgeInsets.all(12),
        child: SizedBox.square(
          dimension: 24,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }
    return IconButton(
      tooltip: isPlaying ? S.of(context).pause : S.of(context).play,
      onPressed: onTogglePlayback,
      icon: Icon(isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded),
    );
  }
}
