part of '../library_screen.dart';

class _LibraryViewButton extends StatelessWidget {
  const _LibraryViewButton({required this.state});

  final LibraryState state;

  @override
  Widget build(BuildContext context) {
    final customized =
        state.filter != LibraryFilter.all ||
        state.grouping != LibraryGrouping.none ||
        state.sort != LibrarySort.recent;
    return IconButton(
      tooltip: 'Filter and organize library',
      onPressed: () => _showLibraryViewSheet(context),
      icon: Badge(
        isLabelVisible: customized,
        smallSize: 7,
        child: const Icon(Icons.tune_rounded),
      ),
    );
  }
}

Future<void> _showLibraryViewSheet(BuildContext context) {
  final cubit = context.read<LibraryCubit>();
  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (_) =>
        BlocProvider.value(value: cubit, child: const _LibraryViewSheet()),
  );
}

class _LibraryViewSheet extends StatelessWidget {
  const _LibraryViewSheet();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: BlocBuilder<LibraryCubit, LibraryState>(
        builder: (context, state) => Padding(
          padding: const EdgeInsets.fromLTRB(24, 4, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Library view',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 18),
              _LibraryViewDropdown<LibraryFilter>(
                label: 'Show',
                value: state.filter,
                values: LibraryFilter.values,
                text: _filterLabel,
                onChanged: context.read<LibraryCubit>().setFilter,
              ),
              const SizedBox(height: 12),
              _LibraryViewDropdown<LibraryGrouping>(
                label: 'Group by',
                value: state.grouping,
                values: LibraryGrouping.values,
                text: _groupingLabel,
                onChanged: context.read<LibraryCubit>().setGrouping,
              ),
              const SizedBox(height: 12),
              _LibraryViewDropdown<LibrarySort>(
                label: 'Sort by',
                value: state.sort,
                values: LibrarySort.values,
                text: _sortLabel,
                onChanged: context.read<LibraryCubit>().setSort,
              ),
              const SizedBox(height: 18),
              SegmentedButton<LibraryLayout>(
                segments: const [
                  ButtonSegment(
                    value: LibraryLayout.list,
                    icon: Icon(Icons.view_list_rounded),
                    label: Text('List'),
                  ),
                  ButtonSegment(
                    value: LibraryLayout.grid,
                    icon: Icon(Icons.grid_view_rounded),
                    label: Text('Grid'),
                  ),
                ],
                selected: {state.layout},
                onSelectionChanged: (selection) =>
                    context.read<LibraryCubit>().setLayout(selection.first),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LibraryViewDropdown<T> extends StatelessWidget {
  const _LibraryViewDropdown({
    required this.label,
    required this.value,
    required this.values,
    required this.text,
    required this.onChanged,
  });

  final String label;
  final T value;
  final List<T> values;
  final String Function(T value) text;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      key: ValueKey(value),
      initialValue: value,
      decoration: InputDecoration(labelText: label),
      items: [
        for (final option in values)
          DropdownMenuItem(value: option, child: Text(text(option))),
      ],
      onChanged: (selection) {
        if (selection != null) {
          onChanged(selection);
        }
      },
    );
  }
}

String _groupingLabel(LibraryGrouping grouping) => switch (grouping) {
  LibraryGrouping.none => 'None',
  LibraryGrouping.listeningStatus => 'Listening status',
  LibraryGrouping.author => 'Author',
  LibraryGrouping.series => 'Series',
  LibraryGrouping.folder => 'Folder',
};
