import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../../models/library_models.dart';
import '../../models/audiobook_removal_mode.dart';

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
      title: Text(S.of(context).removeBookQuestion(book.title)),
      contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.audio_file_outlined),
            title: Text(S.of(context).removeAudioOnly),
            subtitle: Text(S.of(context).keepUserDataDescription),
            onTap: () =>
                Navigator.pop(context, AudiobookRemovalMode.keepUserData),
          ),
          ListTile(
            leading: Icon(
              Icons.delete_forever_outlined,
              color: Theme.of(context).colorScheme.error,
            ),
            title: Text(
              S.of(context).deleteEverything,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
            subtitle: Text(S.of(context).deleteAllUserDataDescription),
            onTap: () =>
                Navigator.pop(context, AudiobookRemovalMode.deleteAllData),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: Text(S.of(context).externalOriginalsUnaffected),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(S.of(context).cancel),
        ),
      ],
    );
  }
}
