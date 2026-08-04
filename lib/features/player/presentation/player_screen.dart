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
import 'voice_note_cubit.dart';
import 'widgets/voice_note_sheet.dart';

part 'widgets/player_sheets.dart';
part 'widgets/player_timeline.dart';
part 'widgets/player_controls.dart';
part 'widgets/skip_button.dart';
part 'widgets/player_notes.dart';
part 'widgets/book_map_sheet.dart';
part 'widgets/quote_transcription_sheet.dart';
part 'player_screen_actions.dart';

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
                          : () => _showChapters(
                              context,
                              state.chapterTimeline,
                              state.currentChapterIndex,
                            ),
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
}
