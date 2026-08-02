import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/navigation/app_router.dart';
import '../../../core/presentation/book_cover.dart';
import '../../../core/presentation/formatters.dart';
import '../domain/audiobook.dart';
import 'library_cubit.dart';
import 'library_state.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LibraryCubit, LibraryState>(
      listenWhen: (previous, current) =>
          current.message != null && previous.message != current.message,
      listener: (context, state) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(state.message!)));
        context.read<LibraryCubit>().clearMessage();
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          tooltip: 'Import audiobooks',
          onPressed: () => _importAudiobooks(context),
          child: const Icon(Icons.add_rounded),
        ),
        body: SafeArea(
          child: BlocBuilder<LibraryCubit, LibraryState>(
            builder: (context, state) {
              if (state.status == LibraryStatus.loading &&
                  state.books.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              return CustomScrollView(
                slivers: [
                  const SliverPadding(
                    padding: EdgeInsets.fromLTRB(24, 28, 24, 20),
                    sliver: SliverToBoxAdapter(child: _Header()),
                  ),
                  if (state.books.isNotEmpty)
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                      sliver: SliverToBoxAdapter(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: _LibraryGroupingControl(
                            grouping: state.grouping,
                          ),
                        ),
                      ),
                    ),
                  if (state.books.isEmpty)
                    const SliverFillRemaining(
                      hasScrollBody: false,
                      child: _EmptyLibrary(),
                    )
                  else
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
                      sliver: SliverList.separated(
                        itemCount: state.sections.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 12),
                        itemBuilder: (context, index) => _LibrarySectionView(
                          section: state.sections[index],
                          showTitle: state.grouping != LibraryGrouping.none,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

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

class _LibraryGroupingControl extends StatelessWidget {
  const _LibraryGroupingControl({required this.grouping});

  final LibraryGrouping grouping;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<LibraryGrouping>(
      tooltip: 'Organize library',
      initialValue: grouping,
      onSelected: context.read<LibraryCubit>().setGrouping,
      itemBuilder: (_) => const [
        PopupMenuItem(value: LibraryGrouping.none, child: Text('Recent')),
        PopupMenuItem(
          value: LibraryGrouping.listeningStatus,
          child: Text('Listening status'),
        ),
        PopupMenuItem(value: LibraryGrouping.author, child: Text('Author')),
        PopupMenuItem(value: LibraryGrouping.series, child: Text('Series')),
        PopupMenuItem(value: LibraryGrouping.folder, child: Text('Folder')),
      ],
      child: Chip(
        avatar: const Icon(Icons.tune_rounded, size: 18),
        label: Text(_label),
      ),
    );
  }

  String get _label => switch (grouping) {
    LibraryGrouping.none => 'Recent',
    LibraryGrouping.listeningStatus => 'Listening status',
    LibraryGrouping.author => 'Author',
    LibraryGrouping.series => 'Series',
    LibraryGrouping.folder => 'Folder',
  };
}

Future<void> _importAudiobooks(BuildContext context) async {
  if (Theme.of(context).platform == TargetPlatform.android) {
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
            title: const Text('Choose files'),
            subtitle: const Text(
              'Import from the Files app or another provider',
            ),
            onTap: () => Navigator.pop(sheetContext, ImportSource.files),
          ),
          ListTile(
            leading: const Icon(Icons.cable_rounded),
            title: const Text('Import from Finder'),
            subtitle: const Text('Import audiobooks transferred by USB cable'),
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
  }
}

class _LibrarySectionView extends StatelessWidget {
  const _LibrarySectionView({required this.section, required this.showTitle});

  final LibrarySection section;
  final bool showTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showTitle) ...[
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 8, 4, 10),
            child: Text(
              section.title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
        ],
        for (var index = 0; index < section.books.length; index++) ...[
          if (index > 0) const SizedBox(height: 12),
          _BookTile(book: section.books[index]),
        ],
      ],
    );
  }
}

class _EmptyLibrary extends StatelessWidget {
  const _EmptyLibrary();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(36),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.library_music_outlined,
            size: 64,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 22),
          Text(
            'A quiet shelf, for now',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          Text(
            'Import MP3, M4A, M4B, AAC, FLAC, WAV, OGG, or Opus files from your device or cloud storage.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              height: 1.5,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () => _importAudiobooks(context),
            icon: const Icon(Icons.file_open_outlined),
            label: const Text('Choose audiobooks'),
          ),
        ],
      ),
    );
  }
}

class _BookTile extends StatelessWidget {
  const _BookTile({required this.book});

  final Audiobook book;

  @override
  Widget build(BuildContext context) {
    final duration = Duration(milliseconds: book.durationMs);
    final position = Duration(milliseconds: book.positionMs);
    final progress = book.durationMs == 0
        ? 0.0
        : (book.positionMs / book.durationMs).clamp(0.0, 1.0);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () async {
          await context.pushNamed<void>(
            AppRoutes.player,
            pathParameters: {'bookId': book.id},
          );
          if (context.mounted) {
            await context.read<LibraryCubit>().load();
          }
        },
        onLongPress: () => _confirmDelete(context),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              BookCover(
                title: book.title,
                artworkPath: book.artworkPath,
                size: 64,
                heroTag: book.id,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 9),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 5,
                        backgroundColor: Theme.of(
                          context,
                        ).progressIndicatorTheme.linearTrackColor,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      book.positionMs > 0
                          ? '${(progress * 100).round()}% · ${formatRemaining(position, duration)} left'
                          : formatDuration(duration),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              PopupMenuButton<String>(
                tooltip: 'Book actions',
                onSelected: (action) async {
                  if (action == 'edit') {
                    await context.pushNamed<void>(
                      AppRoutes.editBook,
                      pathParameters: {'bookId': book.id},
                    );
                    if (context.mounted) {
                      await context.read<LibraryCubit>().load();
                    }
                  } else if (action == 'delete' && context.mounted) {
                    await _confirmDelete(context);
                  }
                },
                itemBuilder: (_) => const [
                  PopupMenuItem(value: 'edit', child: Text('Edit metadata')),
                  PopupMenuItem(value: 'delete', child: Text('Remove')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Remove audiobook?'),
        content: Text(
          '“${book.title}” and its notes will be deleted from Bookish.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
    if (shouldDelete == true && context.mounted) {
      await context.read<LibraryCubit>().deleteBook(book);
    }
  }
}
