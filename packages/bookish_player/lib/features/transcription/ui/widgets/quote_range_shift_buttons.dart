import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';

class QuoteRangeShiftButtons extends StatelessWidget {
  const QuoteRangeShiftButtons({
    required this.enabled,
    required this.onShift,
    super.key,
  });

  final bool enabled;
  final ValueChanged<Duration> onShift;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: enabled
                ? () => onShift(const Duration(seconds: -15))
                : null,
            icon: const Icon(Icons.arrow_back_rounded),
            label: Text(S.of(context).secondsEarlier(15)),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: enabled
                ? () => onShift(const Duration(seconds: 15))
                : null,
            icon: const Icon(Icons.arrow_forward_rounded),
            label: Text(S.of(context).secondsLater(15)),
          ),
        ),
      ],
    );
  }
}
