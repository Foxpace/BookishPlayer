import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/di/injection.dart';
import '../library/models/library_models.dart';
import 'cubits/quote_transcription_cubit.dart';
import 'cubits/transcription_cubits.dart';
import 'ui/widgets/transcription_sheet.dart';

/// Composition boundary for one quote-transcription interaction.
class QuoteTranscriptionRoot extends StatelessWidget {
  const QuoteTranscriptionRoot({
    required this.book,
    required this.chapter,
    super.key,
  });

  final Audiobook book;
  final ({String? title, Duration start, Duration duration, Duration anchor})
  chapter;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QuoteTranscriptionCubit>(
      create: (_) => getIt<QuoteTranscriptionCubit>()
        ..prepare(
          book: book,
          chapterTitle: chapter.title,
          chapterStart: chapter.start,
          chapterDuration: chapter.duration,
          anchor: chapter.anchor,
        ),
      child: BlocConsumer<QuoteTranscriptionCubit, QuoteTranscriptionState>(
        listenWhen: (previous, current) =>
            previous.status != current.status &&
            current.status == QuoteTranscriptionStatus.complete,
        listener: (context, state) => Navigator.pop(context, state.draft),
        builder: (context, state) {
          final cubit = context.read<QuoteTranscriptionCubit>();
          return TranscriptionSheet(
            state: state,
            chapter: (title: chapter.title, duration: chapter.duration),
            actions: (
              onStartChanged: cubit.setStart,
              onEndChanged: cubit.setEnd,
              onPreset: cubit.applyPreset,
              onShift: cubit.shift,
              onTranscribe: cubit.transcribe,
            ),
          );
        },
      ),
    );
  }
}
