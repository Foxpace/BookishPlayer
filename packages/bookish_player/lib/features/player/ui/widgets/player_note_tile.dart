import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../../../../core/presentation/formatters.dart';
import '../../../notes/models/book_note.dart';
import '../../../notes/models/book_note_kind.dart';
import '../../cubits/player_cubits.dart';

class PlayerNoteTile extends StatelessWidget {
  const PlayerNoteTile({
    required this.note,
    required this.chapters,
    required this.actions,
    super.key,
  });

  final BookNote note;
  final List<PlayerChapter> chapters;
  final ({VoidCallback onOpen, VoidCallback onSeek, VoidCallback onDelete})
  actions;

  @override
  Widget build(BuildContext context) {
    final projection = _projectNote(note, chapters);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: actions.onOpen,
      leading: IconButton.filledTonal(
        tooltip: S.of(context).jumpToNote,
        onPressed: actions.onSeek,
        icon: Icon(switch (note.kind) {
          BookNoteKind.bookmark => Icons.bookmark_rounded,
          BookNoteKind.voice => Icons.mic_rounded,
          BookNoteKind.note => Icons.play_arrow_rounded,
        }),
      ),
      title: Text(
        note.displayText,
        maxLines: note.hasDisplayTitle ? 1 : 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: _PlayerNoteSubtitle(
        note: note,
        chapter: projection.chapter,
        relativeStart: projection.relativeStart,
        relativeEnd: projection.relativeEnd,
        hasTitle: note.hasDisplayTitle,
      ),
      trailing: IconButton(
        tooltip: S.of(context).deleteNote,
        onPressed: actions.onDelete,
        icon: const Icon(Icons.delete_outline_rounded),
      ),
    );
  }
}

typedef _NoteProjection = ({
  PlayerChapter? chapter,
  Duration relativeStart,
  Duration? relativeEnd,
});

_NoteProjection _projectNote(BookNote note, List<PlayerChapter> chapters) {
  final chapter = _chapterAt(chapters, note.position);
  final chapterStart = chapter?.start ?? Duration.zero;
  final end = note.endPosition;

  return (
    chapter: chapter,
    relativeStart: note.position - chapterStart,
    relativeEnd: end == null ? null : end - chapterStart,
  );
}

PlayerChapter? _chapterAt(List<PlayerChapter> chapters, Duration position) {
  for (final chapter in chapters) {
    if (position >= chapter.start &&
        position < chapter.start + chapter.duration) {
      return chapter;
    }
  }
  return null;
}

class _PlayerNoteSubtitle extends StatelessWidget {
  const _PlayerNoteSubtitle({
    required this.note,
    required this.chapter,
    required this.relativeStart,
    required this.relativeEnd,
    required this.hasTitle,
  });

  final BookNote note;
  final PlayerChapter? chapter;
  final Duration relativeStart;
  final Duration? relativeEnd;
  final bool hasTitle;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    final range = switch (relativeEnd) {
      final end? => '${formatDuration(relativeStart)}–${formatDuration(end)}',
      null => formatDuration(relativeStart),
    };
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasTitle) ...[
            Text(note.text, maxLines: 2, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 4),
          ],
          Text(
            [
              ?(note.chapterTitle ?? chapter?.title),
              range,
              formatDateTime(note.createdAt, locale),
            ].join(' · '),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
