part of '../player_screen.dart';

class ChaptersSheet extends StatefulWidget {
  const ChaptersSheet({
    required this.chapters,
    required this.activeIndex,
    super.key,
  });

  final List<PlayerChapter> chapters;
  final int activeIndex;

  @override
  State<ChaptersSheet> createState() => _ScrollableChaptersSheetState();
}

class _ScrollableChaptersSheetState extends State<ChaptersSheet> {
  static const _itemExtent = 88.0;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    final preceding = widget.activeIndex > 0 ? widget.activeIndex - 1 : 0;
    _scrollController = ScrollController(
      initialScrollOffset: preceding * _itemExtent,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerCubit, PlayerState>(
      builder: (context, state) => SafeArea(
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height * .72,
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
                const SizedBox(height: 6),
                Text(
                  '${widget.chapters.length} chapters · currently on ${widget.activeIndex + 1}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemExtent: _itemExtent,
                    itemCount: widget.chapters.length,
                    itemBuilder: (context, index) {
                      final chapter = widget.chapters[index];
                      final end = chapter.start + chapter.duration;
                      final progress = state.position <= chapter.start
                          ? 0.0
                          : state.position >= end
                          ? 1.0
                          : chapter.duration == Duration.zero
                          ? 0.0
                          : ((state.position - chapter.start).inMilliseconds /
                                    chapter.duration.inMilliseconds)
                                .clamp(0.0, 1.0);
                      final active = index == state.currentChapterIndex;
                      return Card(
                        color: active
                            ? Theme.of(context).colorScheme.primaryContainer
                            : null,
                        child: ListTile(
                          onTap: () {
                            context.read<PlayerCubit>().seek(chapter.start);
                            Navigator.pop(context);
                          },
                          leading: CircleAvatar(child: Text('${index + 1}')),
                          title: Text(
                            chapter.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: LinearProgressIndicator(value: progress),
                          ),
                          trailing: Text('${(progress * 100).round()}%'),
                        ),
                      );
                    },
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
