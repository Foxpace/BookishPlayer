import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/injection.dart';
import 'import_cubit.dart';
import 'import_screen.dart';
import 'import_state.dart';

/// Composition boundary for picking, copying, inspecting and saving imports.
class ImportScreenRoot extends StatelessWidget {
  const ImportScreenRoot({super.key, this.fromFinderTransfer = false});

  final bool fromFinderTransfer;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = getIt<ImportCubit>();
        if (fromFinderTransfer) {
          cubit.startFinderTransfer();
        } else {
          cubit.start();
        }
        return cubit;
      },
      child: BlocListener<ImportCubit, ImportState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == ImportStatus.complete) {
            context.pop(true);
          }
          if (state.status == ImportStatus.cancelled) {
            context.pop(false);
          }
        },
        child: const ImportScreen(),
      ),
    );
  }
}
