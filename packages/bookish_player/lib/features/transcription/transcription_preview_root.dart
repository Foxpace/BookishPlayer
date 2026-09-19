import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/di/injection.dart';
import '../../core/localization/generated/l10n.dart';
import '../player/models/share_origin.dart';
import 'cubits/transcription_preview_cubit.dart';
import 'cubits/transcription_preview_effect.dart';
import 'cubits/transcription_preview_state.dart';
import 'models/transcription_draft.dart';
import 'ui/transcription_preview_screen.dart';
import 'use_cases/quote_transcription_application.dart';

/// Composition boundary for previewing, saving, and sharing one transcription.
class TranscriptionPreviewRoot extends StatelessWidget {
  const TranscriptionPreviewRoot({
    required this.draft,
    required this.onSave,
    super.key,
  });

  final TranscriptionDraft draft;
  final StoreTranscriptionNote onSave;

  @override
  Widget build(BuildContext context) {
    final application = getIt<QuoteTranscriptionApplication>();
    return BlocProvider<TranscriptionPreviewCubit>(
      create: (_) => TranscriptionPreviewCubit(
        draft: draft,
        storeNote: onSave,
        shareDraft: application.shareDraft,
      ),
      child: BlocConsumer<TranscriptionPreviewCubit, TranscriptionPreviewState>(
        listenWhen: (previous, current) =>
            current.effect != null &&
            current.effectRevision != previous.effectRevision,
        listener: _handleEffect,
        builder: (context, state) {
          final cubit = context.read<TranscriptionPreviewCubit>();
          return TranscriptionPreviewScreen(
            state: state,
            onEdit: cubit.edit,
            onSave: cubit.save,
            onSaveAndShare: (buttonContext) =>
                _saveAndShare(buttonContext, cubit, state.draft.book.title),
          );
        },
      ),
    );
  }

  void _saveAndShare(
    BuildContext buttonContext,
    TranscriptionPreviewCubit cubit,
    String bookTitle,
  ) {
    final box = buttonContext.findRenderObject() as RenderBox?;
    final rect = box == null ? null : box.localToGlobal(Offset.zero) & box.size;
    cubit.saveAndShare(
      subject: S.of(buttonContext).quoteShareSubject(bookTitle),
      origin: rect == null
          ? null
          : ShareOrigin(
              x: rect.left,
              y: rect.top,
              width: rect.width,
              height: rect.height,
            ),
    );
  }

  void _handleEffect(BuildContext context, TranscriptionPreviewState state) {
    final messenger = ScaffoldMessenger.of(context);
    final savedMessage = S.of(context).quoteSavedToNotes;
    switch (state.effect) {
      case TranscriptionPreviewEffect.saved:
        Navigator.pop(context);
        messenger.showSnackBar(SnackBar(content: Text(savedMessage)));
        return;
      case TranscriptionPreviewEffect.shared:
        Navigator.pop(context);
        messenger.showSnackBar(SnackBar(content: Text(savedMessage)));
        return;
      case null:
        return;
    }
  }
}
