import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/navigation/app_router.dart';
import '../../../core/di/injection.dart';
import '../../../core/presentation/book_cover.dart';
import '../../../core/presentation/formatters.dart';
import '../../settings/data/settings_dao.dart';
import '../domain/audiobook.dart';
import 'library_cubit.dart';
import 'library_state.dart';

enum _LibraryLayout { list, grid }

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final _settings = getIt<SettingsDao>();
  var _layout = _LibraryLayout.list;

  @override
  void initState() {
    super.initState();
    unawaited(_restoreLayout());
  }

  Future<void> _restoreLayout() async {
    try {
      final saved = await _settings.getLibraryLayout();
      if (mounted) {
        setState(() {
          _layout = saved == _LibraryLayout.grid.name
              ? _LibraryLayout.grid
              : _LibraryLayout.list;
        });
      }
    } catch (_) {
      // Keep the default list layout if preferences cannot be read.
    }
  }

  void _selectLayout(Set<_LibraryLayout> selection) {
    final layout = selection.first;
    setState(() => _layout = layout);
    unawaited(_persistLayout(layout));
  }

  Future<void> _persistLayout(_LibraryLayout layout) async {
    try {
      await _settings.setLibraryLayout(layout.name);
    } catch (_) {
      // The selected layout still remains active for this session.
    }
  }

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
                        child: Row(
                          children: [
                            _LibraryGroupingControl(grouping: state.grouping),
                            const Spacer(),
                            SegmentedButton<_LibraryLayout>(
                              segments: const [
                                ButtonSegment(
                                  value: _LibraryLayout.list,
                                  icon: Icon(Icons.view_list_rounded),
                                  tooltip: 'List view',
                                ),
                                ButtonSegment(
                                  value: _LibraryLayout.grid,
                                  icon: Icon(Icons.grid_view_rounded),
                                  tooltip: 'Grid view',
                                ),
                              ],
                              selected: {_layout},
                              showSelectedIcon: false,
                              onSelectionChanged: _selectLayout,
                            ),
                          ],
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
                          layout: _layout,
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

class _LibrarySectionView extends StatelessWidget {
  const _LibrarySectionView({
    required this.section,
    required this.showTitle,
    required this.layout,
  });

  final LibrarySection section;
  final bool showTitle;
  final _LibraryLayout layout;

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
        if (layout == _LibraryLayout.list)
          for (var index = 0; index < section.books.length; index++) ...[
            if (index > 0) const SizedBox(height: 12),
            _BookTile(book: section.books[index]),
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
            itemBuilder: (context, index) =>
                _BookGridTile(book: section.books[index]),
          ),
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

class _BookGridTile extends StatelessWidget {
  const _BookGridTile({required this.book});

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
        onTap: () => _openBook(context, book),
        onLongPress: () => _confirmDelete(context, book),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final coverSize = constraints.maxWidth - 24;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                  child: Center(
                    child: BookCover(
                      title: book.title,
                      artworkPath: book.artworkPath,
                      size: coverSize,
                      heroTag: book.id,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                book.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.titleSmall
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                            ),
                            _BookActionsMenu(book: book, compact: true),
                          ],
                        ),
                        const Spacer(),
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
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
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
        onTap: () => _openBook(context, book),
        onLongPress: () => _confirmDelete(context, book),
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
              _BookActionsMenu(book: book),
            ],
          ),
        ),
      ),
    );
  }
}

class _BookActionsMenu extends StatelessWidget {
  const _BookActionsMenu({required this.book, this.compact = false});

  final Audiobook book;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final button = PopupMenuButton<String>(
      tooltip: 'Book actions',
      padding: EdgeInsets.zero,
      iconSize: compact ? 20 : 24,
      onSelected: (action) async {
        if (action == 'title') {
          await _showFullTitle(context, book);
        } else if (action == 'edit') {
          await context.pushNamed<void>(
            AppRoutes.editBook,
            pathParameters: {'bookId': book.id},
          );
          if (context.mounted) {
            await context.read<LibraryCubit>().load();
          }
        } else if (action == 'delete' && context.mounted) {
          await _confirmDelete(context, book);
        }
      },
      itemBuilder: (_) => const [
        PopupMenuItem(value: 'title', child: Text('View full title')),
        PopupMenuItem(value: 'edit', child: Text('Edit metadata')),
        PopupMenuItem(value: 'delete', child: Text('Remove from device')),
      ],
    );
    return compact ? SizedBox.square(dimension: 40, child: button) : button;
  }
}

Future<void> _openBook(BuildContext context, Audiobook book) async {
  await context.pushNamed<void>(
    AppRoutes.player,
    pathParameters: {'bookId': book.id},
  );
  if (context.mounted) {
    await context.read<LibraryCubit>().load();
  }
}

Future<void> _showFullTitle(BuildContext context, Audiobook book) async {
  await showDialog<void>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Full title'),
      content: SelectableText(book.title),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext),
          child: const Text('Close'),
        ),
      ],
    ),
  );
}

Future<void> _confirmDelete(BuildContext context, Audiobook book) async {
  final shouldDelete = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Remove from this device?'),
      content: Text(
        '“${book.title}”, its notes, cover, and copied audio files will be '
        'deleted from Bookish. Your original files are not affected.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext, false),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(dialogContext, true),
          child: const Text('Remove from device'),
        ),
      ],
    ),
  );
  if (shouldDelete == true && context.mounted) {
    await context.read<LibraryCubit>().deleteBook(book);
  }
}
