import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/navigation/app_router.dart';
import '../../../core/presentation/book_cover.dart';
import '../../../core/presentation/formatters.dart';
import '../domain/book_note.dart';
import 'player_cubit.dart';
import 'player_state.dart';

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

class _PlayerTopButton extends StatelessWidget {
  const _PlayerTopButton({
    required this.tooltip,
    required this.onPressed,
    required this.icon,
  });

  final String tooltip;
  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.square(
        dimension: 44,
        child: IconButton.filledTonal(
          tooltip: tooltip,
          onPressed: onPressed,
          padding: EdgeInsets.zero,
          icon: Icon(icon, size: 24),
        ),
      ),
    );
  }
}

class _SleepTimerSheet extends StatelessWidget {
  const _SleepTimerSheet();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerCubit, PlayerState>(
      builder: (context, state) {
        final cubit = context.read<PlayerCubit>();
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 4, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sleep timer',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (state.sleepTimerType != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    _activeTimerLabel(state),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [15, 30, 45, 60]
                      .map(
                        (minutes) => ActionChip(
                          label: Text('$minutes min'),
                          onPressed: () {
                            cubit.setSleepTimer(Duration(minutes: minutes));
                            Navigator.pop(context);
                          },
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 10),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.skip_next_rounded),
                  title: const Text('End of chapter'),
                  subtitle: const Text('Stop at the next chapter boundary'),
                  enabled: state.book?.chapters.isNotEmpty ?? false,
                  onTap: () {
                    cubit.sleepAtEndOfChapter();
                    Navigator.pop(context);
                  },
                ),
                if (state.sleepTimerType != null)
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        cubit.cancelSleepTimer();
                        Navigator.pop(context);
                      },
                      child: const Text('Turn off timer'),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _activeTimerLabel(PlayerState state) {
    if (state.sleepTimerType == SleepTimerType.endOfChapter) {
      return 'Stops at end of chapter';
    }
    final remaining = state.sleepEndsAt?.difference(DateTime.now());
    if (remaining == null) {
      return 'Timer active';
    }
    final minutes =
        remaining.inMinutes + (remaining.inSeconds % 60 > 0 ? 1 : 0);
    return 'About $minutes minutes remaining';
  }
}

class _ChaptersSheet extends StatelessWidget {
  const _ChaptersSheet({required this.chapters});

