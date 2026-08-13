import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../../cubits/library_cubits.dart';
import 'library_layout_selector.dart';
import 'library_view_dropdown.dart';

typedef LibraryViewIntents = ({
  ValueChanged<LibraryFilter> filter,
  ValueChanged<LibraryGrouping> grouping,
  ValueChanged<LibrarySort> sort,
  ValueChanged<LibraryLayout> layout,
});

class LibraryViewSheet extends StatelessWidget {
  const LibraryViewSheet({
    required this.state,
    required this.intents,
    super.key,
  });

  final LibraryState state;
  final LibraryViewIntents intents;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 4, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).libraryView,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 18),
            LibraryViewDropdown<LibraryFilter>(
              label: S.of(context).show,
              value: state.filter,
              values: LibraryFilter.values,
              behavior: (
                text: (value) => _filterLabel(context, value),
                changed: intents.filter,
              ),
            ),
            const SizedBox(height: 12),
            LibraryViewDropdown<LibraryGrouping>(
              label: S.of(context).groupBy,
              value: state.grouping,
              values: LibraryGrouping.values,
              behavior: (
                text: (value) => _groupingLabel(context, value),
                changed: intents.grouping,
              ),
            ),
            const SizedBox(height: 12),
            LibraryViewDropdown<LibrarySort>(
              label: S.of(context).sortBy,
              value: state.sort,
              values: LibrarySort.values,
              behavior: (
                text: (value) => _sortLabel(context, value),
                changed: intents.sort,
              ),
            ),
            const SizedBox(height: 18),
            LibraryLayoutSelector(
              layout: state.layout,
              onChanged: intents.layout,
            ),
          ],
        ),
      ),
    );
  }
}

String _groupingLabel(BuildContext context, LibraryGrouping grouping) =>
    switch (grouping) {
      LibraryGrouping.none => S.of(context).none,
      LibraryGrouping.listeningStatus => S.of(context).listeningStatus,
      LibraryGrouping.author => S.of(context).authorField,
      LibraryGrouping.series => S.of(context).seriesField,
      LibraryGrouping.folder => S.of(context).folderField,
    };

String _filterLabel(BuildContext context, LibraryFilter filter) =>
    switch (filter) {
      LibraryFilter.all => S.of(context).allBooks,
      LibraryFilter.wantToListen => S.of(context).wantToListen,
      LibraryFilter.notStarted => S.of(context).notStarted,
      LibraryFilter.inProgress => S.of(context).inProgress,
      LibraryFilter.finished => S.of(context).finished,
      LibraryFilter.favorites => S.of(context).favorites,
    };

String _sortLabel(BuildContext context, LibrarySort sort) => switch (sort) {
  LibrarySort.recent => S.of(context).recentlyAdded,
  LibrarySort.title => S.of(context).titleField,
  LibrarySort.author => S.of(context).authorField,
  LibrarySort.remaining => S.of(context).timeRemaining,
  LibrarySort.added => S.of(context).dateAdded,
};
