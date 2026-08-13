import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';

class PlayerNotesHeader extends StatelessWidget {
  const PlayerNotesHeader({
    required this.hasNotes,
    required this.actions,
    super.key,
  });

  final bool hasNotes;
  final ({
    VoidCallback onAddBookmark,
    VoidCallback onAddVoiceNote,
    VoidCallback onAddNote,
    VoidCallback onExport,
  })
  actions;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            S.of(context).notesAndBookmarksTitle,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        IconButton.filledTonal(
          tooltip: S.of(context).addBookmarkAtCurrentPosition,
          onPressed: actions.onAddBookmark,
          icon: const Icon(Icons.bookmark_add_rounded),
        ),
        const SizedBox(width: 6),
        IconButton.filledTonal(
          tooltip: S.of(context).dictateVoiceNote,
          onPressed: actions.onAddVoiceNote,
          icon: const Icon(Icons.mic_rounded),
        ),
        const SizedBox(width: 6),
        IconButton.filledTonal(
          tooltip: S.of(context).addNoteAtCurrentPosition,
          onPressed: actions.onAddNote,
          icon: const Icon(Icons.add_rounded),
        ),
        IconButton(
          tooltip: S.of(context).exportNotes,
          onPressed: hasNotes ? actions.onExport : null,
          icon: const Icon(Icons.ios_share_rounded),
        ),
      ],
    );
  }
}