  final List<PlayerChapter> chapters;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * .65,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 4, 24, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Chapters',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.separated(
                  itemCount: chapters.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final chapter = chapters[index];
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(child: Text('${index + 1}')),
                      title: Text(chapter.title),
                      subtitle: Text(
                        'Length ${formatDuration(chapter.duration)}',
                      ),
                      onTap: () {
                        context.read<PlayerCubit>().seek(chapter.start);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Timeline extends StatelessWidget {
  const _Timeline({required this.state});

  final PlayerState state;

  @override
  Widget build(BuildContext context) {
    final max = state.chapterDuration.inMilliseconds.toDouble().clamp(
      1.0,
      double.infinity,
    );
    final value = state.chapterPosition.inMilliseconds.toDouble().clamp(
      0.0,
      max,
    );
    return Column(
      children: [
        if (state.currentChapter case final chapter?) ...[
          Row(
            children: [
              Expanded(
                child: Text(
                  chapter.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${state.currentChapterIndex + 1} / ${state.chapterCount}',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
        Slider(
          value: value,
          max: max,
          secondaryTrackValue: state.chapterBufferedPosition.inMilliseconds
              .toDouble()
              .clamp(0.0, max),
          onChanged: (next) => context.read<PlayerCubit>().seekWithinChapter(
            Duration(milliseconds: next.round()),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                formatDuration(state.chapterPosition),
                style: Theme.of(context).textTheme.labelMedium,
              ),
              Text(
                formatRemaining(state.chapterPosition, state.chapterDuration),
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Transport extends StatelessWidget {
  const _Transport({required this.state});

  final PlayerState state;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PlayerCubit>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: IconButton(
            tooltip: 'Previous chapter',
            onPressed: state.book?.chapters.isNotEmpty == true
                ? cubit.previousChapter
                : null,
            icon: const Icon(Icons.skip_previous_rounded, size: 38),
          ),
        ),
        Expanded(
          child: _SkipButton(
            label: '15',
            icon: Icons.replay_rounded,
            onPressed: () => cubit.skipBy(const Duration(seconds: -15)),
          ),
        ),
        SizedBox.square(
          dimension: 72,
          child: FilledButton(
            onPressed: state.status == PlayerStatus.ready
                ? cubit.togglePlayback
                : null,
            style: FilledButton.styleFrom(
              shape: const CircleBorder(),
              padding: EdgeInsets.zero,
            ),
            child: state.status == PlayerStatus.loading
                ? const SizedBox.square(
                    dimension: 26,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Icon(
                    state.isPlaying
                        ? Icons.pause_rounded
                        : Icons.play_arrow_rounded,
                    size: 40,
                  ),
          ),
        ),
        Expanded(
          child: _SkipButton(
            label: '15',
            icon: Icons.replay_rounded,
            flipIcon: true,
            onPressed: () => cubit.skipBy(const Duration(seconds: 15)),
          ),
        ),
        Expanded(
          child: IconButton(
            tooltip: 'Next chapter',
            onPressed: state.book?.chapters.isNotEmpty == true
                ? cubit.nextChapter
                : null,
            icon: const Icon(Icons.skip_next_rounded, size: 38),
          ),
        ),
      ],
    );
  }
}

class _SkipButton extends StatelessWidget {
  const _SkipButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    this.flipIcon = false,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final bool flipIcon;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onPressed,
      radius: 30,
      child: SizedBox.square(
        dimension: 56,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Transform.flip(flipX: flipIcon, child: Icon(icon, size: 44)),
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SpeedButton extends StatelessWidget {
  const _SpeedButton({required this.speed});

  final double speed;

  static const speeds = [0.75, 1.0, 1.25, 1.5, 1.75, 2.0];

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<double>(
      tooltip: 'Playback speed',
      initialValue: speed,
      onSelected: context.read<PlayerCubit>().changeSpeed,
      itemBuilder: (_) => speeds
          .map((value) => PopupMenuItem(value: value, child: Text('$value×')))
          .toList(),
      child: _ToolVisual(
        icon: Icons.speed_rounded,
        label: '${speed == .75 ? '0.75' : speed.toStringAsFixed(1)}×',
      ),
    );
  }
}

class _PlayerTools extends StatelessWidget {
  const _PlayerTools({
    required this.state,
    required this.onChapters,
    required this.onTimer,
    required this.onNotes,
  });

  final PlayerState state;
  final VoidCallback? onChapters;
  final VoidCallback onTimer;
  final VoidCallback onNotes;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _SpeedButton(speed: state.speed)),
        Expanded(
          child: _ToolButton(
            tooltip: 'Chapters',
            onPressed: onChapters,
            child: const _ToolVisual(
              icon: Icons.format_list_numbered_rounded,
              label: 'Chapters',
            ),
          ),
        ),
        Expanded(
          child: _ToolButton(
            tooltip: 'Sleep timer',
            onPressed: onTimer,
            child: _ToolVisual(
              icon: Icons.timer_outlined,
              label: 'Timer',
              showBadge: state.sleepTimerType != null,
            ),
          ),
        ),
        Expanded(
          child: _ToolButton(
            tooltip: 'Notes and bookmarks',
            onPressed: onNotes,
            child: _ToolVisual(
              icon: Icons.bookmark_add_outlined,
              label: 'Notes',
              badgeLabel: state.notes.isEmpty ? null : '${state.notes.length}',
            ),
          ),
        ),
      ],
    );
  }
}

class _ToolButton extends StatelessWidget {
  const _ToolButton({
    required this.tooltip,
    required this.onPressed,
    required this.child,
  });

  final String tooltip;
  final VoidCallback? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Opacity(opacity: onPressed == null ? .38 : 1, child: child),
      ),
    );
  }
}

class _ToolVisual extends StatelessWidget {
  const _ToolVisual({
    required this.icon,
    required this.label,
    this.showBadge = false,
    this.badgeLabel,
  });

  final IconData icon;
  final String label;
  final bool showBadge;
  final String? badgeLabel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Badge(
            isLabelVisible: showBadge || badgeLabel != null,
            label: badgeLabel == null ? null : Text(badgeLabel!),
            child: Icon(icon, size: 27),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}

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
        child: Text(formatDuration(Duration(milliseconds: note.positionMs))),
      ),
      trailing: IconButton(
        tooltip: 'Delete note',
        onPressed: () => cubit.deleteNote(note),
        icon: const Icon(Icons.delete_outline_rounded),
      ),
    );
  }
}
