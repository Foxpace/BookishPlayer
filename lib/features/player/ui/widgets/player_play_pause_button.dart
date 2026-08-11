import 'package:flutter/material.dart';

import '../../cubits/player_cubits.dart';

class PlayerPlayPauseButton extends StatelessWidget {
  const PlayerPlayPauseButton({
    required this.state,
    required this.onPressed,
    super.key,
  });

  final PlayerState state;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: OverflowBox(
        minWidth: 0,
        minHeight: 0,
        maxWidth: 72,
        maxHeight: 72,
        child: SizedBox.square(
          dimension: 72,
          child: FilledButton(
            onPressed: state.status == PlayerStatus.ready ? onPressed : null,
            style: FilledButton.styleFrom(
              shape: const CircleBorder(),
              padding: EdgeInsets.zero,
            ),
            child: state.status == PlayerStatus.loading
                ? const SizedBox.square(
                    dimension: 26,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Icon(
                    state.isPlaying
                        ? Icons.pause_rounded
                        : Icons.play_arrow_rounded,
                    size: 40,
                  ),
          ),
        ),
      ),
    );
  }
}
