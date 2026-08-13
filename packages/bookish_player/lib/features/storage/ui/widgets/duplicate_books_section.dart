import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../../../library/models/library_models.dart';
import 'storage_section_title.dart';

class DuplicateBooksSection extends StatelessWidget {
  const DuplicateBooksSection({
    required this.groups,
    required this.booksById,
    super.key,
  });

  final List<List<String>> groups;
  final Map<String, Audiobook> booksById;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StorageSectionTitle(
          title: S.of(context).possibleDuplicates,
          count: groups.length,
        ),
        if (groups.isEmpty)
          ListTile(title: Text(S.of(context).noDuplicateBooks))
        else
          for (final group in groups)
            Card(
              child: ListTile(
                leading: const Icon(Icons.copy_all_rounded),
                title: Text(
                  booksById[group.first]?.title ?? S.of(context).duplicateBooks,
                ),
                subtitle: Text(
                  group
                      .map(
                        (id) => booksById[id]?.folder ?? S.of(context).unknown,
                      )
                      .join(' · '),
                ),
              ),
            ),
      ],
    );
  }
}
