import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../../../../core/presentation/book_cover.dart';
import '../../../library/models/library_models.dart';
import '../../models/note_models.dart';

class NoteBookCard extends StatelessWidget {
  const NoteBookCard({
    required this.metadata,
    required this.notes,
    required this.onOpen,
    super.key,
  });

  final BookMetadata metadata;
  final List<BookNote> notes;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onOpen,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BookCover(
                title: metadata.title,
                artworkPath: metadata.artworkPath,
                layout: const (
                  size: 82,
                  heightFactor: 1.22,
                  imageFit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _BookNoteSummary(metadata: metadata, notes: notes),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.chevron_right_rounded),
            ],
          ),
        ),
      ),
    );
  }
}

class _BookNoteSummary extends StatelessWidget {
  const _BookNoteSummary({required this.metadata, required this.notes});

  final BookMetadata metadata;
  final List<BookNote> notes;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          metadata.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        if (metadata.author.isNotEmpty)
          Text(metadata.author, maxLines: 1, overflow: TextOverflow.ellipsis),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 6,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            _NoteCount(count: notes.length),
            Text(
              metadata.activeBookId == null
                  ? S.of(context).archived
                  : S.of(context).inLibrary,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
      ],
    );
  }
}

class _NoteCount extends StatelessWidget {
  const _NoteCount({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        '$count ${count == 1 ? 'note' : 'notes'}',
        style: Theme.of(context).textTheme.labelLarge,
      ),
    );
  }
}
