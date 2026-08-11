import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';
import 'player_tool_visual.dart';

class PlayerSpeedButton extends StatelessWidget {
  const PlayerSpeedButton({
    required this.speed,
    required this.onChanged,
    super.key,
  });

  static const speeds = [0.75, 1.0, 1.25, 1.5, 1.75, 2.0];

  final double speed;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<double>(
      tooltip: S.of(context).playbackSpeed,
      initialValue: speed,
      onSelected: onChanged,
      itemBuilder: (_) => speeds
          .map(
            (value) => PopupMenuItem(
              value: value,
              child: Text('${_presetName(context, value)} · $value×'),
            ),
          )
          .toList(),
      child: PlayerToolVisual(
        icon: Icons.speed_rounded,
        label: '${speed == .75 ? '0.75' : speed.toStringAsFixed(1)}×',
      ),
    );
  }

  String _presetName(BuildContext context, double value) => switch (value) {
    .75 => S.of(context).speedRelaxed,
    1.0 => S.of(context).speedNatural,
    1.25 => S.of(context).speedFocused,
    1.5 => S.of(context).speedBrisk,
    1.75 => S.of(context).speedFast,
    _ => S.of(context).speedVeryFast,
  };
}
