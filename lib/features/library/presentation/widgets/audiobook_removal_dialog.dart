import 'package:flutter/material.dart';

import '../../domain/audiobook.dart';
import '../../domain/audiobook_removal_mode.dart';

Future<AudiobookRemovalMode?> showAudiobookRemovalDialog(
  BuildContext context,
  Audiobook book,
) {
  return showDialog<AudiobookRemovalMode>(
    context: context,
    builder: (_) => AudiobookRemovalDialog(book: book),
  );
}

class AudiobookRemovalDialog extends StatelessWidget {
  const AudiobookRemovalDialog({required this.book, super.key});

  final Audiobook book;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Remove “${book.title}”?'),
      contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.audio_file_outlined),
            title: const Text('Remove audio only'),
            subtitle: const Text(
              'Keep notes, book details, cover, and listening history.',
            ),
            onTap: () =>
                Navigator.pop(context, AudiobookRemovalMode.keepUserData),
          ),
          ListTile(
            leading: Icon(
              Icons.delete_forever_outlined,
              color: Theme.of(context).colorScheme.error,
            ),
            title: Text(
              'Delete everything',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
            subtitle: const Text(
              'Also delete notes, book details, cover, and listening history.',
            ),
            onTap: () =>
                Navigator.pop(context, AudiobookRemovalMode.deleteAllData),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: Text('Original files outside Bookish are not affected.'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
