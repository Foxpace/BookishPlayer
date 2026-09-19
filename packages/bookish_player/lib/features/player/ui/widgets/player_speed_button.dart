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
    return Semantics(
      expanded: false,
      child: Tooltip(
        message: S.of(context).playbackSpeed,
        child: InkWell(
          canRequestFocus: true,
          enableFeedback: true,
          onTap: () => _showSpeedSheet(context),
          child: PlayerToolVisual(
            icon: Icons.speed_rounded,
            label: _formattedSpeed(speed),
          ),
        ),
      ),
    );
  }

  Future<void> _showSpeedSheet(BuildContext context) async {
    final selectedSpeed = await showModalBottomSheet<double>(
      context: context,
      showDragHandle: true,
      builder: (context) => _PlaybackSpeedSheet(selectedSpeed: speed),
    );
    if (selectedSpeed != null && selectedSpeed != speed) {
      onChanged(selectedSpeed);
    }
  }

  static String _formattedSpeed(double value) =>
      '${value == .75 ? '0.75' : value.toStringAsFixed(1)}×';

  static String _presetName(BuildContext context, double value) =>
      switch (value) {
        .75 => S.of(context).speedRelaxed,
        1.0 => S.of(context).speedNatural,
        1.25 => S.of(context).speedFocused,
        1.5 => S.of(context).speedBrisk,
        1.75 => S.of(context).speedFast,
        _ => S.of(context).speedVeryFast,
      };
}

class _PlaybackSpeedSheet extends StatelessWidget {
  const _PlaybackSpeedSheet({required this.selectedSpeed});

  final double selectedSpeed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: Text(
                S.of(context).playbackSpeed,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            for (final value in PlayerSpeedButton.speeds)
              ListTile(
                key: ValueKey('playback-speed-$value'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                selected: value == selectedSpeed,
                leading: Icon(
                  value == selectedSpeed
                      ? Icons.check_circle_rounded
                      : Icons.circle_outlined,
                ),
                title: Text(PlayerSpeedButton._presetName(context, value)),
                trailing: Text(
                  PlayerSpeedButton._formattedSpeed(value),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                onTap: () => Navigator.pop(context, value),
              ),
          ],
        ),
      ),
    );
  }
}
