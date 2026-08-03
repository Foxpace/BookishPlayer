part of '../library_screen.dart';

class _LibrarySearchControls extends StatelessWidget {
  const _LibrarySearchControls({required this.state});

  final LibraryState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchBar(
          hintText: 'Search title, author, narrator, or series',
          leading: const Icon(Icons.search_rounded),
          trailing: [_LibraryViewButton(state: state)],
          onChanged: context.read<LibraryCubit>().setQuery,
        ),
      ],
    );
  }
}

String _filterLabel(LibraryFilter filter) => switch (filter) {
  LibraryFilter.all => 'All',
  LibraryFilter.wantToListen => 'Want to listen',
  LibraryFilter.notStarted => 'Not started',
  LibraryFilter.inProgress => 'Listening',
  LibraryFilter.finished => 'Finished',
  LibraryFilter.favorites => 'Favorites',
};

String _sortLabel(LibrarySort sort) => switch (sort) {
  LibrarySort.recent => 'Recently played',
  LibrarySort.title => 'Title',
  LibrarySort.author => 'Author',
  LibrarySort.remaining => 'Time remaining',
  LibrarySort.added => 'Recently added',
};

class _Header extends StatelessWidget {
  const _Header();

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
                'Your library',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        IconButton.filledTonal(
          tooltip: 'Settings',
          onPressed: () => context.pushNamed(AppRoutes.settings),
          icon: const Icon(Icons.settings_outlined),
        ),
      ],
    );
  }
}

Future<void> _importAudiobooks(BuildContext context) async {
  final isAndroid = Theme.of(context).platform == TargetPlatform.android;
  if (isAndroid) {
    await _openImport(context, ImportSource.files);
    return;
  }
  final source = await showModalBottomSheet<ImportSource>(
    context: context,
    showDragHandle: true,
    builder: (sheetContext) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.folder_open_rounded),
            title: const Text('Copy from Files'),
            subtitle: const Text(
              'Keep the originals and copy them into Bookish',
            ),
            onTap: () => Navigator.pop(sheetContext, ImportSource.files),
          ),
          ListTile(
            leading: const Icon(Icons.cable_rounded),
            title: const Text('Move from Finder transfer'),
            subtitle: const Text(
              'Copy into Bookish, then remove the transferred originals',
            ),
            onTap: () =>
                Navigator.pop(sheetContext, ImportSource.finderTransfer),
          ),
          const SizedBox(height: 8),
        ],
      ),
    ),
  );
  if (source == null || !context.mounted) {
    return;
  }
  await _openImport(context, source);
}

Future<void> _openImport(BuildContext context, ImportSource source) async {
  final imported = await context.pushNamed<bool>(
    AppRoutes.import,
    extra: source,
  );
  if (imported == true && context.mounted) {
    await context.read<LibraryCubit>().load();
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Audiobook imported into Bookish')),
      );
    }
  }
}
