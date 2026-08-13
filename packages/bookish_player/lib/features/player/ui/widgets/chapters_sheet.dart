import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../../cubits/player_cubits.dart';
import 'chapter_tile.dart';

class ChaptersSheet extends StatefulWidget {
  const ChaptersSheet({
    required this.chapters,
    required this.activeIndex,
    required this.state,
    required this.onSelectChapter,
    super.key,
  });

  final List<PlayerChapter> chapters;
  final int activeIndex;
  final PlayerState state;
  final ValueChanged<PlayerChapter> onSelectChapter;

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
    final state = widget.state;
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * .72,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 4, 24, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).chapters,
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
                    return ChapterTile(
                      chapter: chapter,
                      status: (
                        index: index,
                        position: state.position,
                        active: index == state.currentChapterIndex,
                      ),
                      onTap: () => widget.onSelectChapter(chapter),
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
