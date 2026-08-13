import 'dart:io';

import 'package:flutter/material.dart';

typedef BookCoverLayout = ({double size, double heightFactor, BoxFit imageFit});

class BookCover extends StatelessWidget {
  const BookCover({
    required this.title,
    this.artworkPath,
    this.layout = const (
      size: 72,
      heightFactor: 1.22,
      imageFit: BoxFit.contain,
    ),
    this.heroTag,
    super.key,
  });

  final String title;
  final String? artworkPath;
  final BookCoverLayout layout;
  final Object? heroTag;

  @override
  Widget build(BuildContext context) {
    final (:size, :heightFactor, :imageFit) = layout;
    final palette = _selectPalette(title);
    const coverRadius = BorderRadius.all(Radius.circular(4));
    final cover = Container(
      width: size,
      height: size * heightFactor,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: coverRadius,
        boxShadow: [
          BoxShadow(
            color: palette.last.withValues(alpha: .25),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: coverRadius,
        child: switch (artworkPath) {
          null => _FallbackCover(size: size, palette: palette),
          final path => Image.file(
            File(path),
            width: size,
            height: size * heightFactor,
            fit: imageFit,
            filterQuality: FilterQuality.high,
            errorBuilder: (_, _, _) =>
                _FallbackCover(size: size, palette: palette),
          ),
        },
      ),
    );
    return switch (heroTag) {
      null => cover,
      final tag => Hero(tag: tag, child: cover),
    };
  }

  List<Color> _selectPalette(String value) {
    const palettes = [
      [Color(0xFFB85C3D), Color(0xFF713729)],
      [Color(0xFF496A69), Color(0xFF263F40)],
      [Color(0xFF8C6B43), Color(0xFF54402C)],
      [Color(0xFF7B637F), Color(0xFF493B50)],
    ];
    return palettes[value.hashCode.abs() % palettes.length];
  }
}

class _FallbackCover extends StatelessWidget {
  const _FallbackCover({required this.size, required this.palette});

  final double size;
  final List<Color> palette;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: palette,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: size * .12,
            top: size * .12,
            bottom: size * .12,
            child: ColoredBox(
              color: Colors.white.withValues(alpha: .35),
              child: const SizedBox(width: 1),
            ),
          ),
          Center(
            child: Icon(
              Icons.auto_stories_rounded,
              color: Colors.white,
              size: size * .38,
            ),
          ),
        ],
      ),
    );
  }
}
