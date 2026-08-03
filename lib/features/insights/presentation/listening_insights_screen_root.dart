import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/injection.dart';
import 'listening_insights_cubit.dart';
import 'listening_insights_screen.dart';

class ListeningInsightsScreenRoot extends StatelessWidget {
  const ListeningInsightsScreenRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ListeningInsightsCubit>()..load(),
      child: const ListeningInsightsScreen(),
    );
  }
}
