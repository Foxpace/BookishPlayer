import 'package:flutter/material.dart';

import '../../../../core/presentation/book_cover.dart';
import '../../models/library_models.dart';
import '../../cubits/library_intents.dart';
import 'book_progress_summary.dart';
import 'book_actions_menu.dart';

class BookTile extends StatelessWidget {
  const BookTile({
    required this.book,
    required this.onOpen,
    required this.onLongPress,
    required this.onAction,
    super.key,
  });

  final Audiobook book;
  final VoidCallback onOpen;
  final VoidCallback onLongPress;
  final ValueChanged<BookAction> onAction;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onOpen,
        onLongPress: onLongPress,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              BookCover(
                title: book.title,
                artworkPath: book.artworkPath,
                layout: const (
                  size: 64,
                  heightFactor: 1.22,
                  imageFit: BoxFit.contain,
                ),
                heroTag: book.id,
              ),
              const SizedBox(width: 16),
              Expanded(child: _BookListDetails(book: book)),
              const SizedBox(width: 8),
              BookActionsMenu(book: book, onSelected: onAction),
            ],
          ),
        ),
      ),
    );
  }
}

class _BookListDetails extends StatelessWidget {
  const _BookListDetails({required this.book});

  final Audiobook book;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          book.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 9),
        BookProgressSummary(book: book),
      ],
    );
  }
}
