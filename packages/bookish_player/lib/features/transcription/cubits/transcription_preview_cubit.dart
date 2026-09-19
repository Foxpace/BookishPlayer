import 'package:flutter_bloc/flutter_bloc.dart';

import '../../player/models/share_origin.dart';
import '../models/transcription_draft.dart';
import 'transcription_preview_effect.dart';
import 'transcription_preview_state.dart';
import 'transcription_preview_status.dart';

typedef StoreTranscriptionNote =
    Future<void> Function(String text, TranscriptionDraft draft);
typedef ShareTranscriptionDraft =
    Future<void> Function(
      TranscriptionDraft draft,
      String text, {
      required String subject,
      ShareOrigin? origin,
    });

class TranscriptionPreviewCubit extends Cubit<TranscriptionPreviewState> {
  factory TranscriptionPreviewCubit({
    required TranscriptionDraft draft,
    required StoreTranscriptionNote storeNote,
    required ShareTranscriptionDraft shareDraft,
  }) => TranscriptionPreviewCubit._(draft, storeNote, shareDraft);

  TranscriptionPreviewCubit._(
    TranscriptionDraft draft,
    this._storeNote,
    this._shareDraft,
  ) : super(TranscriptionPreviewState(draft: draft, text: draft.text));

  final StoreTranscriptionNote _storeNote;
  final ShareTranscriptionDraft _shareDraft;

  void edit(String text) {
    if (_isBusy) {
      return;
    }
    emit(state.copyWith(text: text, effect: null));
  }

  Future<void> save() async {
    final text = _preparedText;
    if (text == null) {
      return;
    }
    emit(state.copyWith(status: TranscriptionPreviewStatus.saving));
    await _storeNote(text, state.draft);
    _complete(TranscriptionPreviewEffect.saved);
  }

  Future<void> saveAndShare({
    required String subject,
    ShareOrigin? origin,
  }) async {
    final text = _preparedText;
    if (text == null) {
      return;
    }
    emit(state.copyWith(status: TranscriptionPreviewStatus.sharing));
    await _storeNote(text, state.draft);
    await _shareDraft(state.draft, text, subject: subject, origin: origin);
    _complete(TranscriptionPreviewEffect.shared);
  }

  String? get _preparedText {
    if (_isBusy) {
      return null;
    }
    final text = state.text.trim();
    return text.isEmpty ? null : text;
  }

  bool get _isBusy => state.status != TranscriptionPreviewStatus.ready;

  void _complete(TranscriptionPreviewEffect effect) {
    emit(
      state.copyWith(
        status: TranscriptionPreviewStatus.ready,
        effect: effect,
        effectRevision: state.effectRevision + 1,
      ),
    );
  }
}
