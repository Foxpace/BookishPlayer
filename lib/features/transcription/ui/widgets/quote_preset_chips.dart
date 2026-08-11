import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';

class QuotePresetChips extends StatelessWidget {
  const QuotePresetChips({
    required this.enabled,
    required this.onSelected,
    super.key,
  });

  final bool enabled;
  final ValueChanged<Duration> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [15, 30, 60, 120]
          .map(
            (seconds) => ActionChip(
              label: Text(
                seconds == 120
                    ? S.of(context).lastMinutes(2)
                    : S.of(context).lastSeconds(seconds),
              ),
              onPressed: enabled
                  ? () => onSelected(Duration(seconds: seconds))
                  : null,
            ),
          )
          .toList(),
    );
  }
}
