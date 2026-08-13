import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubits/player_cubit.dart';
import 'cubits/player_cubits.dart';
import 'ui/widgets/chapters_sheet.dart';

class PlayerChaptersSheetRoot extends StatelessWidget {
  const PlayerChaptersSheetRoot({required this.cubit, super.key});

  final PlayerCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PlayerCubit>.value(
      value: cubit,
      child: BlocBuilder<PlayerCubit, PlayerState>(
        builder: (context, state) => ChaptersSheet(
          chapters: state.chapterTimeline,
          activeIndex: state.currentChapterIndex,
          state: state,
          onSelectChapter: (chapter) {
            cubit.seek(chapter.start);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
