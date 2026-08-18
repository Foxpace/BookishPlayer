import 'package:flutter/material.dart';

import '../../../../core/presentation/formatters.dart';
import '../../models/book_note.dart';
import '../../models/book_note_kind.dart';

class BookNoteCard extends StatelessWidget {
  const BookNoteCard({required this.note, required this.onOpen, super.key});

  final BookNote note;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final title = note.title?.trim();
    final hasTitle = title != null && title.isNotEmpty;
    final locale = Localizations.localeOf(context).toLanguageTag();
    return Card(
      margin: EdgeInsets.zero,
      child: ListTile(
        contentPadding: const EdgeInsets.fromLTRB(16, 10, 8, 10),
        onTap: onOpen,
        leading: Icon(switch (note.kind) {
          BookNoteKind.bookmark => Icons.bookmark_rounded,
          BookNoteKind.voice => Icons.mic_rounded,
          BookNoteKind.note => Icons.notes_rounded,
        }),
        title: Text(
          hasTitle ? title : note.text,
          maxLines: hasTitle ? 1 : 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            [
              ?(hasTitle ? note.text : null),
              ?note.chapterTitle,
              formatDuration(Duration(milliseconds: note.positionMs)),
              formatDateTime(note.createdAt, locale),
            ].join(' · '),
            maxLines: hasTitle ? 3 : 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        trailing: const Icon(Icons.chevron_right_rounded),
      ),
    );
  }
}
