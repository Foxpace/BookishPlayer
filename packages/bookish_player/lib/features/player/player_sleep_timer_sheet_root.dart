import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubits/player_cubit.dart';
import 'cubits/player_cubits.dart';
import 'cubits/sleep_timer_duration_cubit.dart';
import 'ui/widgets/sleep_timer_sheet.dart';

class PlayerSleepTimerSheetRoot extends StatelessWidget {
  const PlayerSleepTimerSheetRoot({required this.cubit, super.key});

  final PlayerCubit cubit;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PlayerCubit>.value(value: cubit),
        BlocProvider<SleepTimerDurationCubit>(
          create: (_) => SleepTimerDurationCubit(
            remainingMinutes: cubit.state.sleepRemainingMinutes,
          ),
        ),
      ],
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
