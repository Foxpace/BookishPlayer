import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../voice_note_cubit.dart';
import '../voice_note_state.dart';

class VoiceNoteSheet extends StatelessWidget {
  const VoiceNoteSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VoiceNoteCubit, VoiceNoteState>(
      builder: (context, state) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Voice note',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                state.text.isEmpty
                    ? 'Tap the microphone and speak.'
                    : state.text,
                textAlign: TextAlign.center,
              ),
              if (state.message != null) ...[
                const SizedBox(height: 8),
                Text(
                  state.message!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ],
              const SizedBox(height: 20),
              IconButton.filled(
                tooltip: state.status == VoiceNoteStatus.listening
                    ? 'Stop listening'
                    : 'Start listening',
                onPressed: context.read<VoiceNoteCubit>().toggle,
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
                      : () => Navigator.pop(context, state.text.trim()),
                  child: const Text('Save voice note'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
