import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../../../../core/presentation/app_message.dart';
import '../../cubits/transcription_cubits.dart';
import 'quote_range_controls.dart';
import 'transcription_range_header.dart';

class TranscriptionSheet extends StatelessWidget {
  const TranscriptionSheet({
    required this.state,
    required this.chapter,
    required this.actions,
    super.key,
  });

  final QuoteTranscriptionState state;
  final ({String? title, Duration duration}) chapter;
  final ({
    ValueChanged<Duration> onStartChanged,
    ValueChanged<Duration> onEndChanged,
    ValueChanged<Duration> onPreset,
    ValueChanged<Duration> onShift,
    VoidCallback onTranscribe,
  })
  actions;

  @override
  Widget build(BuildContext context) {
    final range = state.range;
    if (range == null) {
      return const SizedBox.shrink();
    }
    final working = state.status == QuoteTranscriptionStatus.transcribing;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          24,
          4,
          24,
          20 + MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TranscriptionRangeHeader(
                chapterTitle: chapter.title,
                range: range,
              ),
              const SizedBox(height: 18),
              QuoteRangeControls(
                range: range,
                configuration: (
                  chapterDuration: chapter.duration,
                  enabled: !working,
                ),
                actions: (
                  onStartChanged: actions.onStartChanged,
                  onEndChanged: actions.onEndChanged,
                  onPreset: actions.onPreset,
                  onShift: actions.onShift,
                ),
              ),
              const SizedBox(height: 14),
              _TranscribeButton(
                working: working,
                onPressed: actions.onTranscribe,
              ),
              if (state.message case final error?) ...[
                const SizedBox(height: 10),
                Text(
                  error.localize(context),
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _TranscribeButton extends StatelessWidget {
  const _TranscribeButton({required this.working, required this.onPressed});

  final bool working;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: working ? null : onPressed,
        icon: working
            ? const SizedBox.square(
                dimension: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Icon(Icons.graphic_eq_rounded),
        label: Text(
          working
              ? S.of(context).transcribingOnDevice
              : S.of(context).transcribeRange,
        ),
      ),
    );
  }
}
