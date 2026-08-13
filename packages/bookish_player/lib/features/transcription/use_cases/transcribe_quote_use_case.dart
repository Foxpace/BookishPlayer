part of 'quote_transcription_use_cases.dart';

@Environment('internal')
@injectable
class TranscribeQuoteUseCase {
  const TranscribeQuoteUseCase(this._transcription, this._preferences);

  final TranscriptionRepository _transcription;
  final TranscriptionPreferences _preferences;

  Future<String> call({
    required Audiobook book,
    required Duration start,
    required Duration end,
  }) async {
    final model = await _preferences.getSelectedModel() ?? 'whisper-tiny';
    return _transcription.transcribeRange(
      book: book,
      start: start,
      end: end,
      model: model,
    );
  }
}
