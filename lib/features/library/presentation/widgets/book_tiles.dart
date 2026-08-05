part of '../library_screen.dart';

class _BookGridTile extends StatelessWidget {
  const _BookGridTile({required this.book});

  final Audiobook book;

  @override
  Widget build(BuildContext context) {
    final duration = Duration(milliseconds: book.durationMs);
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
                          book.isFinished
                              ? S.of(context).finishedBook
                              : book.positionMs > 0
                              ? '${(progress * 100).round()}% · ${formatDuration(book.remainingDuration)} left'
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
                      book.isFinished
                          ? S.of(context).finishedBook
                          : book.positionMs > 0
                          ? '${(progress * 100).round()}% · ${formatDuration(book.remainingDuration)} left'
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
        if (action == 'favorite') {
          await context.read<LibraryCubit>().toggleFavorite(book);
        } else if (action == 'want') {
          await context.read<LibraryCubit>().setListeningStatus(
            book,
            ListeningStatus.wantToListen,
          );
        } else if (action == 'finished') {
          await context.read<LibraryCubit>().setListeningStatus(
            book,
            ListeningStatus.finished,
          );
        } else if (action == 'unfinished') {
          await context.read<LibraryCubit>().setListeningStatus(
            book,
            ListeningStatus.inProgress,
          );
        } else if (action == 'automatic') {
          await context.read<LibraryCubit>().setListeningStatus(book, null);
        } else if (action == 'title') {
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
      itemBuilder: (_) => [
        PopupMenuItem(
          value: 'favorite',
          child: Text(book.isFavorite ? 'Remove favorite' : 'Add favorite'),
        ),
        const PopupMenuItem(value: 'want', child: Text('Want to listen')),
        const PopupMenuItem(value: 'finished', child: Text('Mark finished')),
        const PopupMenuItem(
          value: 'unfinished',
          child: Text('Mark unfinished'),
        ),
        if (book.statusOverride != null)
          const PopupMenuItem(
            value: 'automatic',
            child: Text('Use progress status'),
          ),
        const PopupMenuDivider(),
        const PopupMenuItem(value: 'title', child: Text('View full title')),
        const PopupMenuItem(value: 'edit', child: Text('Edit metadata')),
        const PopupMenuItem(value: 'delete', child: Text('Remove from device')),
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
    dismissRestoredRouteFocus();
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
    final removed = await context.read<LibraryCubit>().deleteBook(book);
    if (removed && context.mounted) {
      await context.read<PlayerCubit>().removeBook(book.id);
    }
  }
}
