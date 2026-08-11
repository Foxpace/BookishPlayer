import 'package:flutter/material.dart';

import '../../../../core/presentation/book_cover.dart';
import '../../models/library_models.dart';
import '../../cubits/library_intents.dart';
import 'book_progress_summary.dart';
import 'book_actions_menu.dart';

class BookGridTile extends StatelessWidget {
  const BookGridTile({
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
        child: LayoutBuilder(
          builder: (context, constraints) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                child: Center(
                  child: BookCover(
                    title: book.title,
                    artworkPath: book.artworkPath,
                    layout: (
                      size: constraints.maxWidth - 24,
                      heightFactor: 1.22,
                      imageFit: BoxFit.contain,
                    ),
                    heroTag: book.id,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: _GridBookDetails(book: book, onAction: onAction),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GridBookDetails extends StatelessWidget {
  const _GridBookDetails({required this.book, required this.onAction});

  final Audiobook book;
  final ValueChanged<BookAction> onAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              BookActionsMenu(book: book, compact: true, onSelected: onAction),
            ],
          ),
          const Spacer(),
          BookProgressSummary(book: book, singleLine: true),
        ],
      ),
    );
  }
}
