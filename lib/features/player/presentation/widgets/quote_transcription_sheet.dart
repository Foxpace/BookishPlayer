part of '../player_screen.dart';

class _TranscriptionSheet extends StatelessWidget {
  const _TranscriptionSheet({
    required this.chapterTitle,
    required this.chapterDuration,
  });

  final String? chapterTitle;
  final Duration chapterDuration;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuoteTranscriptionCubit, QuoteTranscriptionState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status == QuoteTranscriptionStatus.complete,
      listener: (context, state) => Navigator.pop(context, state.draft),
      builder: (context, state) {
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
                  Text(
                    'Transcribe a quote',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Choose the exact part of the audiobook. Transcription happens on this device and can take a while, especially for longer selections.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.menu_book_rounded),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                chapterTitle ?? 'Audiobook',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.titleSmall
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '${formatDuration(range.start)} – ${formatDuration(range.end)} in chapter',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('From ${formatDuration(range.start)}'),
                      Text('To ${formatDuration(range.end)}'),
                    ],
                  ),
                  QuoteRangeSlider(
                    start: range.start,
                    end: range.end,
                    chapterDuration: chapterDuration,
                    enabled: !working,
                    onStartChanged: context
                        .read<QuoteTranscriptionCubit>()
                        .setStart,
                    onEndChanged: context
                        .read<QuoteTranscriptionCubit>()
                        .setEnd,
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [15, 30, 60, 120]
                        .map(
                          (seconds) => ActionChip(
                            label: Text(
                              seconds == 120
                                  ? 'Last 2 min'
                                  : 'Last $seconds sec',
                            ),
                            onPressed: working
                                ? null
                                : () => context
                                      .read<QuoteTranscriptionCubit>()
                                      .applyPreset(Duration(seconds: seconds)),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: working
                              ? null
                              : () => context
                                    .read<QuoteTranscriptionCubit>()
                                    .shift(const Duration(seconds: -15)),
                          icon: const Icon(Icons.arrow_back_rounded),
                          label: const Text('15 sec earlier'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: working
                              ? null
                              : () => context
                                    .read<QuoteTranscriptionCubit>()
                                    .shift(const Duration(seconds: 15)),
                          icon: const Icon(Icons.arrow_forward_rounded),
                          label: const Text('15 sec later'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: working
                          ? null
                          : context.read<QuoteTranscriptionCubit>().transcribe,
                      icon: working
                          ? const SizedBox.square(
                              dimension: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.graphic_eq_rounded),
                      label: Text(
                        working
                            ? 'Transcribing on device…'
                            : 'Transcribe range',
                      ),
                    ),
                  ),
                  if (state.message case final error?) ...[
                    const SizedBox(height: 10),
                    Text(
                      error,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
