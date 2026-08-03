part of '../player_screen.dart';

class _NotesSheet extends StatelessWidget {
  const _NotesSheet({required this.onAddNote});

  final VoidCallback onAddNote;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerCubit, PlayerState>(
      builder: (context, state) => SafeArea(
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height * .65,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 4, 24, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Notes & bookmarks',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                    IconButton.filledTonal(
                      tooltip: 'Add note at current position',
                      onPressed: onAddNote,
                      icon: const Icon(Icons.add_rounded),
                    ),
                    IconButton(
                      tooltip: 'Export notes',
                      onPressed: state.notes.isEmpty
                          ? null
                          : () async {
                              final saved = await context
                                  .read<PlayerCubit>()
                                  .exportNotes();
                              if (saved && context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Notes exported.'),
                                  ),
                                );
                              }
                            },
                      icon: const Icon(Icons.ios_share_rounded),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: state.notes.isEmpty
                      ? const Center(
                          child: Text(
                            'No notes yet. Add one while you listen.',
                          ),
                        )
                      : ListView.separated(
                          itemCount: state.notes.length,
                          separatorBuilder: (_, _) => const Divider(height: 24),
                          itemBuilder: (context, index) =>
                              _NoteTile(note: state.notes[index]),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NoteTile extends StatelessWidget {
  const _NoteTile({required this.note});

  final BookNote note;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PlayerCubit>();
    final globalStart = Duration(milliseconds: note.positionMs);
    final globalEnd = note.endPositionMs == null
        ? null
        : Duration(milliseconds: note.endPositionMs!);
    PlayerChapter? noteChapter;
    for (final chapter in cubit.state.chapterTimeline) {
      final chapterEnd = chapter.start + chapter.duration;
      if (globalStart >= chapter.start && globalStart < chapterEnd) {
        noteChapter = chapter;
        break;
      }
    }
    final relativeStart = noteChapter == null
        ? globalStart
        : globalStart - noteChapter.start;
    final relativeEnd = globalEnd == null
        ? null
        : noteChapter == null
        ? globalEnd
        : globalEnd - noteChapter.start;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: IconButton.filledTonal(
        tooltip: 'Jump to note',
        onPressed: () {
          cubit.seek(Duration(milliseconds: note.positionMs));
          Navigator.pop(context);
        },
        icon: const Icon(Icons.play_arrow_rounded),
      ),
      title: Text(note.text),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Text(
          [
            ?(note.chapterTitle ?? noteChapter?.title),
            relativeEnd == null
                ? formatDuration(relativeStart)
                : '${formatDuration(relativeStart)}–${formatDuration(relativeEnd)}',
          ].join(' · '),
        ),
      ),
      trailing: IconButton(
        tooltip: 'Delete note',
        onPressed: () => cubit.deleteNote(note),
        icon: const Icon(Icons.delete_outline_rounded),
      ),
    );
  }
}
