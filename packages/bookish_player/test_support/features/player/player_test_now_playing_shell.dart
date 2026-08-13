import 'package:bookish_player/features/player/cubits/player_cubit.dart';
import 'package:bookish_player/features/player/cubits/player_cubits.dart';
import 'package:bookish_player/features/player/ui/now_playing_shell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayerTestNowPlayingShell extends StatelessWidget {
  const PlayerTestNowPlayingShell({
    required this.cubit,
    this.child = const SizedBox.expand(),
    super.key,
  });

  final PlayerCubit cubit;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerCubit, PlayerState>(
      bloc: cubit,
      builder: (_, state) => NowPlayingShell(
        state: state,
        behavior: (
          showMiniPlayer: true,
          onOpenPlayer: () {},
          onTogglePlayback: cubit.togglePlayback,
        ),
        child: child,
      ),
    );
  }
}
