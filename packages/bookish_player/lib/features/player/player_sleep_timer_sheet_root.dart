import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubits/player_cubit.dart';
import 'cubits/player_cubits.dart';
import 'ui/widgets/sleep_timer_sheet.dart';

class PlayerSleepTimerSheetRoot extends StatelessWidget {
  const PlayerSleepTimerSheetRoot({required this.cubit, super.key});

  final PlayerCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PlayerCubit>.value(
      value: cubit,
      child: BlocBuilder<PlayerCubit, PlayerState>(
        builder: (context, state) => SleepTimerSheet(
          state: state,
          onSetDuration: (duration) {
            cubit.setSleepTimer(duration);
            Navigator.pop(context);
          },
          onEndOfChapter: () {
            cubit.sleepAtEndOfChapter();
            Navigator.pop(context);
          },
          onCancel: () {
            cubit.cancelSleepTimer();
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
