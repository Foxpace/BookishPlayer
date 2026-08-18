import 'package:flutter/material.dart';

import '../../../notes/models/book_note.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../../cubits/player_cubits.dart';
import 'player_note_tile.dart';
import 'player_notes_header.dart';

class NotesSheet extends StatelessWidget {
  const NotesSheet({required this.state, required this.actions, super.key});

  final PlayerState state;
  final ({
    VoidCallback onAddBookmark,
    VoidCallback onAddNote,
    VoidCallback onAddVoiceNote,
    VoidCallback onExport,
    ValueChanged<BookNote> onOpenNote,
    ValueChanged<BookNote> onSeekToNote,
    ValueChanged<BookNote> onDeleteNote,
  })
  actions;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * .65,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 4, 24, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PlayerNotesHeader(
                hasNotes: state.notes.isNotEmpty,
                actions: (
                  onAddBookmark: actions.onAddBookmark,
                  onAddVoiceNote: actions.onAddVoiceNote,
                  onAddNote: actions.onAddNote,
                  onExport: actions.onExport,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: state.notes.isEmpty
                    ? Center(child: Text(S.of(context).noNotesYet))
                    : ListView.separated(
                        itemCount: state.notes.length,
                        separatorBuilder: (_, _) => const Divider(height: 24),
                        itemBuilder: (context, index) {
                          final note = state.notes[index];
                          return PlayerNoteTile(
                            note: note,
                            chapters: state.chapterTimeline,
                            actions: (
                              onOpen: () => actions.onOpenNote(note),
                              onSeek: () => actions.onSeekToNote(note),
                              onDelete: () => actions.onDeleteNote(note),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
