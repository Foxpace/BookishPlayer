import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/presentation/book_cover.dart';
import '../../../core/presentation/diagnostic_failure_view.dart';
import '../../player/domain/book_note.dart';
import '../../library/domain/book_metadata.dart';
import 'book_notes_screen.dart';
import 'note_gallery_cubit.dart';
import 'note_gallery_state.dart';

class NoteGalleryScreen extends StatelessWidget {
  const NoteGalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your notes')),
      body: BlocBuilder<NoteGalleryCubit, NoteGalleryState>(
        builder: (context, state) {
          if (state.status == NoteGalleryStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == NoteGalleryStatus.failure) {
            return DiagnosticFailureView.fromMessage(
              message: state.message ?? 'Could not load notes.',
              onRetry: context.read<NoteGalleryCubit>().load,
            );
          }
          if (state.notes.isEmpty) {
            return const _EmptyGallery();
          }
          final notesByMetadata = <String, List<BookNote>>{};
          for (final note in state.notes) {
            (notesByMetadata[note.metadataId] ??= []).add(note);
          }
          final visibleMetadata = state.metadata
              .where((metadata) => notesByMetadata.containsKey(metadata.id))
              .toList();
          return Column(
            children: [
              _GallerySummary(
                noteCount: state.notes.length,
                bookCount: visibleMetadata.length,
              ),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final columns = constraints.maxWidth >= 900
                        ? 3
                        : constraints.maxWidth >= 560
                        ? 2
                        : 1;
                    return GridView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: columns,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        mainAxisExtent: 152,
                      ),
                      itemCount: visibleMetadata.length,
                      itemBuilder: (context, index) {
                        final metadata = visibleMetadata[index];
                        return _NoteBookCard(
                          metadata: metadata,
                          notes: notesByMetadata[metadata.id]!,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _NoteBookCard extends StatelessWidget {
  const _NoteBookCard({required this.metadata, required this.notes});

  final BookMetadata metadata;
  final List<BookNote> notes;

  @override
  Widget build(BuildContext context) {
    final activeBookId = metadata.activeBookId;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          final cubit = context.read<NoteGalleryCubit>();
          Navigator.of(context).push<void>(
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: cubit,
                child: BookNotesScreen(metadata: metadata),
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BookCover(
                title: metadata.title,
                artworkPath: metadata.artworkPath,
                size: 82,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      metadata.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (metadata.author.isNotEmpty)
                      Text(
                        metadata.author,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        _NoteCount(count: notes.length),
                        Text(
                          activeBookId == null ? 'Archived' : 'In library',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.chevron_right_rounded),
            ],
          ),
        ),
      ),
    );
  }
}

class _GallerySummary extends StatelessWidget {
  const _GallerySummary({required this.noteCount, required this.bookCount});

  final int noteCount;
  final int bookCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          '$noteCount ${noteCount == 1 ? 'note' : 'notes'} across '
          '$bookCount ${bookCount == 1 ? 'book' : 'books'}',
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
    );
  }
}

class _NoteCount extends StatelessWidget {
  const _NoteCount({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        '$count ${count == 1 ? 'note' : 'notes'}',
        style: Theme.of(context).textTheme.labelLarge,
      ),
    );
  }
}

class _EmptyGallery extends StatelessWidget {
  const _EmptyGallery();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.collections_bookmark_outlined, size: 56),
            SizedBox(height: 16),
            Text('Notes you save while listening will live here.'),
          ],
        ),
      ),
    );
  }
}
