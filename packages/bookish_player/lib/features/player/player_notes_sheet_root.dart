import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/localization/generated/l10n.dart';
import '../notes/models/note_models.dart';
import 'cubits/player_cubit.dart';
import 'cubits/player_cubits.dart';
import 'ui/widgets/notes_sheet.dart';

class PlayerNotesSheetRoot extends StatelessWidget {
  const PlayerNotesSheetRoot({
    required this.cubit,
    required this.onAddNote,
    required this.onAddVoiceNote,
    required this.onOpenNote,
    super.key,
  });

  final PlayerCubit cubit;
  final VoidCallback onAddNote;
  final VoidCallback onAddVoiceNote;
  final ValueChanged<BookNote> onOpenNote;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PlayerCubit>.value(
      value: cubit,
      child: BlocBuilder<PlayerCubit, PlayerState>(
        builder: (context, state) => NotesSheet(
          state: state,
          actions: (
            onAddBookmark: () => _addBookmark(context),
            onAddNote: onAddNote,
            onAddVoiceNote: onAddVoiceNote,
            onExport: () => _exportNotes(context),
            onOpenNote: onOpenNote,
            onSeekToNote: (note) => _seekToNote(context, note),
            onDeleteNote: cubit.deleteNote,
          ),
        ),
      ),
    );
  }

  Future<void> _addBookmark(BuildContext context) async {
    await cubit.addBookmark();
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(S.of(context).bookmarkSaved)));
    }
  }

  Future<void> _exportNotes(BuildContext context) async {
    final saved = await cubit.exportNotes();
    if (saved && context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(S.of(context).notesExported)));
    }
  }

  void _seekToNote(BuildContext context, BookNote note) {
    cubit.seek(Duration(milliseconds: note.positionMs));
    Navigator.pop(context);
  }
}
