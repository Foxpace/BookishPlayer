import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../library/domain/audiobook.dart';
import '../../settings/domain/settings_repository.dart';
import '../../transcription/domain/transcription_repository.dart';
import '../domain/quote_share_repository.dart';
import '../domain/quote_time_range.dart';
import '../domain/transcription_draft.dart';
import 'quote_transcription_state.dart';

@injectable
class QuoteTranscriptionCubit extends Cubit<QuoteTranscriptionState> {
  QuoteTranscriptionCubit(this._transcription, this._settings, this._sharing)
    : super(const QuoteTranscriptionState());

  final TranscriptionRepository _transcription;
  final SettingsRepository _settings;
  final QuoteShareRepository _sharing;

  Audiobook? _book;
  String? _chapterTitle;
  Duration _chapterStart = Duration.zero;

  void prepare({
    required Audiobook book,
    required String? chapterTitle,
    required Duration chapterStart,
    required Duration chapterDuration,
    required Duration anchor,
  }) {
    _book = book;
    _chapterTitle = chapterTitle;
    _chapterStart = chapterStart;
    emit(
      QuoteTranscriptionState(
        status: QuoteTranscriptionStatus.ready,
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
    final book = _book;
    final range = state.range;
    if (book == null || range == null) {
      return;
    }
    emit(
      state.copyWith(
        status: QuoteTranscriptionStatus.transcribing,
        message: null,
      ),
    );
    try {
      final model = await _settings.getSpeechModel() ?? 'whisper-tiny';
      final text = await _transcription.transcribeRange(
        book: book,
        start: _chapterStart + range.start,
        end: _chapterStart + range.end,
        model: model,
      );
      if (text.trim().isEmpty) {
        emit(
          state.copyWith(
            status: QuoteTranscriptionStatus.failure,
            message: 'No speech was detected in this range.',
          ),
        );
        return;
      }
      emit(
        state.copyWith(
          status: QuoteTranscriptionStatus.complete,
          draft: TranscriptionDraft(
            book: book,
            text: text,
            start: _chapterStart + range.start,
            end: _chapterStart + range.end,
            chapterStart: range.start,
            chapterEnd: range.end,
            chapterTitle: _chapterTitle,
          ),
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: QuoteTranscriptionStatus.failure,
          message: error.toString(),
        ),
      );
    }
  }

  Future<void> shareDraft(String text, {ShareOrigin? origin}) async {
    final draft = state.draft;
    if (draft == null || text.trim().isEmpty) {
      return;
    }
    final author = draft.book.author.trim();
    final attribution = author.isEmpty
        ? draft.book.title
        : '${draft.book.title} — $author';
    final location = [
      ?draft.chapterTitle,
      '${_format(draft.chapterStart)}–${_format(draft.chapterEnd)}',
    ].join(' · ');
    await _sharing.share(
      text: '${text.trim()}\n\n$location\n— $attribution',
      subject: 'Quote from ${draft.book.title}',
      origin: origin,
    );
  }

  String _format(Duration value) {
    final hours = value.inHours;
    final minutes = value.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = value.inSeconds.remainder(60).toString().padLeft(2, '0');
    return hours > 0 ? '$hours:$minutes:$seconds' : '$minutes:$seconds';
  }
}
