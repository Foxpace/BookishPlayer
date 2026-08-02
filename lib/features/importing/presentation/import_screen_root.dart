import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/injection.dart';
import 'import_cubit.dart';
import 'import_screen.dart';
import 'import_state.dart';

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
    return BlocProvider.value(
      value: _cubit,
      child: BlocListener<ImportCubit, ImportState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == ImportStatus.complete) {
            context.pop(true);
          }
        },
        child: const ImportScreen(),
      ),
    );
  }
}
