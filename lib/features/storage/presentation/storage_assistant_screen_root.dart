import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/injection.dart';
import 'storage_assistant_cubit.dart';
import 'storage_assistant_screen.dart';

class StorageAssistantScreenRoot extends StatelessWidget {
  const StorageAssistantScreenRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<StorageAssistantCubit>()..load(),
      child: const StorageAssistantScreen(),
    );
  }
}
