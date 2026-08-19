import 'package:bookish_cactus_transcription/bookish_cactus_transcription.dart';
import 'package:bookish_player/core/foundation/result.dart';
import 'package:bookish_player/features/library/models/library_models.dart';
import 'package:bookish_player/features/transcription/models/speech_model.dart';
import 'package:bookish_player/features/transcription/models/transcription_download.dart';
import 'package:bookish_player/features/transcription/models/transcription_failure.dart';
import 'package:bookish_player/features/transcription/repos/transcription_repository.dart';

class BookishCactusTranscriptionRepository implements TranscriptionRepository {
  BookishCactusTranscriptionRepository(this._cactus);

  final CactusTranscriptionRepository _cactus;

  @override
  Future<void> reset() => _cactus.reset();

  @override
  Future<List<SpeechModel>> getModels({bool refresh = true}) async {
    final models = await _cactus.getModels(refresh: refresh);
    return [
      for (final model in models)
        SpeechModel(
          slug: model.slug,
          sizeMb: model.sizeMb,
          isDownloaded: model.isDownloaded,
        ),
    ];
  }

  @override
  Future<bool> isModelDownloaded(String slug) =>
      _cactus.isModelDownloaded(slug);

  @override
  Future<void> downloadModel(
    String slug, {
    TranscriptionDownloadProgress? onProgress,
  }) => _cactus.downloadModel(
    slug,
    onProgress: (progress, phase) => onProgress?.call(progress, switch (phase) {
      CactusDownloadPhase.downloading => TranscriptionDownloadPhase.downloading,
      CactusDownloadPhase.failure => TranscriptionDownloadPhase.failure,
    }),
  );

  @override
  Future<Result<String, TranscriptionFailure>> transcribeRange({
    required Audiobook book,
    required Duration start,
    required Duration end,
    required String model,
  }) async {
    final result = await _cactus.transcribeRange(
      source: CactusAudioSource(
        tracks: [
          for (final track in book.playableTracks)
            CactusAudioTrack(
              filePath: track.filePath,
              durationMs: track.durationMs,
            ),
        ],
      ),
      start: start,
      end: end,
      model: model,
    );
    return switch (result) {
      CactusTranscriptionSucceeded(:final text) => Result.success(text),
      CactusTranscriptionFailed() => const Result.failure(
        TranscriptionFailure.transcribe,
      ),
    };
  }
}
