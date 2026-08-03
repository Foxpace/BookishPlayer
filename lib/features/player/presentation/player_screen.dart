import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/navigation/app_router.dart';
import '../../../core/presentation/book_cover.dart';
import '../../../core/presentation/formatters.dart';
import '../domain/book_note.dart';
import '../domain/transcription_draft.dart';
import 'player_cubit.dart';
import 'player_state.dart';
import 'quote_transcription_cubit.dart';
import 'quote_transcription_state.dart';
import 'quote_boundary_slider.dart';
import 'transcription_preview_screen.dart';

part 'widgets/player_sheets.dart';
part 'widgets/player_timeline.dart';
part 'widgets/player_controls.dart';
part 'widgets/player_notes.dart';
part 'widgets/quote_transcription_sheet.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerCubit, PlayerState>(
      builder: (context, state) {
        final book = state.book;
        if (book == null) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: state.status == PlayerStatus.failure
                  ? Padding(
                      padding: const EdgeInsets.all(32),
                      child: Text(
                        state.message ?? 'No audiobook selected',
                        textAlign: TextAlign.center,
                      ),
                    )
                  : const CircularProgressIndicator(),
            ),
          );
        }
        return PopScope(
          onPopInvokedWithResult: (_, _) =>
              context.read<PlayerCubit>().saveProgress(),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              leadingWidth: 64,
              leading: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: _PlayerTopButton(
                  tooltip: 'Back to library',
                  onPressed: () => Navigator.maybePop(context),
                  icon: Icons.arrow_back_rounded,
                ),
              ),
              title: const Text(
                'NOW PLAYING',
                style: TextStyle(fontSize: 11, letterSpacing: 2.4),
              ),
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: _PlayerTopButton(
                    tooltip: 'Settings',
                    onPressed: () => context.pushNamed(AppRoutes.settings),
                    icon: Icons.settings_outlined,
                  ),
                ),
              ],
            ),
            body: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(28, 18, 28, 22),
                child: Column(
                  children: [
                    Expanded(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final size = constraints
                              .constrainWidth(constraints.maxHeight)
                              .clamp(150.0, 290.0);
                          return Center(
                            child: BookCover(
                              title: book.title,
                              artworkPath: book.artworkPath,
                              size: size,
                              heightFactor: 1,
                              imageFit: BoxFit.contain,
                              heroTag: book.id,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      book.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w700, height: 1.2),
                    ),
                    const SizedBox(height: 26),
                    _Timeline(state: state),
                    const SizedBox(height: 18),
                    _Transport(state: state),
                    const SizedBox(height: 18),
                    _PlayerTools(
                      state: state,
                      onChapters: state.chapterTimeline.isEmpty
                          ? null
                          : () => _showChapters(context, state.chapterTimeline),
                      onTimer: () => _showSleepTimer(context),
                      onNotes: () => _showNotes(context),
                      onQuote: () => _showTranscription(context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _addNote(BuildContext context) async {
    final controller = TextEditingController();
    final playerState = context.read<PlayerCubit>().state;
    final chapterTitle = playerState.currentChapter?.title;
    final text = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) => Padding(
        padding: EdgeInsets.fromLTRB(
          24,
          8,
          24,
          24 + MediaQuery.viewInsetsOf(sheetContext).bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              chapterTitle == null
                  ? 'Note at ${formatDuration(playerState.chapterPosition)}'
                  : '$chapterTitle · ${formatDuration(playerState.chapterPosition)}',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              autofocus: true,
              minLines: 3,
              maxLines: 6,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                hintText: 'A thought worth returning to…',
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => Navigator.pop(sheetContext, controller.text),
                child: const Text('Save note'),
              ),
            ),
          ],
        ),
      ),
    );
    controller.dispose();
    if (text != null && context.mounted) {
      await context.read<PlayerCubit>().addNote(text);
    }
  }

  void _showNotes(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(
        value: context.read<PlayerCubit>(),
        child: _NotesSheet(
          onAddNote: () async {
            Navigator.pop(context);
            await Future<void>.delayed(Duration.zero);
            if (context.mounted) {
              await _addNote(context);
            }
          },
        ),
      ),
    );
  }

  Future<void> _showTranscription(BuildContext context) async {
    final cubit = context.read<PlayerCubit>();
    final quoteCubit = context.read<QuoteTranscriptionCubit>();
    final state = cubit.state;
    final book = state.book;
    if (book == null) {
      return;
    }
    if (state.isPlaying) {
      await cubit.togglePlayback();
    }
    if (!context.mounted) {
      return;
    }
    quoteCubit.prepare(
      book: book,
      chapterTitle: state.currentChapter?.title,
      chapterStart: state.chapterStart,
      chapterDuration: state.chapterDuration > Duration.zero
          ? state.chapterDuration
          : state.duration,
      anchor: state.chapterPosition,
    );
    final draft = await showModalBottomSheet<TranscriptionDraft>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => BlocProvider.value(
        value: quoteCubit,
        child: _TranscriptionSheet(
          chapterTitle: state.currentChapter?.title,
          chapterDuration: state.chapterDuration > Duration.zero
              ? state.chapterDuration
              : state.duration,
        ),
      ),
    );
    if (draft == null || !context.mounted) {
      return;
    }
    await Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider.value(value: cubit),
            BlocProvider.value(value: quoteCubit),
          ],
          child: TranscriptionPreviewScreen(draft: draft),
        ),
      ),
    );
  }

  void _showChapters(BuildContext context, List<PlayerChapter> chapters) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(
        value: context.read<PlayerCubit>(),
        child: _ChaptersSheet(chapters: chapters),
      ),
    );
  }

  void _showSleepTimer(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (_) => BlocProvider.value(
        value: context.read<PlayerCubit>(),
        child: const _SleepTimerSheet(),
      ),
    );
  }
}
