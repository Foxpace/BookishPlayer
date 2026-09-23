import 'package:material_ui/material_ui.dart';

import '../../../core/localization/generated/l10n.dart';
import '../../../core/presentation/formatters.dart';

extension PlayerSeekUi on BuildContext {
  Future<bool> confirmLargeSeek(Duration distance) async {
    final confirmed = await showDialog<bool>(
      context: this,
      builder: (dialogContext) => AlertDialog(
        title: Text(S.of(this).jumpToPositionQuestion),
        content: Text(
          distance.isNegative
              ? S.of(this).largeSeekBackward(formatDuration(distance.abs()))
              : S.of(this).largeSeekForward(formatDuration(distance.abs())),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(S.of(this).cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(S.of(this).jump),
          ),
        ],
      ),
    );
    return confirmed == true && mounted;
  }
}
