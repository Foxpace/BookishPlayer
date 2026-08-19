import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/di/injection.dart';
import '../../core/foundation/result.dart';
import '../../core/localization/generated/l10n.dart';
import '../../core/navigation/app_router.dart';
import '../../core/presentation/formatters.dart';
import '../../app/app_capabilities.dart';
import '../library/models/library_models.dart';
import '../notes/models/book_note.dart';
import '../notes/ui/note_detail_screen.dart';
import '../notes/ui/widgets/note_composer_sheet.dart';
import '../notes/voice_note_root.dart';
import '../transcription/models/transcription_draft.dart';
import '../transcription/quote_transcription_root.dart';
import '../transcription/transcription_preview_root.dart';
import 'cubits/player_cubit.dart';
import 'cubits/player_cubits.dart';
import 'cubits/player_state_timeline.dart';
import 'cubits/player_ui_intents.dart';
import 'player_chapters_sheet_root.dart';
import 'player_notes_sheet_root.dart';
import 'player_sleep_timer_sheet_root.dart';
import 'ui/player_seek_ui.dart';
import 'ui/player_screen.dart';

/// Composition boundary for one player route and its Cubit lifetime.
class PlayerScreenRoot extends StatefulWidget {
  const PlayerScreenRoot({required this.bookId, super.key});

  final String bookId;

  @override
  State<PlayerScreenRoot> createState() => _PlayerScreenRootState();
}

class _PlayerScreenRootState extends State<PlayerScreenRoot>
    with WidgetsBindingObserver {
  late final PlayerCubit _cubit;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _cubit = getIt<PlayerCubit>();
    if (_cubit.state.book?.id != widget.bookId) {
      _cubit.openById(widget.bookId);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) {
      unawaited(_cubit.saveProgress());
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PlayerCubit>.value(
      value: _cubit,
      child: BlocBuilder<PlayerCubit, PlayerState>(
        builder: (context, state) => PlayerScreen(
          state: state,
          intents: _playbackIntents,
          actions: (
            onDidPop: () => unawaited(_cubit.saveProgress()),
            onBack: () => _exitPlayer(context),
            onOpenSettings: () => context.pushNamed(AppRoutes.settings),
            onTimelineSeek: (relative) =>
                _seekWithinChapter(context, state, relative),
            onPickAudioOutput: _pickAudioOutput,
            onShowChapters: () => _showChapters(context),
            onShowSleepTimer: () => _showSleepTimer(context),
            onShowNotes: () => _showNotes(context),
            onTranscribeQuote: getIt<AppCapabilities>().transcriptionEnabled
                ? () => _transcribeQuote(context)
                : null,
          ),
        ),
      ),
    );
  }

  PlayerPlaybackIntents get _playbackIntents => (
    togglePlayback: _cubit.togglePlayback,
    previousChapter: _cubit.previousChapter,
    nextChapter: _cubit.nextChapter,
    skipBy: _cubit.skipBy,
    changeSpeed: _cubit.changeSpeed,
    seek: _cubit.seek,
    seekWithinChapter: _cubit.seekWithinChapter,
  );

  Future<void> _seekWithinChapter(
    BuildContext context,
    PlayerState state,
    Duration relative,
  ) async {
    final previous = state.position;
    final distance = state.chapterSeekDistance(relative);
    if (state.requiresSeekConfirmation(distance) &&
        !await context.confirmLargeSeek(distance)) {
      return;
    }

    await _cubit.seekWithinChapter(relative);
    if (context.mounted) {
      context.showSeekUndo(() => _cubit.seek(previous));
    }
  }

  Future<void> _exitPlayer(BuildContext context) async {
    await _cubit.saveProgress();
    if (context.mounted) {
      await Navigator.maybePop(context);
    }
  }

  Future<void> _pickAudioOutput() async {
    final result = await _cubit.pickAudioOutput();
    if (result case ResultFailure() when mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).audioOutputsOpenFailed)),
      );
    }
  }

  Future<void> _composeNote(BuildContext context) async {
    final state = _cubit.state;
    final position = formatDuration(state.chapterPosition);
    final chapterTitle = state.currentChapter?.title;
    final heading = chapterTitle == null
        ? S.of(context).noteAtPosition(position)
        : S.of(context).chapterAtPosition(chapterTitle, position);
    final text = await showNoteComposerSheet(context, heading: heading);
    if (text != null && context.mounted) {
      await _cubit.addNote(text);
    }
  }

  Future<void> _composeVoiceNote(BuildContext context) async {
    final text = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => const VoiceNoteRoot(),
    );
    if (text != null && text.trim().isNotEmpty && context.mounted) {
      await _cubit.addVoiceNote(text);
    }
  }

  Future<void> _showChapters(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (_) => PlayerChaptersSheetRoot(cubit: _cubit),
    );
  }

  Future<void> _showSleepTimer(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (_) => PlayerSleepTimerSheetRoot(cubit: _cubit),
    );
  }

  Future<void> _showNotes(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (sheetContext) => PlayerNotesSheetRoot(
        cubit: _cubit,
        onAddNote: () => _reopenComposer(sheetContext, context, _composeNote),
        onAddVoiceNote: () =>
            _reopenComposer(sheetContext, context, _composeVoiceNote),
        onOpenNote: (note) => _openNote(sheetContext, note),
      ),
    );
  }

  Future<void> _reopenComposer(
    BuildContext sheetContext,
    BuildContext rootContext,
    ComposePlayerCapability compose,
  ) async {
    Navigator.pop(sheetContext);
    await Future<void>.delayed(Duration.zero);
    if (rootContext.mounted) {
      await compose(rootContext);
    }
  }

  Future<void> _transcribeQuote(BuildContext context) async {
    final state = _cubit.state;
    final book = state.book;
    if (book == null) {
      return;
    }
    if (state.isPlaying) {
      await _cubit.togglePlayback();
    }
    if (!context.mounted) {
      return;
    }
    final draft = await _showTranscriptionSheet(context, book, state);
    if (draft == null || !context.mounted) {
      return;
    }
    await _showTranscriptionPreview(context, draft);
  }

  Future<TranscriptionDraft?> _showTranscriptionSheet(
    BuildContext context,
    Audiobook book,
    PlayerState state,
  ) {
    return showModalBottomSheet<TranscriptionDraft>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => QuoteTranscriptionRoot(
        book: book,
        chapter: (
          title: state.currentChapter?.title,
          start: state.chapterStart,
          duration: state.chapterDuration > Duration.zero
              ? state.chapterDuration
              : state.duration,
          anchor: state.chapterPosition,
        ),
      ),
    );
  }

  Future<void> _showTranscriptionPreview(
    BuildContext context,
    TranscriptionDraft draft,
  ) {
    return Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (_) => TranscriptionPreviewRoot(
          draft: draft,
          onSave: (text, draft) => _cubit.addNoteAt(
            text,
            draft.start,
            chapterTitle: draft.chapterTitle,
            endPosition: draft.end,
          ),
        ),
      ),
    );
  }

  Future<void> _openNote(BuildContext context, BookNote note) {
    return Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (_) => NoteDetailScreen(
          note: note,
          onSave: ({required title, required text}) =>
              _cubit.updateNote(note, title: title, text: text),
          onShare: (edited, {origin}) =>
              _cubit.shareNote(edited, origin: origin),
        ),
      ),
    );
  }
}
