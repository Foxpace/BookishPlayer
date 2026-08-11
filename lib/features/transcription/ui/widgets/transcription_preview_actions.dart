import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';

class TranscriptionPreviewActions extends StatelessWidget {
  const TranscriptionPreviewActions({
    required this.enabled,
    required this.saving,
    required this.onSave,
    required this.onShare,
    super.key,
  });

  final bool enabled;
  final bool saving;
  final VoidCallback onSave;
  final ValueChanged<BuildContext> onShare;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: enabled && !saving ? onSave : null,
            icon: saving
                ? const SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.bookmark_add_outlined),
            label: Text(S.of(context).saveToNotes),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Builder(
            builder: (buttonContext) => FilledButton.icon(
              onPressed: enabled && !saving
                  ? () => onShare(buttonContext)
                  : null,
              icon: const Icon(Icons.share_outlined),
              label: Text(S.of(context).share),
            ),
          ),
        ),
      ],
    );
  }
}
