import '../../../core/foundation/result.dart';
import '../../library/models/library_models.dart';
import '../models/speech_model.dart';
import '../models/transcription_download.dart';

abstract interface class TranscriptionRepository {
  Future<void> reset();

  Future<List<SpeechModel>> getModels({bool refresh = true});

  Future<bool> isModelDownloaded(String slug);

  Future<void> downloadModel(
    String slug, {
    TranscriptionDownloadProgress? onProgress,
  });

  Future<Result<String>> transcribeRange({
    required Audiobook book,
    required Duration start,
    required Duration end,
    required String model,
  });
}
