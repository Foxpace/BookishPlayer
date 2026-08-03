part of 'player_screen.dart';

extension _PlayerScreenActions on PlayerScreen {
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
          onAddNote: () => _reopenNoteComposer(context),
          onAddVoiceNote: () => _reopenVoiceComposer(context),
        ),
      ),
    );
  }

  Future<void> _reopenNoteComposer(BuildContext context) async {
    Navigator.pop(context);
    await Future<void>.delayed(Duration.zero);
    if (context.mounted) {
      await _addNote(context);
    }
  }

  Future<void> _reopenVoiceComposer(BuildContext context) async {
    Navigator.pop(context);
    await Future<void>.delayed(Duration.zero);
    if (context.mounted) {
      await _addVoiceNote(context);
    }
  }

  Future<void> _addVoiceNote(BuildContext context) async {
    final voiceCubit = context.read<VoiceNoteCubit>();
    final text = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) =>
          BlocProvider.value(value: voiceCubit, child: const VoiceNoteSheet()),
    );
    if (text != null && text.trim().isNotEmpty && context.mounted) {
      await context.read<PlayerCubit>().addVoiceNote(text);
    }
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

  void _showChapters(
    BuildContext context,
    List<PlayerChapter> chapters,
    int activeIndex,
  ) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(
        value: context.read<PlayerCubit>(),
        child: ChaptersSheet(chapters: chapters, activeIndex: activeIndex),
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
