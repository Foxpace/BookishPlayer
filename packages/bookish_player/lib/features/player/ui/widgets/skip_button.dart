import 'package:flutter/material.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({
    required this.label,
    required this.onPressed,
    this.flipIcon = false,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;
  final bool flipIcon;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onPressed,
      radius: 30,
      child: SizedBox.square(
        dimension: 56,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Transform.flip(
              flipX: flipIcon,
              child: const Icon(Icons.replay_rounded, size: 50),
            ),
            Transform.translate(
              key: ValueKey(
                flipIcon ? 'forward-skip-label' : 'rewind-skip-label',
              ),
              offset: Offset(flipIcon ? -0.5 : 0.5, 3.5),
              child: Text(
                label,
                textScaler: TextScaler.noScaling,
                style: const TextStyle(
                  fontSize: 10,
                  height: 1,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
