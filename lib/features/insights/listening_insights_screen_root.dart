import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/di/injection.dart';
import 'cubits/listening_insights_cubit.dart';
import 'cubits/insights_cubits.dart';
import 'ui/listening_insights_screen.dart';

class ListeningInsightsScreenRoot extends StatelessWidget {
  const ListeningInsightsScreenRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ListeningInsightsCubit>(
      create: (_) => getIt<ListeningInsightsCubit>()..load(),
      child: BlocBuilder<ListeningInsightsCubit, ListeningInsightsState>(
        builder: (context, state) {
          final cubit = context.read<ListeningInsightsCubit>();
          return ListeningInsightsScreen(
            state: state,
            onRetry: cubit.load,
            onPeriodSelected: cubit.selectPeriod,
          );
        },
      ),
    );
  }
}
