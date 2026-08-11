import 'package:flutter/material.dart';

import 'player_tool_visual.dart';

class PlayerToolButton extends StatelessWidget {
  const PlayerToolButton({
    required this.content,
    required this.onPressed,
    this.showBadge = false,
    this.badgeLabel,
    super.key,
  });

  final ({String tooltip, IconData icon, String label}) content;
  final VoidCallback? onPressed;
  final bool showBadge;
  final String? badgeLabel;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: content.tooltip,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Opacity(
          opacity: onPressed == null ? .38 : 1,
          child: PlayerToolVisual(
            icon: content.icon,
            label: content.label,
            showBadge: showBadge,
            badgeLabel: badgeLabel,
          ),
        ),
      ),
    );
  }
}
