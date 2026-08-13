import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../../cubits/library_cubits.dart';

class LibraryLayoutSelector extends StatelessWidget {
  const LibraryLayoutSelector({
    required this.layout,
    required this.onChanged,
    super.key,
  });

  final LibraryLayout layout;
  final ValueChanged<LibraryLayout> onChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<LibraryLayout>(
      segments: [
        ButtonSegment(
          value: LibraryLayout.list,
          icon: const Icon(Icons.view_list_rounded),
          label: Text(S.of(context).listLayout),
        ),
        ButtonSegment(
          value: LibraryLayout.grid,
          icon: const Icon(Icons.grid_view_rounded),
          label: Text(S.of(context).gridLayout),
        ),
      ],
      selected: {layout},
      onSelectionChanged: (selection) => onChanged(selection.first),
    );
  }
}
