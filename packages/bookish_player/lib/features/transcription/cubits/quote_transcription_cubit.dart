import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/presentation/app_message.dart';
import '../../library/models/library_models.dart';
import '../../player/models/share_origin.dart';
import '../models/quote_transcription_context.dart';
import '../models/quote_time_range.dart';
import '../models/transcription_draft.dart';
import '../use_cases/quote_transcription_application.dart';
import 'transcription_cubits.dart';

@Environment('internal')
@injectable
class QuoteTranscriptionCubit extends Cubit<QuoteTranscriptionState> {
  QuoteTranscriptionCubit(this._application)
    : super(const QuoteTranscriptionState());

  final QuoteTranscriptionApplication _application;

  void prepare({
    required Audiobook book,
    required String? chapterTitle,
    required Duration chapterStart,
    required Duration chapterDuration,
    required Duration anchor,
  }) {
    emit(
      QuoteTranscriptionState(
        status: QuoteTranscriptionStatus.ready,
        effectRevision: state.effectRevision,

        context: QuoteTranscriptionContext(
          book: book,
          chapterTitle: chapterTitle,
          chapterStart: chapterStart,
        ),

        range: QuoteTimeRange.initial(
          chapterDuration: chapterDuration,
          anchor: anchor,
        ),
      ),
    );
  }

  void setStart(Duration value) => _updateRange(state.range?.withStart(value));

  void setEnd(Duration value) => _updateRange(state.range?.withEnd(value));

  void applyPreset(Duration value) =>
      _updateRange(state.range?.withPreset(value));

  void shift(Duration value) => _updateRange(state.range?.shift(value));

  void _updateRange(QuoteTimeRange? range) {
    if (range != null &&
        state.status != QuoteTranscriptionStatus.transcribing) {
      emit(state.copyWith(range: range, message: null));
    }
  }

  Future<void> transcribe() async {
    final transcriptionContext = state.context;
    final range = state.range;
    if (transcriptionContext == null || range == null) {
      return;
    }
    emit(
      state.copyWith(
        status: QuoteTranscriptionStatus.transcribing,
        message: null,
      ),
    );
    try {
      await _transcribeRangeAndEmit(transcriptionContext, range);
    } catch (_) {
      _emitTranscriptionFailure();
    }
  }

  Future<void> _transcribeRangeAndEmit(
    QuoteTranscriptionContext transcriptionContext,
    QuoteTimeRange range,
  ) async {
    final text = await _application.transcribe(
      book: transcriptionContext.book,
      start: transcriptionContext.chapterStart + range.start,
      end: transcriptionContext.chapterStart + range.end,
    );
    if (text.trim().isEmpty) {
      _emitNoSpeechFailure();
      return;
    }
    _emitTranscriptionDraft(transcriptionContext, range, text);
  }

  void _emitNoSpeechFailure() => emit(
    state.copyWith(
      status: QuoteTranscriptionStatus.failure,
      message: AppMessage.noSpeechDetected,
      effectRevision: state.effectRevision + 1,
    ),
  );

  void _emitTranscriptionDraft(
    QuoteTranscriptionContext transcriptionContext,
    QuoteTimeRange range,
    String text,
  ) {
    final draft = TranscriptionDraft(
      book: transcriptionContext.book,
      text: text,
      start: transcriptionContext.chapterStart + range.start,
      end: transcriptionContext.chapterStart + range.end,
      chapterStart: range.start,
      chapterEnd: range.end,
      chapterTitle: transcriptionContext.chapterTitle,
    );

    emit(
      state.copyWith(status: QuoteTranscriptionStatus.complete, draft: draft),
    );
  }

  void _emitTranscriptionFailure() => emit(
    state.copyWith(
      status: QuoteTranscriptionStatus.failure,
      message: AppMessage.quoteTranscriptionFailed,
      effectRevision: state.effectRevision + 1,
    ),
  );

  Future<void> shareDraft(
    TranscriptionDraft draft,
    String text, {
    required String subject,
    ShareOrigin? origin,
  }) => _application.shareDraft(draft, text, subject: subject, origin: origin);
}
