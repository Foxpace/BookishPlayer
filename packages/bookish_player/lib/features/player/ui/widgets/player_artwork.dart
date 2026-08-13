import 'package:flutter/material.dart';

import '../../../../core/presentation/book_cover.dart';
import '../../../library/models/library_models.dart';

class PlayerArtwork extends StatelessWidget {
  const PlayerArtwork({required this.book, super.key});

  final Audiobook book;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest.shortestSide.clamp(150.0, 290.0);
        return Center(
          child: BookCover(
            title: book.title,
            artworkPath: book.artworkPath,
            layout: (size: size, heightFactor: 1, imageFit: BoxFit.contain),
            heroTag: book.id,
          ),
        );
      },
    );
  }
}
