import 'package:flutter/material.dart';

import '../cubits/import_cubits.dart';
import 'widgets/import_view.dart';

class ImportScreen extends StatelessWidget {
  const ImportScreen({required this.state, required this.actions, super.key});

  final ImportState state;
  final ImportViewActions actions;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !state.status.isActive,
      child: ImportView(state: state, actions: actions),
    );
  }
}
