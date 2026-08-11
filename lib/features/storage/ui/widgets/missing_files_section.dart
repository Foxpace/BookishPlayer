import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../../../library/models/library_models.dart';
import 'storage_section_title.dart';

class MissingFilesSection extends StatelessWidget {
  const MissingFilesSection({
    required this.bookIds,
    required this.booksById,
    required this.onRemove,
    super.key,
  });

  final List<String> bookIds;
  final Map<String, Audiobook> booksById;
  final void Function(String id, String title) onRemove;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StorageSectionTitle(
          title: S.of(context).missingFiles,
          count: bookIds.length,
        ),
        if (bookIds.isEmpty)
          ListTile(title: Text(S.of(context).allLibraryFilesAvailable))
        else
          for (final id in bookIds)
            Card(
              child: ListTile(
                title: Text(booksById[id]?.title ?? S.of(context).unknownBook),
                subtitle: Text(S.of(context).missingAudioDescription),
                trailing: IconButton(
                  tooltip: S.of(context).removeMissingLibraryEntry,
                  icon: const Icon(Icons.delete_outline_rounded),
                  onPressed: () => onRemove(
                    id,
                    booksById[id]?.title ?? S.of(context).thisBook,
                  ),
                ),
              ),
            ),
      ],
    );
  }
}
