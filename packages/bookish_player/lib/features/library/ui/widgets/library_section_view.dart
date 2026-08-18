import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../../cubits/library_cubits.dart';
import '../../cubits/library_intents.dart';
import '../../models/library_models.dart';
import 'book_grid_tile.dart';
import 'book_tile.dart';

typedef LibraryBookActions = ({
  ValueChanged<Audiobook> open,
  ValueChanged<Audiobook> remove,
  void Function(Audiobook book, BookAction action) select,
});

class LibrarySectionView extends StatelessWidget {
  const LibrarySectionView({
    required this.section,
    required this.showTitle,
    required this.layout,
    required this.actions,
    super.key,
  });

  final LibrarySection section;
  final bool showTitle;
  final LibraryLayout layout;
  final LibraryBookActions actions;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showTitle)
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 8, 4, 10),
            child: Text(
              _localizeSectionTitle(context, section),
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
        if (layout == LibraryLayout.list)
          for (var index = 0; index < section.books.length; index++) ...[
            if (index > 0) const SizedBox(height: 12),
            BookTile(
              book: section.books[index],
              onOpen: () => actions.open(section.books[index]),
              onLongPress: () => actions.remove(section.books[index]),
              onAction: (action) =>
                  actions.select(section.books[index], action),
            ),
          ]
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 220,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: .54,
            ),
            itemCount: section.books.length,
            itemBuilder: (context, index) => BookGridTile(
              book: section.books[index],
              onOpen: () => actions.open(section.books[index]),
              onLongPress: () => actions.remove(section.books[index]),
              onAction: (action) =>
                  actions.select(section.books[index], action),
            ),
          ),
      ],
    );
  }
}

String _localizeSectionTitle(BuildContext context, LibrarySection section) {
  return switch (section.label) {
    LibrarySectionLabel.wantToListen => S.of(context).wantToListen,
    LibrarySectionLabel.notStarted => S.of(context).notStarted,
    LibrarySectionLabel.listening => S.of(context).listening,
    LibrarySectionLabel.finished => S.of(context).finished,
    LibrarySectionLabel.unknownAuthor => S.of(context).unknownAuthor,
    LibrarySectionLabel.noSeries => S.of(context).noSeries,
    LibrarySectionLabel.imported => S.of(context).imported,
    null => section.title,
  };
}
