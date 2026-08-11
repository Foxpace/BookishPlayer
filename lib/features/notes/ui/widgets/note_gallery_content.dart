import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../../../../core/presentation/app_message.dart';
import '../../../../core/presentation/diagnostic_failure_view.dart';
import '../../../library/models/library_models.dart';
import '../../cubits/notes_cubits.dart';
import '../../models/note_models.dart';
import 'note_book_card.dart';

class NoteGalleryContent extends StatelessWidget {
  const NoteGalleryContent({
    required this.state,
    required this.onRetry,
    required this.onOpenBookNotes,
    super.key,
  });

  final NoteGalleryState state;
  final VoidCallback onRetry;
  final ValueChanged<BookMetadata> onOpenBookNotes;

  @override
  Widget build(BuildContext context) {
    if (state.status == NoteGalleryStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.status == NoteGalleryStatus.failure) {
      return DiagnosticFailureView.fromMessage(
        message:
            state.message?.localize(context) ?? S.of(context).couldNotLoadNotes,
        onRetry: onRetry,
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
            builder: (context, constraints) => GridView.builder(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: constraints.maxWidth >= 900
                    ? 3
                    : constraints.maxWidth >= 560
                    ? 2
                    : 1,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                mainAxisExtent: 152,
              ),
              itemCount: visibleMetadata.length,
              itemBuilder: (context, index) {
                final metadata = visibleMetadata[index];
                return NoteBookCard(
                  metadata: metadata,
                  notes: notesByMetadata[metadata.id] ?? const [],
                  onOpen: () => onOpenBookNotes(metadata),
                );
              },
            ),
          ),
        ),
      ],
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

class _EmptyGallery extends StatelessWidget {
  const _EmptyGallery();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.collections_bookmark_outlined, size: 56),
            const SizedBox(height: 16),
            Text(S.of(context).notesEmptyDescription),
          ],
        ),
      ),
    );
  }
}
