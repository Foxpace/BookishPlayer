import 'package:flutter/material.dart';

import '../../../core/localization/generated/l10n.dart';
import '../../../core/presentation/app_message.dart';
import '../../../core/presentation/bookish_scaffold.dart';
import '../../../core/presentation/diagnostic_failure_view.dart';
import '../cubits/player_cubits.dart';
import '../cubits/player_ui_intents.dart';
import 'widgets/player_app_bar.dart';
import 'widgets/player_content.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({
    required this.state,
    required this.intents,
    required this.actions,
    super.key,
  });

  final PlayerState state;
  final PlayerPlaybackIntents intents;
  final ({
    VoidCallback onDidPop,
    VoidCallback onBack,
    VoidCallback onOpenSettings,
    ValueChanged<Duration> onTimelineSeek,
    VoidCallback? onPickAudioOutput,
    VoidCallback onShowChapters,
    VoidCallback onShowSleepTimer,
    VoidCallback onShowNotes,
    VoidCallback? onTranscribeQuote,
  })
  actions;

  @override
  Widget build(BuildContext context) {
    final book = state.book;
    if (book == null) {
      return BookishScaffold(
        appBar: AppBar(),
        body: state.status == PlayerStatus.failure
            ? DiagnosticFailureView.fromMessage(
                message:
                    state.message?.localize(context) ??
                    S.of(context).noAudiobookSelected,
              )
            : const Center(child: CircularProgressIndicator()),
      );
    }
    return PopScope<void>(
      canPop: true,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          actions.onDidPop();
        }
      },
      child: BookishScaffold(
        appBar: PlayerAppBar(
          onBack: actions.onBack,
          onOpenSettings: actions.onOpenSettings,
        ),
        body: PlayerContent(
          state: state,
          book: book,
          intents: intents,
          actions: (
            onTimelineSeek: actions.onTimelineSeek,
            onPickAudioOutput: actions.onPickAudioOutput,
            onChapters: state.chapterTimeline.isEmpty
                ? null
                : actions.onShowChapters,
            onTimer: actions.onShowSleepTimer,
            onNotes: actions.onShowNotes,
            onQuote: actions.onTranscribeQuote,
          ),
        ),
      ),
    );
  }
}
