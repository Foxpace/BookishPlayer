import 'package:flutter/material.dart';

import '../../../../../core/localization/generated/l10n.dart';
import '../../../../../core/presentation/app_message.dart';
import '../../cubits/notes_cubits.dart';

class VoiceNoteSheet extends StatelessWidget {
  const VoiceNoteSheet({
    required this.state,
    required this.onToggle,
    required this.onSave,
    super.key,
  });

  final VoiceNoteState state;
  final VoidCallback onToggle;
  final ValueChanged<String> onSave;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              S.of(context).voiceNote,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            Text(
              state.text.isEmpty ? S.of(context).voiceNotePrompt : state.text,
              textAlign: TextAlign.center,
            ),
            if (state.message case final message?) ...[
              const SizedBox(height: 8),
              Text(
                message.localize(context),
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ],
            const SizedBox(height: 20),
            IconButton.filled(
              tooltip: state.status == VoiceNoteStatus.listening
                  ? S.of(context).stopListening
                  : S.of(context).startListening,
              onPressed: onToggle,
              iconSize: 34,
              icon: Icon(
                state.status == VoiceNoteStatus.listening
                    ? Icons.stop_rounded
                    : Icons.mic_rounded,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: state.text.trim().isEmpty
                    ? null
                    : () => onSave(state.text.trim()),
                child: Text(S.of(context).saveVoiceNote),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
