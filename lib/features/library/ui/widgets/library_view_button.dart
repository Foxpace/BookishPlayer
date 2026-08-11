import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../../cubits/library_cubits.dart';

class LibraryViewButton extends StatelessWidget {
  const LibraryViewButton({
    required this.state,
    required this.onPressed,
    super.key,
  });

  final LibraryState state;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final customized =
        state.filter != LibraryFilter.all ||
        state.grouping != LibraryGrouping.none ||
        state.sort != LibrarySort.recent;
    return IconButton(
      tooltip: S.of(context).filterAndOrganizeLibrary,
      onPressed: onPressed,
      icon: Badge(
        isLabelVisible: customized,
        smallSize: 7,
        child: const Icon(Icons.tune_rounded),
      ),
    );
  }
}
