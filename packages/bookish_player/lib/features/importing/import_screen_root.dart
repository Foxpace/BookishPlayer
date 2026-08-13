import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/di/injection.dart';
import 'cubits/import_cubit.dart';
import 'cubits/import_cubits.dart';
import 'ui/import_screen.dart';

/// Composition boundary for picking, copying, inspecting and saving imports.
class ImportScreenRoot extends StatefulWidget {
  const ImportScreenRoot({super.key, this.fromFinderTransfer = false});

  final bool fromFinderTransfer;

  @override
  State<ImportScreenRoot> createState() => _ImportScreenRootState();
}

class _ImportScreenRootState extends State<ImportScreenRoot> {
  late final ImportCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<ImportCubit>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      if (widget.fromFinderTransfer) {
        _cubit.startFinderTransfer();
      } else {
        _cubit.start();
      }
    });
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ImportCubit>.value(
      value: _cubit,
      child: BlocConsumer<ImportCubit, ImportState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == ImportStatus.complete) {
            context.pop(true);
          }
        },
        builder: (context, state) => ImportScreen(
          state: state,
          onRetry: _cubit.retry,
          onCopyDiagnostics: _cubit.copyDiagnostics,
          onBack: () => context.pop(false),
        ),
      ),
    );
  }
}
