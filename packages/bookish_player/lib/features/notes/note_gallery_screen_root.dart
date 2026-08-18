import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/di/injection.dart';
import '../library/models/library_models.dart';
import 'cubits/note_gallery_cubit.dart';
import 'cubits/notes_cubits.dart';
import 'models/book_note.dart';
import 'ui/book_notes_screen.dart';
import 'ui/note_detail_screen.dart';
import 'ui/note_gallery_screen.dart';

class NoteGalleryScreenRoot extends StatelessWidget {
  const NoteGalleryScreenRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NoteGalleryCubit>(
      create: (_) => getIt<NoteGalleryCubit>()..load(),
      child: BlocBuilder<NoteGalleryCubit, NoteGalleryState>(
        builder: (context, state) {
          final cubit = context.read<NoteGalleryCubit>();
          return NoteGalleryScreen(
            state: state,
            onRetry: cubit.load,
            onOpenBookNotes: (metadata) =>
                _openBookNotes(context, cubit, metadata),
          );
        },
      ),
    );
  }

  Future<void> _openBookNotes(
    BuildContext context,
    NoteGalleryCubit cubit,
    BookMetadata metadata,
  ) {
    return Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (_) => BlocBuilder<NoteGalleryCubit, NoteGalleryState>(
          bloc: cubit,
          builder: (context, state) => BookNotesScreen(
            metadata: metadata,
            notes: state.notes,
            onOpenNote: (note) => _openNote(context, cubit, note),
          ),
        ),
      ),
    );
  }

  Future<void> _openNote(
    BuildContext context,
    NoteGalleryCubit cubit,
    BookNote note,
  ) {
    return Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (_) => NoteDetailScreen(
          note: note,
          onSave: ({required title, required text}) =>
              cubit.updateNote(note, title: title, text: text),
        ),
      ),
    );
  }
}
