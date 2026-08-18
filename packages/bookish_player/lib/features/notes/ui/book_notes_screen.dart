import 'package:flutter/material.dart';

import '../../../core/localization/generated/l10n.dart';
import '../../../core/presentation/bookish_scaffold.dart';
import '../../library/models/library_models.dart';
import '../models/book_note.dart';
import 'widgets/book_note_card.dart';
import 'widgets/book_notes_header.dart';

class BookNotesScreen extends StatelessWidget {
  const BookNotesScreen({
    required this.metadata,
    required this.notes,
    required this.onOpenNote,
    super.key,
  });

  final BookMetadata metadata;
  final List<BookNote> notes;
  final ValueChanged<BookNote> onOpenNote;

  @override
  Widget build(BuildContext context) {
    final visibleNotes =
        notes.where((note) => note.metadataId == metadata.id).toList()
          ..sort((left, right) => right.createdAt.compareTo(left.createdAt));
    return BookishScaffold(
      appBar: AppBar(title: Text(S.of(context).notesTitle)),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: BookNotesHeader(
              metadata: metadata,
              noteCount: visibleNotes.length,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
            sliver: SliverList.separated(
              itemCount: visibleNotes.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (context, index) => BookNoteCard(
                note: visibleNotes[index],
                onOpen: () => onOpenNote(visibleNotes[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
