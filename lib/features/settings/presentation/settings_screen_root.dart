import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/injection.dart';
import '../../portability/presentation/portability_cubit.dart';
import 'settings_cubit.dart';
import 'settings_screen.dart';

/// Independent composition boundary for the settings feature.
class SettingsScreenRoot extends StatelessWidget {
  const SettingsScreenRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<SettingsCubit>()),
        BlocProvider(create: (_) => getIt<PortabilityCubit>()),
      ],
      child: const SettingsScreen(),
    );
  }
}
