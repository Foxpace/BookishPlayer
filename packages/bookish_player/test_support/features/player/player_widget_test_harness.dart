import 'package:bookish_player/features/notes/models/book_note.dart';
import 'package:bookish_player/features/player/cubits/player_cubit.dart';
import 'package:bookish_player/features/player/cubits/player_cubits.dart';
import 'package:bookish_player/features/player/cubits/player_ui_intents.dart';
import 'package:bookish_player/features/player/ui/player_screen.dart';
import 'package:bookish_player/features/player/ui/widgets/notes_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayerTestScreenHarness extends StatefulWidget {
  const PlayerTestScreenHarness({
    required this.cubit,
    this.onPickAudioOutput,
    this.onOpenNote,
    super.key,
  });

  final PlayerCubit cubit;
  final VoidCallback? onPickAudioOutput;
  final OpenPlayerNote? onOpenNote;

  @override
  State<PlayerTestScreenHarness> createState() =>
      _PlayerTestScreenHarnessState();
}

class _PlayerTestScreenHarnessState extends State<PlayerTestScreenHarness> {
  PlayerPlaybackIntents get _intents => (
    pausePlayback: widget.cubit.pausePlayback,
    togglePlayback: widget.cubit.togglePlayback,
    previousChapter: widget.cubit.previousChapter,
    nextChapter: widget.cubit.nextChapter,
    skipBy: widget.cubit.skipBy,
    changeSpeed: widget.cubit.changeSpeed,
    seek: widget.cubit.seek,
    seekWithinChapter: widget.cubit.seekWithinChapter,
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerCubit, PlayerState>(
      bloc: widget.cubit,
      builder: (context, state) => PlayerScreen(
        state: state,
        intents: _intents,
        actions: (
          onDidPop: widget.cubit.saveProgress,
          onBack: () => _exit(context),
          onOpenSettings: () {},
          onTimelineSeek: widget.cubit.seekWithinChapter,
          onPickAudioOutput: widget.onPickAudioOutput,
          onShowChapters: () {},
          onShowSleepTimer: () {},
          onShowNotes: () => _showNotes(context),
          onTranscribeQuote: () {},
        ),
      ),
    );
  }

  Future<void> _exit(BuildContext context) async {
    await widget.cubit.saveProgress();
    if (context.mounted) {
      await Navigator.maybePop(context);
    }
  }

  Future<void> _showNotes(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (sheetContext) => BlocBuilder<PlayerCubit, PlayerState>(
        bloc: widget.cubit,
        builder: (_, state) => NotesSheet(
          state: state,
          actions: (
            onAddBookmark: widget.cubit.addBookmark,
            onAddNote: () {},
            onAddVoiceNote: () {},
            onExport: widget.cubit.exportNotes,
            onOpenNote: (note) => _openNote(sheetContext, note),
            onSeekToNote: (note) {
              widget.cubit.seek(Duration(milliseconds: note.positionMs));
              Navigator.pop(sheetContext);
            },
            onDeleteNote: widget.cubit.deleteNote,
          ),
        ),
      ),
    );
  }

  Future<void> _openNote(BuildContext context, BookNote note) async {
    await widget.onOpenNote?.call(context, note);
  }
}
