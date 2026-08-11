import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../../cubits/library_cubits.dart';
import 'library_view_button.dart';

class LibrarySearchControls extends StatelessWidget {
  const LibrarySearchControls({
    required this.state,
    required this.onQueryChanged,
    required this.onOpenView,
    super.key,
  });

  final LibraryState state;
  final ValueChanged<String> onQueryChanged;
  final VoidCallback onOpenView;

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      hintText: S.of(context).librarySearchHint,
      leading: const Icon(Icons.search_rounded),
      trailing: [LibraryViewButton(state: state, onPressed: onOpenView)],
      onChanged: onQueryChanged,
    );
  }
}
