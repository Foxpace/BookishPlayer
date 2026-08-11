import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../../../../core/presentation/book_cover.dart';
import '../../../library/models/library_models.dart';

class BookNotesHeader extends StatelessWidget {
  const BookNotesHeader({
    required this.metadata,
    required this.noteCount,
    super.key,
  });

  final BookMetadata metadata;
  final int noteCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      child: Row(
        children: [
          BookCover(
            title: metadata.title,
            artworkPath: metadata.artworkPath,
            layout: const (
              size: 64,
              heightFactor: 1.22,
              imageFit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  metadata.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(S.of(context).noteCount(noteCount)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
