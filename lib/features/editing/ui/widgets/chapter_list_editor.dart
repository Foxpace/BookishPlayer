import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../../../../core/presentation/formatters.dart';
import '../../../library/models/library_models.dart';

class ChapterListEditor extends StatelessWidget {
  const ChapterListEditor({
    required this.chapters,
    required this.onAdd,
    required this.onDelete,
    super.key,
  });

  final List<AudioChapter> chapters;
  final VoidCallback onAdd;
  final ValueChanged<AudioChapter> onDelete;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 28),
        Row(
          children: [
            Expanded(
              child: Text(
                S.of(context).chapters,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            IconButton(
              tooltip: S.of(context).addChapter,
              onPressed: onAdd,
              icon: const Icon(Icons.add_rounded),
            ),
          ],
        ),
        for (final chapter in chapters)
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(chapter.title),
            subtitle: Text(
              formatDuration(Duration(milliseconds: chapter.startMs)),
            ),
            trailing: IconButton(
              onPressed: () => onDelete(chapter),
              icon: const Icon(Icons.delete_outline_rounded),
            ),
          ),
      ],
    );
  }
}
