import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../../../../core/presentation/book_cover.dart';
import '../../../library/models/library_models.dart';

class MetadataBookCoverEditor extends StatelessWidget {
  const MetadataBookCoverEditor({
    required this.book,
    required this.onChangeCover,
    super.key,
  });

  final Audiobook book;
  final VoidCallback onChangeCover;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          BookCover(
            title: book.title,
            artworkPath: book.artworkPath,
            layout: const (
              size: 110,
              heightFactor: 1.22,
              imageFit: BoxFit.contain,
            ),
          ),
          TextButton.icon(
            onPressed: onChangeCover,
            icon: const Icon(Icons.image_outlined),
            label: Text(S.of(context).changeCover),
          ),
        ],
      ),
    );
  }
}
