import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/navigation/app_router.dart';
import '../../../core/presentation/book_cover.dart';
import 'player_cubit.dart';
import 'player_state.dart';

class NowPlayingShell extends StatelessWidget {
  const NowPlayingShell({
    required this.child,
    required this.showMiniPlayer,
    super.key,
  });

  final Widget child;
  final bool showMiniPlayer;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: child),
        if (showMiniPlayer)
          BlocBuilder<PlayerCubit, PlayerState>(
            buildWhen: (previous, current) =>
                previous.book != current.book ||
                previous.status != current.status ||
                previous.isPlaying != current.isPlaying ||
                previous.currentChapter != current.currentChapter ||
                previous.position != current.position ||
                previous.duration != current.duration,
            builder: (context, state) {
              if (state.book == null || state.status == PlayerStatus.failure) {
                return const SizedBox.shrink();
              }
              return _NowPlayingBar(state: state);
            },
          ),
      ],
    );
  }
}

class _NowPlayingBar extends StatelessWidget {
  const _NowPlayingBar({required this.state});

  final PlayerState state;

  @override
  Widget build(BuildContext context) {
    final book = state.book!;
    final progress = state.duration > Duration.zero
        ? (state.position.inMilliseconds / state.duration.inMilliseconds).clamp(
            0.0,
            1.0,
          )
        : 0.0;
    return Material(
      color: Theme.of(context).colorScheme.surfaceContainer,
      elevation: 12,
      child: SafeArea(
        top: false,
        child: InkWell(
          onTap: () => context.pushNamed<void>(
            AppRoutes.player,
            pathParameters: {'bookId': book.id},
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LinearProgressIndicator(value: progress, minHeight: 2),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 8, 10),
                child: Row(
                  children: [
                    BookCover(
                      title: book.title,
                      artworkPath: book.artworkPath,
                      size: 44,
                      heightFactor: 1,
                      imageFit: BoxFit.cover,
                    ),
                    const SizedBox(width: 12),
                    Expanded(child: _NowPlayingDetails(state: state)),
                    if (state.status == PlayerStatus.loading)
                      const Padding(
                        padding: EdgeInsets.all(12),
                        child: SizedBox.square(
                          dimension: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                    else
                      IconButton(
                        tooltip: state.isPlaying ? 'Pause' : 'Play',
                        onPressed: () => unawaited(
                          context.read<PlayerCubit>().togglePlayback(),
                        ),
                        icon: Icon(
                          state.isPlaying
                              ? Icons.pause_rounded
                              : Icons.play_arrow_rounded,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NowPlayingDetails extends StatelessWidget {
  const _NowPlayingDetails({required this.state});

  final PlayerState state;

  @override
  Widget build(BuildContext context) {
    final chapterTitle = state.currentChapter?.title;
    final status = state.isPlaying ? 'Playing' : 'Paused';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          state.book!.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 2),
        Text(
          chapterTitle == null ? status : '$status · $chapterTitle',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
