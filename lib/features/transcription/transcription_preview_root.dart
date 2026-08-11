import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/di/injection.dart';
import 'cubits/quote_transcription_cubit.dart';
import 'models/transcription_draft.dart';
import 'ui/transcription_preview_screen.dart';

/// Composition boundary for previewing, saving, and sharing one transcription.
class TranscriptionPreviewRoot extends StatelessWidget {
  const TranscriptionPreviewRoot({
    required this.draft,
    required this.onSave,
    super.key,
  });

  final TranscriptionDraft draft;
  final SaveTranscribedQuote onSave;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QuoteTranscriptionCubit>(
      create: (_) => getIt<QuoteTranscriptionCubit>(),
      child: Builder(
        builder: (context) => TranscriptionPreviewScreen(
          draft: draft,
          onSave: onSave,
          onShare: (text, {required subject, origin}) => context
              .read<QuoteTranscriptionCubit>()
              .shareDraft(draft, text, subject: subject, origin: origin),
        ),
      ),
    );
  }
}
