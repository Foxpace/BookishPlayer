import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../../cubits/player_cubits.dart';
import 'player_speed_button.dart';
import 'player_tool_button.dart';

class PlayerTools extends StatelessWidget {
  const PlayerTools({required this.state, required this.actions, super.key});

  final PlayerState state;
  final ({
    VoidCallback? onPickAudioOutput,
    VoidCallback? onChapters,
    VoidCallback onTimer,
    VoidCallback onNotes,
    VoidCallback onQuote,
    ValueChanged<double> onSpeedChanged,
  })
  actions;

  @override
  Widget build(BuildContext context) {
    return _PlayerToolsRow(state: state, actions: actions);
  }
}

class _PlayerToolsRow extends StatelessWidget {
  const _PlayerToolsRow({required this.state, required this.actions});

  final PlayerState state;
  final ({
    VoidCallback? onPickAudioOutput,
    VoidCallback? onChapters,
    VoidCallback onTimer,
    VoidCallback onNotes,
    VoidCallback onQuote,
    ValueChanged<double> onSpeedChanged,
  })
  actions;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _PlayerOutputTool(onPressed: actions.onPickAudioOutput),
        Expanded(
          child: PlayerSpeedButton(
            speed: state.speed,
            onChanged: actions.onSpeedChanged,
          ),
        ),
        _PlayerQuoteTool(onPressed: actions.onQuote),
        _PlayerChaptersTool(onPressed: actions.onChapters),
        Expanded(
          child: PlayerToolButton(
            content: (
              tooltip: S.of(context).sleepTimer,
              icon: Icons.timer_outlined,
              label: S.of(context).timer,
            ),
            onPressed: actions.onTimer,
            showBadge: state.sleepTimerType != null,
          ),
        ),
        Expanded(
          child: PlayerToolButton(
            content: (
              tooltip: S.of(context).notesAndBookmarks,
              icon: Icons.note_alt_outlined,
              label: S.of(context).notes,
            ),
            onPressed: actions.onNotes,
            badgeLabel: state.notes.isEmpty ? null : '${state.notes.length}',
          ),
        ),
      ],
    );
  }
}

class _PlayerOutputTool extends StatelessWidget {
  const _PlayerOutputTool({required this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => Expanded(
    child: PlayerToolButton(
      content: (
        tooltip: S.of(context).chooseAudioOutput,
        icon: Icons.speaker_group_outlined,
        label: S.of(context).output,
      ),
      onPressed: onPressed,
    ),
  );
}

class _PlayerQuoteTool extends StatelessWidget {
  const _PlayerQuoteTool({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Expanded(
    child: PlayerToolButton(
      content: (
        tooltip: S.of(context).transcribeQuote,
        icon: Icons.format_quote_rounded,
        label: S.of(context).quote,
      ),
      onPressed: onPressed,
    ),
  );
}

class _PlayerChaptersTool extends StatelessWidget {
  const _PlayerChaptersTool({required this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => Expanded(
    child: PlayerToolButton(
      content: (
        tooltip: S.of(context).chaptersTitle,
        icon: Icons.format_list_numbered_rounded,
        label: S.of(context).chapters,
      ),
      onPressed: onPressed,
    ),
  );
}
