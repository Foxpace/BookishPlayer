import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/injection.dart';
import 'library_cubit.dart';
import 'library_screen.dart';

/// Composition boundary for the library feature.
/// This is the only library widget that knows about dependency injection.
class LibraryScreenRoot extends StatelessWidget {
  const LibraryScreenRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LibraryCubit>()..load(),
      child: const LibraryScreen(),
    );
  }
}
