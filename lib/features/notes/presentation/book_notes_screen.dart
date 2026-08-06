import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/presentation/book_cover.dart';
import '../../../core/presentation/formatters.dart';
import '../../library/domain/book_metadata.dart';
import '../../player/domain/book_note.dart';
import '../../player/presentation/note_detail_screen.dart';
import 'note_gallery_cubit.dart';
import 'note_gallery_state.dart';

class BookNotesScreen extends StatelessWidget {
  const BookNotesScreen({required this.metadata, super.key});

  final BookMetadata metadata;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notes')),
      body: BlocBuilder<NoteGalleryCubit, NoteGalleryState>(
        builder: (context, state) {
          final notes =
              state.notes
                  .where((note) => note.metadataId == metadata.id)
                  .toList()
                ..sort(
                  (left, right) => right.createdAt.compareTo(left.createdAt),
                );
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: _BookHeader(metadata: metadata, noteCount: notes.length),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
                sliver: SliverList.separated(
                  itemCount: notes.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 8),
                  itemBuilder: (context, index) =>
                      _NoteCard(note: notes[index]),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _BookHeader extends StatelessWidget {
  const _BookHeader({required this.metadata, required this.noteCount});

  final BookMetadata metadata;
  final int noteCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      child: Row(
        children: [
          BookCover(
            title: metadata.title,
            artworkPath: metadata.artworkPath,
            size: 64,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  metadata.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text('$noteCount ${noteCount == 1 ? 'note' : 'notes'}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NoteCard extends StatelessWidget {
  const _NoteCard({required this.note});

  final BookNote note;

  @override
  Widget build(BuildContext context) {
    final title = note.title?.trim();
    final hasTitle = title != null && title.isNotEmpty;
    final locale = Localizations.localeOf(context).toLanguageTag();
    return Card(
      margin: EdgeInsets.zero,
      child: ListTile(
        contentPadding: const EdgeInsets.fromLTRB(16, 10, 8, 10),
        onTap: () {
          final cubit = context.read<NoteGalleryCubit>();
          Navigator.of(context).push<void>(
            MaterialPageRoute(
              builder: (_) => NoteDetailScreen(
                note: note,
                onSave: ({required title, required text}) =>
                    cubit.updateNote(note, title: title, text: text),
              ),
            ),
          );
        },
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
