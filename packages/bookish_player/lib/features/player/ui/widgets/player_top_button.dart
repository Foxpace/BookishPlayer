import 'package:flutter/material.dart';

class PlayerTopButton extends StatelessWidget {
  const PlayerTopButton({
    required this.tooltip,
    required this.onPressed,
    required this.icon,
    super.key,
  });

  final String tooltip;
  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.square(
        dimension: 44,
        child: IconButton.filledTonal(
          tooltip: tooltip,
          onPressed: onPressed,
          padding: EdgeInsets.zero,
          icon: Icon(icon, size: 24),
        ),
      ),
    );
  }
}
