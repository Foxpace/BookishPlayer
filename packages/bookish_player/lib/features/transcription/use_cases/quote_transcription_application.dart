import 'dart:developer' as developer;

import 'package:injectable/injectable.dart';

import '../../../core/foundation/result.dart';
import '../../library/models/library_models.dart';
import '../../player/models/share_origin.dart';
import '../../player/repos/quote_share_repository.dart';
import '../../player/use_cases/quote_for_sharing.dart';
import '../models/transcription_draft.dart';
import '../repos/transcription_preferences.dart';
import '../repos/transcription_repository.dart';

@Environment('internal')
@injectable
class QuoteTranscriptionApplication {
  const QuoteTranscriptionApplication(
    this._transcription,
    this._preferences,
    this._sharing,
  );

  final TranscriptionRepository _transcription;
  final TranscriptionPreferences _preferences;
  final QuoteShareRepository _sharing;

  Future<Result<String>> transcribe({
    required Audiobook book,
    required Duration start,
    required Duration end,
  }) async {
    try {
      return await _transcribe(book: book, start: start, end: end);
    } catch (error, stackTrace) {
      developer.log(
        'Quote transcription request failed before Cactus returned a result: '
        'startMs=${start.inMilliseconds}, endMs=${end.inMilliseconds}',
        name: 'bookish.transcription',
        error: error,
        stackTrace: stackTrace,
      );
      return Result.failure(
        AppFailure.operationFailed('transcription.quote', error: error),
      );
    }
  }

  Future<Result<String>> _transcribe({
    required Audiobook book,
    required Duration start,
    required Duration end,
  }) async {
    final selected = await _preferences.getSelectedModel();
    final models = await _transcription.listModels();
    final model =
        models.any((item) => item.slug == selected && item.isDownloaded)
        ? selected!
        : models.any((item) => item.isDownloaded)
        ? models.firstWhere((item) => item.isDownloaded).slug
        : (models.isEmpty ? 'whisper-base' : models.first.slug);
    return _transcription.transcribeRange(
      book: book,
      start: start,
      end: end,
      model: model,
    );
  }

  Future<void> shareDraft(
    TranscriptionDraft draft,
    String text, {
    required String subject,
    ShareOrigin? origin,
  }) async {
    if (text.trim().isEmpty) {
      return;
    }
    await _sharing.share(
      text: quoteForSharing(
        book: draft.book,
        text: text,
        chapterTitle: draft.chapterTitle,
        start: draft.chapterStart,
        end: draft.chapterEnd,
      ),
      subject: subject,
      origin: origin,
    );
  }
}
