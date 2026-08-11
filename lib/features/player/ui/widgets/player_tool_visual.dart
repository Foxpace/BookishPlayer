import 'package:flutter/material.dart';

class PlayerToolVisual extends StatelessWidget {
  const PlayerToolVisual({
    required this.icon,
    required this.label,
    this.showBadge = false,
    this.badgeLabel,
    super.key,
  });

  final IconData icon;
  final String label;
  final bool showBadge;
  final String? badgeLabel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Badge(
            isLabelVisible: showBadge || badgeLabel != null,
            label: switch (badgeLabel) {
              final label? => Text(label),
              null => null,
            },
            child: Icon(icon, size: 27),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}
