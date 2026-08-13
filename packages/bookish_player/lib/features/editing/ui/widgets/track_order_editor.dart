import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../../../library/models/library_models.dart';

class TrackOrderEditor extends StatelessWidget {
  const TrackOrderEditor({
    required this.book,
    required this.onReorder,
    super.key,
  });

  final Audiobook book;
  final void Function(int oldIndex, int newIndex) onReorder;

  @override
  Widget build(BuildContext context) {
    if (book.tracks.length <= 1) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 28),
        Text(
          S.of(context).trackOrder,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        ReorderableListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: book.playableTracks.length,
          onReorderItem: onReorder,
          itemBuilder: (context, index) {
            final track = book.playableTracks[index];
            return ListTile(
              key: ValueKey(track.id),
              leading: Text('${index + 1}'),
              title: Text(track.title),
              trailing: const Icon(Icons.drag_handle_rounded),
            );
          },
        ),
      ],
    );
  }
}
