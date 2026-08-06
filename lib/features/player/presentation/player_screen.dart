import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/navigation/app_router.dart';
import '../../../core/presentation/book_cover.dart';
import '../../../core/presentation/formatters.dart';
import '../domain/book_note.dart';
import '../domain/transcription_draft.dart';
import 'note_detail_screen.dart';
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

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  var _canPop = false;

  void _requestPop() {
    if (_canPop) {
      return;
    }
    setState(() => _canPop = true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        unawaited(Navigator.maybePop(context));
      }
    });
  }

  void _onPopInvoked(bool didPop) {
    if (didPop) {
      unawaited(context.read<PlayerCubit>().saveProgress());
      return;
    }
    _requestPop();
  }

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
        return PopScope<void>(
          canPop: _canPop,
          onPopInvokedWithResult: (didPop, _) => _onPopInvoked(didPop),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              leadingWidth: 64,
              leading: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: _PlayerTopButton(
                  tooltip: 'Back to library',
                  onPressed: _requestPop,
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
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isLandscape =
                      constraints.maxWidth > constraints.maxHeight;
                  final artwork = _PlayerArtwork(state: state);
                  final details = _PlayerDetails(
                    state: state,
                    compact: isLandscape,
                    onChapters: state.chapterTimeline.isEmpty
                        ? null
                        : () => widget._showChapters(
                            context,
                            state.chapterTimeline,
                            state.currentChapterIndex,
                          ),
                    onTimer: () => widget._showSleepTimer(context),
                    onNotes: () => widget._showNotes(context),
                    onQuote: () => widget._showTranscription(context),
                  );

                  if (isLandscape) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(28, 8, 28, 12),
                      child: Row(
                        children: [
                          Expanded(flex: 4, child: artwork),
                          const SizedBox(width: 28),
                          Expanded(
                            flex: 7,
                            child: LayoutBuilder(
                              builder: (context, detailConstraints) {
                                return Center(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: SizedBox(
                                      width: detailConstraints.maxWidth,
                                      child: details,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.fromLTRB(28, 18, 28, 22),
                    child: Column(
                      children: [
                        Expanded(child: artwork),
                        const SizedBox(height: 24),
                        details,
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PlayerArtwork extends StatelessWidget {
  const _PlayerArtwork({required this.state});

  final PlayerState state;

  @override
  Widget build(BuildContext context) {
    final book = state.book!;
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest.shortestSide.clamp(150.0, 290.0);
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
    );
  }
}

class _PlayerDetails extends StatelessWidget {
  const _PlayerDetails({
    required this.state,
    required this.compact,
    required this.onChapters,
    required this.onTimer,
    required this.onNotes,
    required this.onQuote,
  });

  final PlayerState state;
  final bool compact;
  final VoidCallback? onChapters;
  final VoidCallback onTimer;
  final VoidCallback onNotes;
  final VoidCallback onQuote;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          state.book!.title,
          maxLines: 2,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
            height: 1.2,
          ),
        ),
        SizedBox(height: compact ? 18 : 26),
        _Timeline(state: state),
        SizedBox(height: compact ? 12 : 18),
        _Transport(state: state),
        SizedBox(height: compact ? 10 : 18),
        _PlayerTools(
          state: state,
          onChapters: onChapters,
          onTimer: onTimer,
          onNotes: onNotes,
          onQuote: onQuote,
        ),
      ],
    );
  }
}
