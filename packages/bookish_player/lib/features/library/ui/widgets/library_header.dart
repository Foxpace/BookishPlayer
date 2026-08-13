import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';

class LibraryHeader extends StatelessWidget {
  const LibraryHeader({
    required this.onOpenNotes,
    required this.onOpenSettings,
    super.key,
  });

  final VoidCallback onOpenNotes;
  final VoidCallback onOpenSettings;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'BOOKISH',
                style: Theme.of(
                  context,
                ).textTheme.labelSmall?.copyWith(letterSpacing: 3),
              ),
              const SizedBox(height: 5),
              Text(
                S.of(context).yourLibrary,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton.filledTonal(
              tooltip: S.of(context).notesGallery,
              onPressed: onOpenNotes,
              icon: const Icon(Icons.collections_bookmark_outlined),
            ),
            const SizedBox(width: 8),
            IconButton.filledTonal(
              tooltip: S.of(context).settingsTitle,
              onPressed: onOpenSettings,
              icon: const Icon(Icons.settings_outlined),
            ),
          ],
        ),
      ],
    );
  }
}
